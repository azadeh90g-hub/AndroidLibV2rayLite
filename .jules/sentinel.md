## 2025-05-15 - [Path Traversal and DoS Hardening]
**Vulnerability:** Path traversal in `InitCoreEnv` and resource exhaustion (DoS) in `measureRequestDelay`.
**Learning:** `filepath.Clean` is a necessary (but often not sufficient) first step to sanitize path inputs. Using `defer` inside a loop in Go for resource cleanup (like closing HTTP response bodies) leads to file descriptor leaks until the function returns. Unbounded `io.Copy` of remote content into `io.Discard` can be exploited for DoS.
**Prevention:** Always sanitize path inputs before use. Close resources explicitly within loop iterations. Use `io.CopyN` or similar limits when processing untrusted remote content.
