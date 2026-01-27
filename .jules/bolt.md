## 2024-05-23 - Redundant API Calls in CI/CD
**Learning:** The build workflow was making redundant GitHub API calls (`releases/latest`) for every repository twice: once to check for updates, and again to get download URLs.
**Action:** Cache the API response from the first check and reuse it during the download phase to reduce API usage and latency.
