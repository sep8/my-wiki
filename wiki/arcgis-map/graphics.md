# Graphics

Sources: `raw/arcgis-map/Add a point, line, and polygon  ArcGIS Maps SDK for JavaScript.md`.

Graphics are client-side visual elements for points, lines, polygons, and text. A graphic combines geometry, symbol, and optional attributes or popup information. They are useful for geographic data that is not backed by a database, such as a GPS location or an ad hoc sketch.

The tutorial flow imports `Graphic`, `Map`, and `GraphicsLayer`, creates a `GraphicsLayer`, then assigns a new map containing that layer to [[map-component]]:

```js
const [Graphic, Map, GraphicsLayer] = await $arcgis.import([
  "@arcgis/core/Graphic.js",
  "@arcgis/core/Map.js",
  "@arcgis/core/layers/GraphicsLayer.js",
]);

const viewElement = document.querySelector("arcgis-map");
const graphicsLayer = new GraphicsLayer();
viewElement.map = new Map({
  basemap: "arcgis/topographic",
  layers: [graphicsLayer],
});
```

Point graphics use point geometry with a marker symbol. Line graphics use polyline geometry with a line symbol. Polygon graphics use polygon geometry with a fill symbol. The tutorial notes that `Graphic` autocasts plain geometry and symbol objects when passed to the constructor.

Graphics layers are displayed above other map layers. Add graphics with `graphicsLayer.add(graphic)`. To show descriptive information, define attributes and popup content on the graphic, then let the map popup interaction display it or handle popup behavior explicitly through [[view-and-events]].
