# Basic Catalog

## Summary

`basicCatalog` is A2UI v0.9's framework-neutral UI vocabulary plus function contract, with renderer-specific implementations in React, Lit, or other frameworks.

## Explanation

The canonical catalog id used by the current React and Lit implementations is:

```text
https://a2ui.org/specification/v0_9/catalogs/basic/catalog.json
```

Agent `createSurface.catalogId` must match a catalog registered with the client [[message-processor]].

The basic catalog includes 18 components:

- content: `Text`, `Image`, `Icon`, `Video`, `AudioPlayer`
- layout/container: `Row`, `Column`, `List`, `Card`, `Tabs`, `Modal`, `Divider`
- input/interaction: `Button`, `TextField`, `CheckBox`, `ChoicePicker`, `Slider`, `DateTimeInput`

The current runtime implementation also includes 25 functions across arithmetic, comparison, logic, strings, validation, formatting, and actions.

The catalog's most important design rule is component graph composition. Containers reference child component ids instead of embedding inline child JSON. Dynamic `ChildList` can bind a template component to an array path:

```json
{
  "children": {
    "componentId": "restaurant-card",
    "path": "/restaurants"
  }
}
```

This makes `basicCatalog` a strong MVP vocabulary for agents that need to emit composable UI without generating arbitrary code.

## Related

[[generic-binder]], [[data-context]], [[react-renderer]], [[schema-prompt-parser]]
