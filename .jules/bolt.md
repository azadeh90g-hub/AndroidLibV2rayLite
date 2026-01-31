BOLT'S JOURNAL - CRITICAL LEARNINGS ONLY:

## 2025-05-22 - Defer in loop and redundant syscalls
**Learning:** Found two common Go performance anti-patterns in this codebase: using `defer` inside a loop for HTTP response bodies, and performing `os.Stat` before `os.Open`. The first prevents connection reuse and can lead to resource exhaustion, while the second adds unnecessary syscall overhead during initialization.
**Action:** Always check for `defer` inside loops and optimize filesystem access by using `os.Open` directly and checking the error.
