# Web Map Design

## Summary

A web map is the default context for ArcGIS agents. The source recommends a
small, deliberate set of feature layers aligned with the assistant's intended
workflows.

## Configuration Guidance

- Include only layers necessary for intended use cases.
- Expect ArcGIS agents to discover feature layers only. Other layers and
  basemap layers may be displayed but are excluded from assistant interaction.
- Configure cartography, popups, labels, and table content so results are clear
  to people as well as agents.
- Keep each layer focused on one topic, using visibility and filters to express
  its intended scope.
- Avoid exposing excessive fields. A hosted feature-layer view can present a
  smaller, relevant field set.
- Give layers and fields meaningful metadata; see [[layer-metadata]].

After configuration, generate the [[embeddings]] required by the assistant.

## Related

[[arcgis-agents]], [[embeddings]], [[layer-metadata]]

## Source

[Setup your web map for agentic applications](<../../raw/agentic-mapping-app/Setup your web map for agentic applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-webmap-setup/), captured 2026-07-20).
