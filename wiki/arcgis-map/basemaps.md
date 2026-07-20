# Basemaps

Sources: `raw/arcgis-map/Display a map  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Change the basemap style  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a custom basemap style  ArcGIS Maps SDK for JavaScript.md`, `raw/arcgis-map/Display a map (basemap session)  ArcGIS Maps SDK for JavaScript.md`.

A basemap provides the background reference layer for a map. In the simplest case, set a named basemap style on [[map-component]]:

```html
<arcgis-map basemap="arcgis/topographic" center="-118.805, 34.020" zoom="13"></arcgis-map>
```

Basemap style can also be changed at runtime by updating the map component or the underlying map's basemap. The change-basemap tutorial builds a style dropdown and updates the style from user input.

Custom basemap styles use explicit layers instead of only a named `basemap` string. The custom basemap tutorial creates a vector tile layer for the styled basemap, an image tile layer, and then combines them into a basemap assigned to the map.

Basemap sessions are a newer flow for basemap service access. The basemap-session tutorial creates a `BasemapSession` from an access token, reads its basemap style service URL, and uses that URL when creating the map. This keeps basemap requests associated with a session rather than only direct API-key access.

All basemap tutorials in the source set require an access token with basemap privileges. See [[setup-and-authentication]].

The basemap-session usage model has a narrower account requirement: its source supports ArcGIS Location Platform accounts, not ArcGIS Online or ArcGIS Enterprise accounts. See [[contradictions]].
