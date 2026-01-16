# Sentinel's Journal - Critical Learnings

This journal is for logging CRITICAL security learnings only.

- A security vulnerability pattern specific to this codebase
- A security fix that had unexpected side effects or challenges
- A rejected security change with important constraints to remember
- A surprising security gap in this app's architecture
- A reusable security pattern for this project

DO NOT journal routine work.

Format: `## YYYY-MM-DD - [Title]
**Vulnerability:** [What you found]
**Learning:** [Why it existed]
**Prevention:** [How to avoid next time]`

## 2024-05-20 - Path Traversal in Custom File Reader
**Vulnerability:** The custom `NewFileReader` function in `libv2ray_main.go` did not sanitize the `path` input, allowing a malicious actor to use `../` to access files and directories outside of the intended asset directory.
**Learning:** The vulnerability existed because the custom file reader implementation did not account for malicious input. It trusted the `path` argument without proper validation, creating a classic path traversal vulnerability.
**Prevention:** Always sanitize and validate user-controllable input, especially when it is used for file system operations. Use standard library functions like `filepath.Clean` and check for directory traversal sequences (`../`) and absolute paths.
