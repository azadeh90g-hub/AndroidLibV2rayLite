## 2025-02-02 - [Actionable Error Messages]
**Learning:** For library projects (APIs), the "User Experience" is actually "Developer Experience" (DX). Providing actionable error messages that suggest *how* to fix the issue (e.g., "call StartLoop before...") is a high-impact UX win for developers.
**Action:** Always look for passive error messages and refactor them to be active and instructional.

## 2025-02-02 - [Onboarding Friction]
**Learning:** Build scripts that fail due to missing directories or unclear dependencies are a major UX hurdle.
**Action:** Ensure all setup scripts use `mkdir -p` for target directories and provide clear dependency checks (`command -v`) at the start.
