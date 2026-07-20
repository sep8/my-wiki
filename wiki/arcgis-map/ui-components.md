# UI Components

Sources: `raw/arcgis-map/Introduction to maps (2D)  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a map  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a web map  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Using a View with components  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Create a web app using components  ArcGIS Maps SDK for JavaScript.md`.

The [[map-component]] accepts child components and HTML elements in named slots. Common slot positions in the source material include `top-left`, `top-right`, and `bottom-right`.

Common map UI components:

- `arcgis-zoom` adds zoom controls, often in `top-left`.
- `arcgis-legend` displays layer legend information, often in `bottom-right`.
- `arcgis-layer-list` displays operational layers and can be configured with `listItemCreatedFunction`.
- `arcgis-search` can be added in a map slot for address or place search.

The web-map tutorial combines a portal item with zoom and legend components:

```html
<arcgis-map item-id="WEBMAP-ID" popup-component-enabled>
  <arcgis-zoom slot="top-left"></arcgis-zoom>
  <arcgis-legend slot="bottom-right"></arcgis-legend>
</arcgis-map>
```

The example's `popup-component-enabled` switch is a beta transition flag in the current reference and is scheduled to become unnecessary in version 6.0. See [[contradictions]].

For app layout, the component tutorials use Calcite components such as `calcite-shell`, `calcite-navigation`, `calcite-navigation-logo`, and `calcite-loader`. The map sits inside the shell, often under the navigation header. A view-ready handler can populate the navigation logo from a [[web-maps]] portal item and hide the loader once the view is ready.

The layer-list tutorial shows a `listItemCreatedFunction` that attaches a legend panel to each non-group layer. This pattern is useful when the layer list should expose per-layer legend details inside the same control.
