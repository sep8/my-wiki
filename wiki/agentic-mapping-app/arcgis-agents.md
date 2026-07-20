# ArcGIS Agents

## Summary

ArcGIS agents are prebuilt agents in the AI components package. The captured
documentation lists navigation, data exploration, and help agents.

## Agent Anatomy

An agent combines:

- a system prompt that defines behavior;
- context, which for ArcGIS agents is scoped to web-map layers;
- tools for operations such as layer queries or map navigation;
- output as text or a tool-driven map action.

Together, the prebuilt agents cover navigation, statistics, attribute queries,
and spatial queries. Their usable context depends on [[web-map-design]],
[[embeddings]], and [[layer-metadata]]. At capture time, only feature layers
were discoverable by ArcGIS agents; other layer types could still be displayed
in the map.

Use [[custom-agents]] for domain workflows or external services beyond these
prebuilt capabilities.

## Related

[[assistant-and-orchestration]], [[web-map-design]], [[custom-agents]]

## Sources

- [Introduction snapshot](<../../raw/agentic-mapping-app/Intro to building agentic mapping applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-introduction/), captured 2026-07-20)
- [Web map setup snapshot](<../../raw/agentic-mapping-app/Setup your web map for agentic applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-webmap-setup/), captured 2026-07-20)
