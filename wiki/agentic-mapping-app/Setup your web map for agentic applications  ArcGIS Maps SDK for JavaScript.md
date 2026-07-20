---
title: "Setup your web map for agentic applications | ArcGIS Maps SDK for JavaScript"
source: "https://developers.arcgis.com/javascript/latest/agentic-apps/ai-webmap-setup/"
author:
published:
created: 2026-07-20
description: "Tips for setting up web maps for agentic applications."
tags:
  - "clippings"
---
A [web map](https://developers.arcgis.com/javascript/latest/references/core/WebMap/) is the default context required for ArcGIS agents to function properly. To ensure the best experience when using AI components with web maps, consider the following setup instructions.

## Web map configuration

When creating a web map to be used with AI components, keep these recommendations in mind:

- **Simpler is better.** Only include layers that are necessary for the intended use cases of the Assistant component. This helps reduce visual complexity and improves agent performance.
- **Supported layer types.** Currently, only [Feature Layers](https://developers.arcgis.com/javascript/latest/references/core/layers/FeatureLayer/) are supported in ArcGIS agents. All other layers, including basemap layers, are excluded from Assistant component interactions. These layers may be included in the web map for display purposes, but they will not be discoverable by agents.
- **Good cartography.** Use good cartographic practices to ensure the map is visually clear and easy to understand for users. Be sure all web map properties used for data exploration (e.g. popups, labels, table contents) are well configured to ensure the best experience for users.
- **Scoped layers.** Try to keep layers scoped to a single topic or theme.
	- Set layer filters and show/hide to reflect intended purpose of the layers.
		- Avoid using layers with an excessive number of fields. If necessary, create [hosted feature layer views](https://doc.arcgis.com/en/arcgis-online/manage-data/create-hosted-views.htm) that only include relevant fields for AI interactions. Layers may have dozens of fields with data covering a variety of subjects; consider creating a view that only includes the most pertinent fields.
- **[Complete metadata](#layer-metadata)**
	- **Layers** must have meaningful names and metadata to help the agents understand their purpose.
		- **Fields** must have descriptive aliases and include field descriptions to provide additional context about the data.

Use the **[Item details assistant (beta)](https://doc.arcgis.com/en/arcgis-online/reference/item-details-assistant.htm)** to generate field and layer descriptions on your hosted feature layers and views. This can help save time and ensure that your layers and fields have the necessary metadata to be used.

## Embeddings

Web maps must have embeddings stored as a resource to the web map item to be consumed by agents in the `arcgis-assistant` component. Web map **embeddings** are vector representations of the layer titles and field metadata for all feature layers in the web map. This allows the agents to determine the layers and fields that are most relevant to the user’s natural language query before sending the information to the LLM. This is especially important for web maps with many layers and fields, as it improves the accuracy of agent responses.

To generate embeddings, you must have write permissions for the web map (i.e. either as the owner of the item or an admin in the organization).

The following are steps for generating embeddings for a web map:

1. Sign in to ArcGIS Online and open the web map item.
2. Navigate to the item settings page and scroll to the “Manage AI vector embeddings” section under “Web map”.
3. Click the “Generate Embeddings” button.
4. Wait for the process to complete. This may take some time depending on the number of layers and the number of fields in each layer within the web map.
5. Once the embeddings are generated, they will be stored as a resource to the web map item. The map is now ready to be used by the `arcgis-assistant` component in an agentic web mapping application.

## Layer metadata

For best results, ensure that your layers have good metadata, including descriptive layer names, field aliases, and field descriptions. This information will be included in the embeddings and used by agents to determine which layers and fields are most relevant to the user’s natural language query.

### Layers managed by your organization

If you own a layer item or have write access to it, you can use the Item details assistant (beta) to generate field descriptions and layer descriptions using generative AI, or you may write them yourself. Be sure to review all AI-generated content for accuracy.

You may only write/manage field descriptions for layers owned by your organization. This does not include layer items that are references to data owned by another organization, such as layers from ArcGIS Living Atlas.

### Layers not managed by your organization

If your web map includes layers that are not managed by your organization (e.g. ArcGIS Living Atlas layers), you will not be able to edit the metadata for those layers. However, you can still generate embeddings for these layers as long as they are included in your web map. It is best if these layers already have good metadata, including descriptive layer names, field aliases, and field descriptions.

If layers do not have layer descriptions or field descriptions, they will be generated by an LLM during the embedding generation process. Note that these generated descriptions may not be accurate and are not persisted in item metadata. They will only be represented in the generated embeddings. These generated descriptions are not reviewable or editable, so it is recommended to use layers with good metadata for the best experience when using AI components.