# Agentic Mapping Applications

## Summary

An agentic mapping application uses natural language as its primary interface
for interacting with a web map and its data. In the ArcGIS Maps SDK model, the
`@arcgis/ai-components` package supplies the assistant UI and agent integration
points.

## Design Model

The conversational interface can make map workflows simpler and more
accessible, but it does not remove the need to define the application's scope.
The source recommends:

- explaining supported capabilities and showing example prompts;
- designing each custom agent around a specific task or workflow;
- preparing the web map deliberately for the questions and actions agents
  should support.

The interface, agents, map context, and data preparation are separate concerns.
The assistant coordinates interaction through [[assistant-and-orchestration]],
while [[web-map-design]] determines what built-in ArcGIS agents can understand
and act on.

## Related

[[assistant-and-orchestration]], [[arcgis-agents]], [[custom-agents]],
[[web-map-design]]

## Source

[Introduction to building agentic mapping applications](<../../raw/agentic-mapping-app/Intro to building agentic mapping applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-introduction/), captured 2026-07-20).
