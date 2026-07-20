# Web Maps

Sources: `raw/arcgis-map/Introduction to maps (2D)  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a web map  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Using a View with components  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Create a web app using components  ArcGIS Maps SDK for JavaScript.md`.

A web map is a stored ArcGIS map definition. It contains map settings such as basemap, layers, layer styling, popups, legends, labels, and initial viewpoint. ArcGIS Online or ArcGIS Enterprise stores web maps as portal items with unique item IDs.

The simplest component path is to set `item-id` on [[map-component]]:

```html
<arcgis-map item-id="237b9584339446a0b56317b5962a4971"></arcgis-map>
```

The JavaScript path is to create a core `WebMap` and assign it to the component:

```js
const WebMap = await $arcgis.import("@arcgis/core/WebMap.js");
const mapElement = document.querySelector("arcgis-map");

mapElement.map = new WebMap({
  portalItem: {
    id: "237b9584339446a0b56317b5962a4971",
    portal: "https://www.arcgis.com",
  },
});
```

Once loaded, a web map applies its saved basemap, layers, styles, and popup definitions automatically. Tutorials use `arcgisViewReadyChange` to wait until the view is ready before reading `viewElement.map.portalItem` for UI metadata such as title, snippet, thumbnail, and item page URL. See [[view-and-events]] and [[ui-components]].
