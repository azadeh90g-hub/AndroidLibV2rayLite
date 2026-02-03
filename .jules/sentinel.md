## 2025-05-14 - Security Hardening in Latency Measurement and File Access

**Vulnerability:** Path traversal in custom file reader and multiple issues in HTTP latency measurement (SSRF via protocol smuggling, DoS via large responses, and resource leak via improper `defer` usage).

**Learning:**
1. `defer` inside a loop in Go is a common trap; it only executes at function exit, leading to resource exhaustion if the loop runs many times.
2. Custom file readers in libraries bridging different environments (like Android assets and standard OS files) often omit standard path validation, creating path traversal risks.
3. Input validation (like URL schemes) and resource limits (like `io.LimitReader`) are essential defense-in-depth measures even for internal measurement tools.

**Prevention:**
- Always wrap loop bodies with resource cleanup in an anonymous function if using `defer`.
- Normalize and validate paths using `filepath.Clean` and prefix checks before any file operation.
- Strictly validate URL schemes for any function taking a user-provided URL.
- Use `io.LimitReader` or `io.CopyN` when reading potentially untrusted or unneeded response bodies.
