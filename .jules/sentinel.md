# Sentinel Journal - AndroidLibV2rayLite

## 2025-11-14 - Resource Leak and DoS in measureRequestDelay
**Vulnerability:** The `measureRequestDelay` function used `defer` inside a retry loop for closing HTTP response bodies, and it read the entire response body into `io.Discard` without a size limit. It also lacked URL scheme validation.
**Learning:** `defer` in Go only executes at function exit, not at the end of a loop iteration, which can cause resource leaks. Unbounded `io.Copy` on response bodies is a DoS risk.
**Prevention:** Wrap loop bodies in anonymous functions when using `defer` for resource cleanup. Always use `io.LimitReader` when consuming external data of unknown size. Validate URL schemes to mitigate SSRF.

## 2025-11-14 - Path Traversal in InitCoreEnv
**Vulnerability:** The custom `NewFileReader` implementation in `InitCoreEnv` used raw paths with `os.Stat` and `os.Open`, allowing for potential directory traversal attacks if the path was attacker-controlled.
**Learning:** Directly using user-provided or external paths in filesystem operations without normalization and validation is risky.
**Prevention:** Always use `filepath.Clean` and check for traversal patterns (e.g., `..` prefix) before using paths in `os` functions.
