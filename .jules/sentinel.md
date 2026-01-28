## 2024-07-15 - Path Traversal in `InitCoreEnv`

**Vulnerability:** A path traversal vulnerability was identified in the `InitCoreEnv` function in `libv2ray_main.go`. The `envPath` parameter was not sanitized before being used to set the `v2ray.location.asset` environment variable.

**Learning:** This vulnerability existed because user-provided input was directly used in a file path without proper validation. An attacker could have provided a malicious path (e.g., `../../../../etc/passwd`) to access sensitive files on the system.

**Prevention:** To prevent this type of vulnerability in the future, all user-provided input that is used in file paths must be sanitized using `filepath.Clean`. This ensures that any directory traversal sequences are resolved and the path is safe to use.
