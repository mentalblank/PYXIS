#!/bin/bash

# Directories
RELEASE_DIR="release"
ATMOSPHERE_CONFIG="$RELEASE_DIR/atmosphere/config"
ATMOSPHERE_HOSTS="$RELEASE_DIR/atmosphere/hosts"
BOOTLOADER_DIR="$RELEASE_DIR/bootloader"
BOOTLOGOS_DIR="$BOOTLOADER_DIR/bootlogos"
AIO_UPDATER_CONFIG="$RELEASE_DIR/config/aio-switch-updater"
SYSPATCH_CONFIG="$RELEASE_DIR/config/sys-patch"

mkdir -p "$ATMOSPHERE_CONFIG" "$ATMOSPHERE_HOSTS" "$BOOTLOGOS_DIR" "$AIO_UPDATER_CONFIG" "$SYSPATCH_CONFIG" "$BOOTLOADER_DIR/res"

# 1. Atmosphere Configuration
CONFIG_SRC="$RELEASE_DIR/atmosphere/config_templates"
if [ -d "$CONFIG_SRC" ]; then
    cp "$CONFIG_SRC/override_config.ini" "$ATMOSPHERE_CONFIG/"
    cp "$CONFIG_SRC/system_settings.ini" "$ATMOSPHERE_CONFIG/"
    cp "$CONFIG_SRC/exosphere.ini" "$RELEASE_DIR/exosphere.ini"
fi

[ -f "$ATMOSPHERE_CONFIG/override_config.ini" ] && {
    sed -i -e 's/^; override_key_0=!R/override_key_0=R/' \
           -e 's/^; override_any_app=true/override_any_app=false/' "$ATMOSPHERE_CONFIG/override_config.ini"
}

[ -f "$ATMOSPHERE_CONFIG/system_settings.ini" ] && {
    sed -i -e 's/^; fatal_auto_reboot_interval = u64!0x0/fatal_auto_reboot_interval = u64!0x1/' \
           -e 's/^; power_menu_reboot_function = str!payload/power_menu_reboot_function = str!payload/' \
           -e 's/^; add_defaults_to_dns_hosts = u8!0x1/add_defaults_to_dns_hosts = u8!0x1/' \
           -e 's/^; dmnt_cheats_enabled_by_default = u8!0x1/dmnt_cheats_enabled_by_default = u8!0x0/' "$ATMOSPHERE_CONFIG/system_settings.ini"
}

[ -f "$RELEASE_DIR/exosphere.ini" ] && {
    sed -i -e 's/^blank_prodinfo_sysmmc=0/blank_prodinfo_sysmmc=1/' \
           -e 's/^blank_prodinfo_emummc=0/blank_prodinfo_emummc=1/' "$RELEASE_DIR/exosphere.ini"
}

# 2. Sys-FTPD-10K Config
[ -f "$RELEASE_DIR/config/sys-ftpd-10k/config.ini" ] && {
    sed -i 's/^anonymous:=1/anonymous:=0/' "$RELEASE_DIR/config/sys-ftpd-10k/config.ini"
}

# 3. Host Blocking
cat <<EOF | tee "$ATMOSPHERE_HOSTS/default.txt" "$ATMOSPHERE_HOSTS/emummc.txt" > /dev/null
# Block Nintendo Servers
127.0.0.1 *nintendo.*
127.0.0.1 *nintendoswitch.*
127.0.0.1 *nintendo-europe.com
95.216.149.205 *conntest.nintendowifi.net
95.216.149.205 *ctest.cdn.nintendo.net
EOF

