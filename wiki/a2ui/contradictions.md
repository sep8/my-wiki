# Contradictions & Cross-source Tensions — A2UI

No unresolved claim conflicts were found within the topic's current upstream-only scope.

The local-package analysis in `raw/a2ui/current-package-audit.md` is intentionally outside that scope, as documented in [[index]]. It describes a downstream wrapper and should not be treated as conflicting evidence about the upstream runtime.

## Version and catalog drift

- **Earlier notes** (`raw/a2ui/basic-catalog.md`, `raw/a2ui/react-renderer.md`) focus on v0.9 and use `https://a2ui.org/specification/v0_9/basic_catalog.json`; they also describe 24 basic functions.
- **Newer upstream checkout** (`raw/a2ui/google-A2UI/`) identifies v0.9.1 as the current production protocol, v1.0 as a release candidate, uses `https://a2ui.org/specification/v0_9/catalogs/basic/catalog.json`, and implements 25 basic functions.
- **Reconciliation:** treat this topic as documentation for the v0.9 protocol family, with v0.9.1 as the current production authority. Use the newer catalog ID and function count; consult the v1.0 evolution guide before adopting candidate-only behavior.
