# Layer Metadata

## Summary

Layer names, layer descriptions, field aliases, and field descriptions supply
semantic context for ArcGIS agents and are represented in [[embeddings]].

## Managed Layers

For layers owned by the organization, authors can write descriptions directly
or use the Item details assistant (beta). AI-generated descriptions should be
reviewed for accuracy before use.

## External Layers

Metadata on layers owned by another organization, such as Living Atlas layers,
cannot be edited by the consuming organization. Such layers can still be
embedded. If descriptions are missing, the embedding process may generate
temporary descriptions with an LLM. Those generated descriptions are neither
persisted to item metadata nor available for review or editing, so existing
high-quality metadata is preferable.

## Related

[[web-map-design]], [[embeddings]], [[arcgis-agents]]

## Source

[Setup your web map for agentic applications](<../../raw/agentic-mapping-app/Setup your web map for agentic applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-webmap-setup/), captured 2026-07-20).
