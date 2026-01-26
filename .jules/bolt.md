## 2024-05-23 - [Destructive Reproduction Scripts]
**Learning:** I accidentally overwrote critical configuration files (`download_files.json`, `release_versions.json`) by running a reproduction script in the repo root that used the same filenames.
**Action:** Always use a temporary directory (e.g., `mktemp -d`) or distinct filenames (e.g., `test_download_files.json`) for reproduction scripts. Always verify file integrity after running local scripts.
