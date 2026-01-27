BOLT'S JOURNAL - CRITICAL LEARNINGS ONLY:

## 2024-07-16 - Go Defer in Loops Causes Resource Leaks
**Learning:** In Go, `defer` statements are function-scoped, not block-scoped. Using `defer` inside a loop to close a resource (like an `http.Response.Body`) will not close the resource at the end of each iteration. Instead, all deferred calls will stack up and only execute when the entire function returns. This leads to resource leaks, consuming memory and file descriptors, which can crash the application under load.
**Action:** When a resource is created and must be cleaned up within a loop, always call the cleanup function (e.g., `Close()`) manually on all execution paths within the loop. Do not use `defer` for this purpose.