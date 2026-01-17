## 2024-05-20 - Path Traversal in Asset Loading

**Vulnerability:** Path traversal in `corefilesystem.NewFileReader`'s custom implementation. The use of `filepath.Split` on a user-provided path allows for directory traversal attacks, as it does not properly sanitize the input. An attacker could craft a path like `../../../../../../etc/passwd` to read sensitive files from the system.

**Learning:** The custom file reader was intended to fall back to Android's asset manager, but it unsafely handled file paths. Any code that constructs file paths from external input must rigorously sanitize it to prevent traversal.

**Prevention:** Sanitize file paths using `filepath.Clean` and validate them to reject absolute paths or those containing `..` traversal sequences. This prevents attackers from accessing files outside the intended directory while preserving legitimate subdirectory access.
