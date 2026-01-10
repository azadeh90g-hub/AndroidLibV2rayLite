## 2024-05-20 - Unverified Asset Download in gen_assets.sh
**Vulnerability:** The `gen_assets.sh` script downloaded assets from a URL without verifying their checksums.
**Learning:** This exposed a supply chain vulnerability where a compromised download source could have injected malicious code into the application.
**Prevention:** The script was updated to fetch SHA256 checksums for the assets and verify them before moving them into the project. All future asset fetching should include a similar verification step.