# Setup And Authentication

Sources: `raw/arcgis-map/Display a map  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Create a web app using components  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Add a point, line, and polygon  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a map (basemap session)  ArcGIS Maps SDK for JavaScript.md`.

ArcGIS Maps SDK examples in the source material use either the CDN script or npm packages.

For a simple browser page, load the SDK with a module script such as `https://js.arcgis.com/5.1/`. The SDK then exposes component custom elements and `$arcgis.import()` for loading core API modules like `@arcgis/core/Map.js`, `@arcgis/core/Graphic.js`, or `@arcgis/core/layers/GraphicsLayer.js`.

For a Vite app, install `@arcgis/map-components` and import only the components used by the page, for example:

```js
import "@arcgis/map-components/components/arcgis-map";
import "@arcgis/map-components/components/arcgis-zoom";
import "@arcgis/map-components/components/arcgis-layer-list";
```

Calcite layouts require separate Calcite component imports, such as `@esri/calcite-components/components/calcite-shell`.

Access to ArcGIS location services such as basemaps requires an access token with the required privileges. The tutorials set the token through the global `esriConfig` object before loading other Esri libraries:

```html
<script>
  var esriConfig = {
    apiKey: "YOUR_ACCESS_TOKEN",
  };
</script>
```

The basemap session flow still requires an access token, but it exchanges that token for a `BasemapSession` and uses the session's basemap style service URL in the map configuration. This flow requires an ArcGIS Location Platform account; the source says ArcGIS Online and ArcGIS Enterprise accounts are not supported. See [[basemaps]] and [[contradictions]].
