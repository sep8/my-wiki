# View And Events

Sources: `raw/arcgis-map/Introduction to maps (2D)  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Using a View with components  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Create a web app using components  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/References  ArcGIS Maps SDK for JavaScript.md`.

The [[map-component]] owns the map view. Scripts usually wait for the view before reading the loaded map, portal item, or view-dependent state.

Two readiness patterns appear in the source set:

```js
const viewElement = document.querySelector("arcgis-map");
await viewElement.viewOnReady();
```

```js
const viewElement = document.querySelector("arcgis-map");
viewElement.addEventListener("arcgisViewReadyChange", () => {
  const { portalItem } = viewElement.map;
});
```

The visible position can be updated by setting properties such as `zoom`, `center`, or `scale`. For animated transitions, use `goTo(target, options)`. The source material shows `goTo({ center: [-114, 39] }, { duration: 5000 })`.

For click interaction, listen to `arcgisViewClick`. The introduction source disables default popup behavior with `popupEnabled = false`, then calls `hitTest(event.detail)` and opens a custom popup with `openPopup({ location, title, content })` when results are found.

When using portal-backed [[web-maps]], view-ready handlers can read `viewElement.map.portalItem` to populate layout components with title, snippet, thumbnail, and item URL. The same lifecycle point is used to hide Calcite loading indicators. See [[ui-components]].
