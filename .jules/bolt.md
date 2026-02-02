BOLT'S JOURNAL - CRITICAL LEARNINGS ONLY:

## 2026-02-02 - Resource Management and Syscall Optimization
**Learning:** Using 'defer' inside a loop in Go accumulates closures and deferred calls until the function returns, which can cause resource leaks (e.g., file descriptors). Wrapping the loop body in an anonymous function allows 'defer' to execute at the end of each iteration. Additionally, 'os.Open' can be used directly without a preceding 'os.Stat' to save a syscall in the common case where a file exists.
**Action:** Always wrap loop bodies containing 'defer' in an anonymous function and favor EAFP (Easier to Ask for Forgiveness than Permission) for file operations to reduce redundant syscalls.
