# Web Map Embeddings

## Summary

ArcGIS agents require embeddings stored as a resource on the web-map item.
These vectors represent feature-layer titles and field metadata, helping an
agent select relevant layers and fields before sending context to the LLM.

## Generation

The user generating embeddings must own the web map or have administrative
write access. In ArcGIS Online, the documented flow is:

1. Open the signed-in web-map item.
2. Open item settings and find **Manage AI vector embeddings** under **Web
   map**.
3. Generate embeddings and wait for processing to finish.
4. Confirm the resulting resource is stored with the web-map item.

The captured source does not state whether embeddings refresh automatically
after changes to [[layer-metadata]]. Verify or regenerate them before relying
on updated metadata in agent retrieval.

## Related

[[web-map-design]], [[layer-metadata]], [[arcgis-agents]]

## Source

[Setup your web map for agentic applications](<../../raw/agentic-mapping-app/Setup your web map for agentic applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-webmap-setup/), captured 2026-07-20).
