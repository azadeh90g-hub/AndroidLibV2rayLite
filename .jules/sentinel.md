## 2024-07-19 - Enforce Minimum TLS 1.2
**Vulnerability:** The application's HTTP clients did not enforce a minimum TLS version. This could allow a network attacker to force a downgrade to an older, insecure TLS protocol (e.g., TLS 1.0), making the communication vulnerable to eavesdropping or tampering.
**Learning:** Simply using HTTPS is not enough. It is critical to explicitly configure HTTP clients to reject outdated and insecure protocol versions to protect against downgrade attacks. The default Go `http.Client` does not enforce a modern minimum version.
**Prevention:** For all HTTP clients making external requests, always configure the `TLSClientConfig` with a `MinVersion` of at least `tls.VersionTLS12` to ensure a strong, modern security posture.
