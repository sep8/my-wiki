# Access and Security

## Summary

At capture time, using AI components required an authenticated named user in
an ArcGIS Online organization. A public web map did not make the AI experience
anonymous.

## End-User Requirements

The signed-in user needed:

- access to the web map and its layers;
- an organization with AI assistants enabled;
- beta applications and capabilities not blocked by organization security
  settings;
- the role privilege for using AI assistants.

Trial and public accounts were excluded. API keys could not replace named-user
authentication for public-facing AI component applications.

These are product-policy claims from a beta snapshot. Recheck current ArcGIS
documentation before making an authentication or deployment decision.

## Related

[[availability-and-pricing]], [[agentic-mapping-applications]]

## Source

[AI components FAQ](<../../raw/agentic-mapping-app/Frequently Asked Questions  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/), captured 2026-07-20).
