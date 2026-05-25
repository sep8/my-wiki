# DataContext

## Summary

`DataContext` is a scoped view over `DataModel` that resolves dynamic values, data bindings, function calls, and actions.

## Explanation

Each rendered component gets a context path. Relative paths are resolved against that path:

```text
base path: /restaurants/0
{ path: "name" } -> /restaurants/0/name
{ path: "/user/id" } -> /user/id
```

`DataContext` handles three common value forms:

- literal values such as strings, numbers, booleans, arrays
- data bindings such as `{ path: "name" }`
- function calls such as `{ call: "formatCurrency", args: ..., returnType: "string" }`

Function calls go through the surface catalog invoker. This makes catalog functions part of the client-side expression runtime, not just helper utilities.

Important limitation: resolving a dynamic value does not recursively resolve arbitrary nested objects. Action event context resolves top-level dynamic values, and deeper dynamic behavior depends on schema-marked fields handled by [[generic-binder]].

## Related

[[data-model]], [[generic-binder]], [[basic-catalog]], [[surface-model]]
