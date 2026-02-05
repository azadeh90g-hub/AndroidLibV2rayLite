# BOLT'S JOURNAL - CRITICAL LEARNINGS ONLY

## 2025-05-13 - String Concatenation vs fmt.Sprintf
**Learning:** In Go, `fmt.Sprintf` is significantly more expensive than string concatenation (`+`) for simple templates because it uses reflection and parses the format string at runtime. For high-frequency paths like statistics querying or connection dialing, this overhead adds up.
**Action:** Use string concatenation for simple templates in performance-critical paths. Always document the optimization with comments as per persona instructions.
