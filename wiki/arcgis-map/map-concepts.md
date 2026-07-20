# Map Concepts

Sources: `raw/arcgis-map/Introduction to maps (2D)  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a map  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a web map  ArcGIS Maps SDK for JavaScript.md`.

A 2D ArcGIS map is a collection of geographic layers displayed through the [[map-component]]. It commonly includes a basemap and may include operational data layers, popups, labels, legends, layer styling, and other map configuration.

There are two common creation paths:

- Load a stored [[web-maps]] item from ArcGIS Online or ArcGIS Enterprise by setting `item-id` on `<arcgis-map>` or by creating a `WebMap` instance and assigning it to the component.
- Create a map from scratch by setting a `basemap`, `center`, and `zoom` directly on `<arcgis-map>`, or by creating a core `Map` instance and assigning it to the component's `map` property.

The map's initial visible area is controlled by viewpoint properties such as `center`, `zoom`, `scale`, or a portal item's saved viewpoint. After initialization, scripts can update component properties or use [[view-and-events]] methods such as `goTo`.

Use the 2D `arcgis-map` component for map views. The source material notes that 3D scenes use the `arcgis-scene` component instead.
