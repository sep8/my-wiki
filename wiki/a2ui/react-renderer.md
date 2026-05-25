# React Renderer

## Summary

`@a2ui/react` renders existing `SurfaceModel` instances into React component trees; it does not own agent transport or session orchestration.

## Explanation

The v0.9 React package exports `A2uiSurface`, React component implementation helpers, and the React implementation of [[basic-catalog]]. Its input is a surface created and maintained by [[message-processor]].

The render chain is:

```text
<A2uiSurface surface={surface} />
  -> root DeferredChild
  -> ComponentContext
  -> catalog component implementation
  -> GenericBinder
  -> resolved props
  -> React component
```

`A2uiSurface` starts from component id `root`. `DeferredChild` can show placeholders for missing children, which supports progressive or streaming updates where a parent references a child before the child definition arrives.

Regular React catalog components should use `createComponentImplementation(...)`, which wraps [[generic-binder]] with `useSyncExternalStore`. Binderless components are an escape hatch for custom subscription or inspection behavior.

Application or package code remains responsible for creating the processor, subscribing to surface creation/deletion, handling loading and errors, normalizing agent output, and sending actions back to the agent.

## Related

[[a2ui-runtime-flow]], [[message-processor]], [[surface-model]], [[generic-binder]], [[basic-catalog]]

## Contradictions

See [[contradictions]] for the current-package tension between `@a2ui/react` and `@a2ui-sdk/react`.
