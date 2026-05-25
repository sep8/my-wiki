# DataModel

## Summary

`DataModel` is A2UI's JSON Pointer based reactive store for surface data.

## Explanation

Components do not need all values embedded in their props. They can bind to data paths, while `DataModel` stores and updates the data:

```text
updateDataModel({ path: "/items/0/name", value: "Cafe" })
Text.text = { path: "/items/0/name" }
```

Paths use JSON Pointer style:

- `/` or empty string means the root data object.
- `/user/name` reads or writes an object property.
- `/items/0` reads or writes an array element.

`set(path, value)` can replace the root, create intermediate objects or arrays, delete object properties when value is `undefined`, and notify relevant subscribers. It notifies exact paths, ancestor paths, and descendant paths, which lets both fine-grained and broad UI bindings update correctly.

The store uses Preact Signals internally. Object and array values are shallow-copied when signals update so renderer observers see identity changes.

## Related

[[surface-model]], [[data-context]], [[generic-binder]], [[basic-catalog]]
