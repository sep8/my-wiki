# Map Component

Sources: `raw/arcgis-map/References  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Introduction to maps (2D)  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a map  ArcGIS Maps SDK for JavaScript.md`.

`<arcgis-map>` is the Map Components entry point for displaying a 2D ArcGIS map. It wraps a map view and handles map rendering, user interactions, popups, viewpoint state, and child UI components.

Common attributes and properties:

- `item-id` loads a saved [[web-maps]] portal item.
- `basemap` selects a named [[basemaps]] style when creating a map from scratch.
- `center`, `zoom`, and `scale` set the visible portion of the map.
- `map` can be assigned a core `Map` or `WebMap` instance from JavaScript.
- `popup-component-enabled` enables the beta popup component integration in the current pre-6.0 examples; the reference says it will be unnecessary when that component becomes the default in 6.0. See [[contradictions]].

Typical inline map:

```html
<arcgis-map basemap="arcgis/topographic" center="-118.805, 34.020" zoom="13">
  <arcgis-zoom slot="top-left"></arcgis-zoom>
</arcgis-map>
```

The component exposes methods used by [[view-and-events]], including `viewOnReady()`, `goTo()`, `hitTest()`, and `openPopup()`. It emits lifecycle and interaction events such as `arcgisViewReadyChange` and `arcgisViewClick`.

The component is also a container with named slots. Child components such as zoom, legend, layer list, and search are placed into positions like `top-left`, `top-right`, `bottom-right`, or `bottom-left`. See [[ui-components]].
