# Contradictions & Cross-source Tensions — ArcGIS Map

## Basemap authentication scope

- **Claim A** (the general basemap tutorials): use an access token with the Basemaps privilege.
- **Claim B** (`Display a map (basemap session)  ArcGIS Maps SDK for JavaScript.md`): the basemap-session flow requires an ArcGIS Location Platform account; ArcGIS Online and ArcGIS Enterprise accounts are not supported.
- **Reconciliation:** these are different usage models. A generic basemap token does not imply that its account is eligible for the session-based billing flow. See [[setup-and-authentication]] and [[basemaps]].

## Popup component transition

- **Claim A** (map examples): set `popup-component-enabled` to use the popup component integration.
- **Claim B** (`References  ArcGIS Maps SDK for JavaScript.md`): this switch is beta and will no longer be needed when the popup component becomes the default in version 6.0.
- **Reconciliation:** the attribute applies to the current pre-6.0 transition documented by the source set. Recheck or remove it when targeting version 6.0 or later. See [[map-component]] and [[ui-components]].
