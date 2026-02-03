BOLT'S JOURNAL - CRITICAL LEARNINGS ONLY:

## 2026-02-03 - Optimizing Syscalls and Resource Handling in Go
**Learning:** Attempting `os.Open` directly instead of checking `os.Stat` first reduces syscall overhead by ~50% for successful opens. Also, using `defer` inside loops for resource closure is a major anti-pattern that can lead to file descriptor exhaustion; explicit closure or anonymous functions are preferred.
**Action:** Always prioritize direct resource access with error handling over pre-check syscalls, and ensure resources opened in loops are closed within the same iteration.
