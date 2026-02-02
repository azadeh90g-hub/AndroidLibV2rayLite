## 2025-05-15 - Hardening Latency Measurement and File Access

**Vulnerability:** The `measureRequestDelay` function was susceptible to Denial-of-Service (DoS) via unlimited response body reading and resource exhaustion due to `defer` being used inside a loop. Additionally, `InitCoreEnv` lacked path validation, allowing potential path traversal.

**Learning:** In Go, using `defer` inside a loop for resource cleanup (like closing HTTP response bodies) is a common anti-pattern that leads to file descriptor leakage. Furthermore, reading from external HTTP sources without a limit (e.g., using `io.LimitReader`) creates a DoS vector if the remote server returns an unexpectedly large body.

**Prevention:** Always wrap resource cleanup in an anonymous function or close resources explicitly when inside a loop. Use `io.LimitReader` when reading from untrusted sources to bound resource consumption. For file access, use `filepath.Clean` and validate that paths do not contain parent-relative segments (`..`) or escape intended directories.
