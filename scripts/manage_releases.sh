#!/bin/bash

# Configuration
GITHUB_TOKEN="${GITHUB_TOKEN:-$1}"
MANIFEST_FILE="manifest.json"
RELEASE_DIR="$PWD/release"
DOWNLOADS_DIR="$PWD/downloads"
MIN_UPDATES=3
EVENT_NAME="${EVENT_NAME:-workflow_dispatch}"
MAX_PARALLEL=8

# Initialize
OLD_MANIFEST=$(cat "$MANIFEST_FILE")
MANIFEST="$OLD_MANIFEST"
TEMP_DATA_DIR=$(mktemp -d)
mkdir -p "$RELEASE_DIR" "$DOWNLOADS_DIR" "$TEMP_DATA_DIR/logs" "$TEMP_DATA_DIR/versions"

# Helper: Parallel Download/Extract
process_repo_downloads() {
    local repo="$1" json_file="$2" repo_config="$3"
    echo "  [STARTED] $repo"
    
    echo "$repo_config" | jq -c ".files[]?" | while read -r file_entry; do
        [ -z "$file_entry" ] && continue
        
        PATTERN=$(echo "$file_entry" | jq -r '.file // empty')
        [ -z "$PATTERN" ] && continue
        
        MANDATORY=$(echo "$file_entry" | jq -r '.mandatory // false')
        ARCHIVE_FILE=$(echo "$file_entry" | jq -r '.archive_file // empty')
        ADDITIONAL=$(echo "$file_entry" | jq -c '.additional_files // []')
        
        JQ_REGEX="${PATTERN//\*/.*}"
        
        jq -r ".assets[]? | select(.name | test(\"$JQ_REGEX\")) | .name + \" \" + .browser_download_url" "$json_file" | while read -r name url; do
            [ -z "$name" ] || [ -z "$url" ] && continue
            
            DL_PATH="$DOWNLOADS_DIR/$name"
            curl -sL -H "Authorization: token $GITHUB_TOKEN" -o "$DL_PATH" "$url" || { [ "$MANDATORY" = "true" ] && exit 1; continue; }
            
            IS_ARCHIVE=false
            if [[ "$name" =~ \.(zip|tar\.gz|7z)$ ]]; then
                IS_ARCHIVE=true
                temp_ext_dir=$(mktemp -d)
                echo "    Extracting $name..."
                case "$name" in
                    *.zip)    unzip -qo "$DL_PATH" ${ARCHIVE_FILE:+"$ARCHIVE_FILE"} -d "$temp_ext_dir" ;;
                    *.tar.gz) tar -xzf "$DL_PATH" ${ARCHIVE_FILE:+"--wildcards --strip-components=1"} -C "$temp_ext_dir" ${ARCHIVE_FILE:+"$ARCHIVE_FILE"} ;;
                    *.7z)     7z x "$DL_PATH" -o"$temp_ext_dir" -y ${ARCHIVE_FILE:+"$ARCHIVE_FILE"} ;;
                esac
                
                # Handle additional files
                if [ "$ADDITIONAL" != "[]" ]; then
                    echo "$ADDITIONAL" | jq -c '.[]?' | while read -r add_entry; do
                        [ -z "$add_entry" ] && continue
                        ap=$(echo "$add_entry" | jq -r '.file // empty')
                        echo "$add_entry" | jq -r '.destinations?[] // empty' | while read -r dest; do
                            [ -z "$dest" ] || [ -z "$ap" ] && continue
                            mkdir -p "$dest"
                            find "$temp_ext_dir" -name "$ap" -exec cp -R {} "$dest/" \;
                        done
                    done
                fi
                
                if [ -n "$ARCHIVE_FILE" ]; then
                    (
                        cd "$temp_ext_dir"
                        shopt -s globstar nullglob
                        for entry in $ARCHIVE_FILE; do
                            cp -R "$entry" "$RELEASE_DIR/"
                        done
                    )
                else
                    cp -R "$temp_ext_dir"/* "$RELEASE_DIR/"
                fi
                rm -rf "$temp_ext_dir"
            fi
            
            if [ "$IS_ARCHIVE" = "false" ]; then
                echo "$file_entry" | jq -r '.target_paths?[] // empty' | while read -r target; do
                    [ -z "$target" ] && continue
                    echo "    Copying $name to $target"
                    mkdir -p "$target"
                    cp -R "$DL_PATH" "$target/"
                done
            fi
        done
    done
    echo "  [FINISHED] $repo"
}

# 1. Parallel Update Check
echo "Checking for updates..."
REPOS=$(echo "$MANIFEST" | jq -r '.repos | keys[]')
for repo in $REPOS; do
    (
        REPO_SAFE="${repo//\//_}"; JSON_FILE="$TEMP_DATA_DIR/$REPO_SAFE.json"
        curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$repo/releases/latest" > "$JSON_FILE"
        LATEST=$(jq -r ".tag_name // empty" "$JSON_FILE")
        CURRENT=$(echo "$OLD_MANIFEST" | jq -r ".repos[\"$repo\"].version // \"0\"")
        
        if [ -n "$LATEST" ] && [ "$CURRENT" != "$LATEST" ]; then
            echo "$LATEST" > "$TEMP_DATA_DIR/versions/$REPO_SAFE"
            if [ "$CURRENT" = "0" ]; then
                echo "- **$repo**: $LATEST" > "$TEMP_DATA_DIR/logs/new_$REPO_SAFE"
            else
                echo "- **$repo**: $CURRENT to $LATEST" > "$TEMP_DATA_DIR/logs/upd_$REPO_SAFE"
            fi
        fi
    ) &
    [ $(jobs -r | wc -l) -ge $MAX_PARALLEL ] && wait -n
done; wait

# 2. Check for Removals and Config Changes
REMOVED_LOG=""
CONFIG_LOG=""
for repo in $(echo "$OLD_MANIFEST" | jq -r '.repos | keys[]'); do
    if ! echo "$REPOS" | grep -q "^$repo$"; then
        REMOVED_LOG+="- **$repo"$'\n'
    else
        OLD_CONFIG=$(echo "$OLD_MANIFEST" | jq -c ".repos[\"$repo\"] | del(.version)")
        NEW_CONFIG=$(echo "$MANIFEST" | jq -c ".repos[\"$repo\"] | del(.version)")
        [ "$OLD_CONFIG" != "$NEW_CONFIG" ] && CONFIG_LOG+="- **$repo"$'\n'
    fi
done

# Process Version Updates
UPDATES_COUNT=$(ls "$TEMP_DATA_DIR/versions" | wc -l)
NEW_LOG=$(cat "$TEMP_DATA_DIR/logs"/new_* 2>/dev/null || echo "")
CHANGES_LOG=$(cat "$TEMP_DATA_DIR/logs"/upd_* 2>/dev/null || echo "")

for f in "$TEMP_DATA_DIR/versions"/*; do
    [ -f "$f" ] || continue
    REPO_NAME=$(basename "$f" | sed 's/_/\//'); NEW_VER=$(cat "$f")
    MANIFEST=$(echo "$MANIFEST" | jq ".repos[\"$REPO_NAME\"].version = \"$NEW_VER\"")
done

# 3. Decide if we continue
if [ "$UPDATES_COUNT" -ge "$MIN_UPDATES" ] || [ -n "$REMOVED_LOG" ] || [ -n "$CONFIG_LOG" ] || [ "$EVENT_NAME" = "workflow_dispatch" ]; then
    echo "updates_found=true" >> $GITHUB_OUTPUT
    CUR_VER=$(echo "$MANIFEST" | jq -r '.build_info.version'); NEW_VER=$((CUR_VER + 1))
    DATE=$(date +%Y%m%d); MANIFEST=$(echo "$MANIFEST" | jq ".build_info.version = $NEW_VER | .build_info.last_updated = \"$DATE\"")
    echo "tag=$NEW_VER" >> $GITHUB_OUTPUT; echo "date=$DATE" >> $GITHUB_OUTPUT

    # Parallel Downloads
    echo "Downloading and processing files..."
    for repo in $REPOS; do
        REPO_SAFE="${repo//\//_}"; JSON_FILE="$TEMP_DATA_DIR/$REPO_SAFE.json"; REPO_CONFIG=$(echo "$MANIFEST" | jq -c ".repos[\"$repo\"]")
        process_repo_downloads "$repo" "$JSON_FILE" "$REPO_CONFIG" &
        [ $(jobs -r | wc -l) -ge $MAX_PARALLEL ] && wait -n
    done; wait
    echo "$MANIFEST" > "$MANIFEST_FILE"

    # 4. Generate GitHub Summary & Release Body
    SUMMARY="### Build $NEW_VER Summary ($DATE)"$'\n'
    BODY=""

    if [ -n "$NEW_LOG" ]; then
        SUMMARY+="#### Added"$'\n'"$NEW_LOG"$'\n'
        BODY+="### Added"$'\n'"$NEW_LOG"$'\n'
    fi
    if [ -n "$CHANGES_LOG" ]; then
        SUMMARY+="#### Updated"$'\n'"$CHANGES_LOG"$'\n'
        BODY+="### Updated"$'\n'"$CHANGES_LOG"$'\n'
    fi
    if [ -n "$CONFIG_LOG" ]; then
        SUMMARY+="#### Config Changes"$'\n'"$CONFIG_LOG"$'\n'
        BODY+="### Configuration Changes"$'\n'"$CONFIG_LOG"$'\n'
    fi
    if [ -n "$REMOVED_LOG" ]; then
        SUMMARY+="#### Removed"$'\n'"$REMOVED_LOG"$'\n'
        BODY+="### Removed"$'\n'"$REMOVED_LOG"$'\n'
    fi

    if [ -z "$BODY" ]; then
        SUMMARY+="Manual build triggered."$'\n'
        BODY="Manual Build."
    fi

    echo "$SUMMARY" >> $GITHUB_STEP_SUMMARY
    
    echo "RELEASE_BODY<<EOF" >> $GITHUB_ENV
    echo "$BODY" >> $GITHUB_ENV
    echo "EOF" >> $GITHUB_ENV
else
    echo "updates_found=false" >> $GITHUB_OUTPUT
fi
rm -rf "$TEMP_DATA_DIR"
