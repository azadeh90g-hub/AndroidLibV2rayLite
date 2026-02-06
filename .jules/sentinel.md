# Sentinel Security Journal

## 2025-02-06 - Hardening Latency Measurement and File Access

**Vulnerability:**
1. SSRF and protocol smuggling in `measureRequestDelay` via unvalidated URL schemes.
2. Resource exhaustion (DoS) in `measureRequestDelay` due to unbounded response body reading and file descriptor leaks (deferred close inside a loop).
3. Path traversal in `InitCoreEnv` via unvalidated custom file reader paths.

**Learning:**
- Go's `http.Client.Do` followed by `io.Copy(io.Discard, resp.Body)` without a limit is dangerous if the URL is user-controlled.
- `defer` inside a loop is a common but risky pattern that keeps resources open until the function returns, not just the loop iteration.
- Custom `v2ray-core` file system handlers need explicit validation as they can bypass standard path protections if not implemented carefully.

**Prevention:**
- Always validate URL schemes (e.g., allow only `http`/`https`) for utility network requests.
- Use `io.LimitReader` when reading response bodies from untrusted sources.
- Wrap loop bodies in anonymous functions when using `defer` to ensure immediate resource release.
- Use `filepath.Clean` and prefix checks (e.g., `strings.HasPrefix(path, "..")`) to mitigate path traversal in file handlers.
