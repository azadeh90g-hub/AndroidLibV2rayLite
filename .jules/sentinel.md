## 2026-02-05 - SSRF and DoS in Measurement Functions
**Vulnerability:** The `measureRequestDelay` function allowed any URL scheme and consumed the entire response body without limits, creating SSRF and DoS risks. Additionally, it leaked file descriptors by using `defer` inside a retry loop.
**Learning:** Network measurement tools in libraries are often overlooked for security hardening. Even if the library's purpose is proxying, utility functions for latency should still be restricted to expected protocols (http/https) and have resource bounds.
**Prevention:** Always validate schemes for utility HTTP requests, use `io.LimitReader` when consuming response bodies, and wrap loop bodies in anonymous functions when using `defer` to ensure immediate resource release.
