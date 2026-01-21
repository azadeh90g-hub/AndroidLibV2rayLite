## 2024-07-25 - Unpinned Asset Downloads in `gen_assets.sh`
**Vulnerability:** The `gen_assets.sh` script downloads `geoip.dat` and `geosite.dat` from a `:latest` URL without any checksum verification.
**Learning:** This introduces a significant supply chain risk. If the source repository is compromised, a malicious actor could replace the assets with compromised versions, leading to a breach. Pinning to a specific version and verifying checksums is essential.
**Prevention:** Always download external dependencies from a specific, known-good version and validate their integrity using a strong checksum algorithm like SHA256.