# 4. Bootlogo and Icons
cp -r image/bootlogos/* "$BOOTLOGOS_DIR/"
cp -r image/icon/* "$BOOTLOADER_DIR/res/"

# 5. Bootloader Config
cat <<EOF > "$BOOTLOADER_DIR/hekate_ipl.ini"
[config]
autoboot=0
autoboot_list=0
bootwait=3
backlight=100
noticker=1
autohosoff=1
autonogc=1
updater2p=1
bootprotect=1

[Fusee]
icon=bootloader/res/icon_atmosphere.bmp
payload=bootloader/payloads/fusee.bin
customlogo=1
logopath=bootloader/bootlogos/bootlogo_pyxis_fusee.bmp

[Lockpick]
icon=bootloader/res/icon_lockpick.bmp
payload=bootloader/payloads/Lockpick_RCM.bin
customlogo=1
logopath=bootloader/bootlogos/bootlogo_pyxis_lockpick.bmp

[CFW (emuMMC)]
pkg3=atmosphere/package3
kip1patch=nosigchk
emummcforce=1
atmosphere=1
icon=bootloader/res/icon_hekate.bmp
usb3force=1
customlogo=1
logopath=bootloader/bootlogos/bootlogo_pyxis_emu.bmp
id=cfw-emu

[CFW (sysMMC)]
pkg3=atmosphere/package3
kip1patch=nosigchk
atmosphere=1
emummc_force_disable=1
icon=bootloader/res/icon_sysnand.bmp
usb3force=1
customlogo=1
logopath=bootloader/bootlogos/bootlogo_pyxis_sys.bmp
id=cfw-sys

[Stock (sysMMC)]
pkg3=atmosphere/package3
emummc_force_disable=1
stock=1
kip1patch=nogc
icon=bootloader/res/icon_stock.bmp
usb3force=1
customlogo=1
logopath=bootloader/bootlogos/bootlogo_pyxis_stock.bmp
id=ofw-sys
EOF

cat <<EOF > "$BOOTLOADER_DIR/nyx.ini"
[config]
themebg=2d2d2d
themecolor=167
entries5col=0
timeoff=2d3f1b00
homescreen=0
verification=1
umsemmcrw=0
jcdisable=0
jcforceright=0
bpmpclock=1
EOF

# Get Hekate .bin filename and create boot.ini
shopt -s nullglob
hekate_files=("$RELEASE_DIR"/hekate_ctcaer_*.bin)
if [ ${#hekate_files[@]} -gt 0 ]; then
    HEKATE_NAME=$(basename "${hekate_files[0]}")
    cat <<EOF > "$RELEASE_DIR/boot.ini"
[payload]
file=$HEKATE_NAME
EOF
fi

# 6. Sys-patch Config
cat <<EOF > "$SYSPATCH_CONFIG/config.ini"
[options]
patch_sysmmc=1
patch_emummc=1
logging=0
version_skip=1
EOF

# 7. AIO Updater Config
cat <<EOF > "$AIO_UPDATER_CONFIG/custom_packs.json"
{
	"ams": {
		"[PACK] PYXIS AIO": "https://github.com/MentalBlank/PYXIS/releases/latest/download/PYXIS_SwitchAIO.zip"
	}
}
EOF

cat <<EOF > "$AIO_UPDATER_CONFIG/hide_tabs.json"
{
	"about": false,
	"atmosphere": true,
	"cfw": true,
	"firmwares": false,
	"cheats": false,
	"custom": false,
	"outdatedtitles": false,
	"jccolor": false,
	"pccolor": false,
	"downloadpayload": false,
	"rebootpayload": false,
	"netsettings": false,
	"browser": false,
	"move": false,
	"cleanup": false,
	"language": false
}
EOF

cat <<EOF > "$AIO_UPDATER_CONFIG/preserve.txt"
/atmosphere/config/
/bootloader/hekate_ipl.ini
/bootloader/nyx.ini
/config/sys-clk/
/config/status-monitor/
/config/ultrahand/config.ini
/config/ultrahand/theme.ini
/config/ultrahand/overlays.ini
/config/ultrahand/packages.ini
/config/sys-ftpd/
/config/sys-ftpd-10k/
/config/Fizeau/
/config/MissionControl/
/config/sys-con/
/config/sys-patch/
EOF

# Cleanup
rm -f "$RELEASE_DIR/README.md"
