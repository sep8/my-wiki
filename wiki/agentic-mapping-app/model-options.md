# Model Options

## Summary

The ability to choose an LLM depends on which agent implementation path is
used.

## Constraints at SDK v5.1

- Models used by SDK-provided ArcGIS agents and assistant orchestration could
  not be replaced.
- Custom agents built with [[agent-utilities]] could not use a developer-chosen
  LLM.
- [[langgraph-agents]] could use another LLM when the developer provided a
  backend for accessing it.

These constraints are version-specific and should be verified before choosing
an architecture.

## Related

[[custom-agents]], [[agent-utilities]], [[langgraph-agents]],
[[availability-and-pricing]]

## Source

[AI components FAQ](<../../raw/agentic-mapping-app/Frequently Asked Questions  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/), captured 2026-07-20).
