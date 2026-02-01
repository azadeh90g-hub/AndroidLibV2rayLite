## 2025-05-14 - Harden latency measurement logic
**Vulnerability:** Resource exhaustion (file descriptor leakage), potential DoS via large response bodies, and SSRF/protocol-smuggling via unvalidated URL schemes in `measureRequestDelay`.
**Learning:** In Go, using `defer` inside a loop for resource cleanup (like `resp.Body.Close()`) is a trap because the resources are not released until the function returns. Shadowing package names (like `url`) with variable names is also a common source of compilation errors when new imports are added.
**Prevention:** Wrap loop-internal resource management in an anonymous function closure. Use `io.LimitReader` for all external data reads. Explicitly validate URL schemes even when using high-level libraries like `http.Client`.
