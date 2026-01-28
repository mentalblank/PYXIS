## 2024-10-24 - Parallel Bash Workflows in CI
**Learning:** Sequential processing of independent network/IO tasks in Bash scripts within CI workflows is a major performance bottleneck. Bash's '&' background operator and 'wait' command allow for easy parallelization without complex dependencies.
**Action:** Identify loops iterating over independent items (like multiple file downloads or repo processing) and parallelize them using `&` and `wait`. Ensure local variables are used in functions to prevent state pollution between parallel subshells.

## 2024-10-24 - Bash set -e and Error Handling
**Learning:** GitHub Actions defaults to `set -e`. Code like `command; if [ $? -ne 0 ]; ...` is dangerous because `command` triggers immediate exit on failure before reaching the `if`.
**Action:** Use `if ! command; then ... fi` to properly handle errors in scripts that might run with `set -e`. This is also crucial for ensuring cleanup or signaling logic runs even when commands fail.
