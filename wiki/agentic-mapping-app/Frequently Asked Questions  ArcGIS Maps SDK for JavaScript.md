---
title: "Frequently Asked Questions | ArcGIS Maps SDK for JavaScript"
source: "https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/"
author:
published:
created: 2026-07-20
description: "Frequently asked questions about AI components in the ArcGIS Maps SDK for JavaScript."
tags:
  - "clippings"
---
For the purposes of this document, the term “AI components” refers to the AI components (beta) available in the ArcGIS Maps SDK for JavaScript. See the [AI components (beta) documentation](https://developers.arcgis.com/javascript/latest/references/ai-components/) for more information about these components.

## Getting started and examples

### How do I get started with AI components?

See the [AI components documentation](https://developers.arcgis.com/javascript/latest/references/ai-components/) for information on how to get started with AI components, including how to use the CDN or npm for importing components, and how to build applications using both pre-built and custom agents. You can also refer to the [AI Assistant component sample](https://developers.arcgis.com/javascript/latest/sample-code/ai-assistant/) for a complete example demonstrating how to build agentic applications using the CDN.

### Where can I see examples of applications built with AI components?

See the [AI Assistant sample](https://developers.arcgis.com/javascript/latest/sample-code/ai-assistant/) for an example of how to build an agentic application using AI components. Additionally, you can download the [Custom agent samples](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/#custom-agent-examples) which provide examples of how to create custom agents for usage in agentic applications.

## Access and security

### Who can use apps built with AI components?

The following are requirements for end users to access and interact with applications built with AI components:

- Signed in named users of a ArcGIS Online organization. This excludes trial accounts and public accounts.
- The signed in user must have access to the web map and its layers. This typically means the user must have viewer access to the web map or the web map must be shared publicly.
- AI assistants must be enabled in the organization settings of the signed in user. See [Configure AI assistants—ArcGIS Online Help](https://doc.arcgis.com/en/arcgis-online/administer/configure-assistants.htm).
- Beta apps and capabilities must not be [blocked](https://doc.arcgis.com/en/arcgis-online/administer/configure-security.htm#ESRI_SECTION2_CE007AFEA465444887036BD6D7038639) in the organization settings of the signed in user.
- The signed in user must have the [role privilege](https://doc.arcgis.com/en/arcgis-online/administer/privileges-for-roles-orgs.htm) to use AI assistants.

If any of these requirements are not met, please contact your ArcGIS Online administrator to update your account and organization settings.

### Do users need to sign in even if the web map is shared publicly?

Yes, users still need to sign in with a named user account to use AI components, even if the web map is shared publicly. This is because AI components require access to organizational settings and privileges that are tied to named user accounts. Also, interacting with LLMs have associated costs, so requiring sign in helps ensure that only authorized users are able to access AI capabilities.

### Can I use an API key to make AI components work in a public-facing application?

No. [API keys](https://developers.arcgis.com/javascript/latest/secure-resources/#api-keys) cannot currently be used to enable AI components in public-facing applications. AI components require users to sign in with a named user account that has the necessary privileges to access AI assistant capabilities. We are currently evaluating the security implications and cost structure of allowing API keys to enable AI components for public-facing applications.

### Are the AI components compatible with ArcGIS Enterprise?

Not at this moment. However, support is planned for a future ArcGIS Enterprise release, likely 12.2, which is tentatively scheduled for late 2026.

## Costs and pricing

### How much does it cost end users to interact with agents via the AI components?

There will be no cost to end users or organizations for using AI components during the beta period. After the beta period, there may be costs associated with using AI components based on the number of interactions with agents and LLM calls made through the components. This cost structure will be determined during a preview release and communicated transparently to customers when the components are released for general availability.

## Agents and models

### Can I use the Assistant component without ArcGIS agents?

Yes. The Assistant component must have at least one registered [agent](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-introduction/#agents) to function. This agent can be either an [ArcGIS agent](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-introduction/#arcgis-agents) or a [custom agent](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/) that you create. The Assistant component itself does not have any built-in agentic capabilities and relies on agents to provide functionality and context for interactions.

### Can I create my own agents?

Yes, developers can create [custom agents](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/) to extend the capabilities of the `arcgis-assistant` component. Custom agents can be designed to handle specific tasks or workflows that are unique to the application’s requirements or an organization’s data. For example, a custom agent could be created to provide specialized data analysis, integrate with external services, or support domain-specific queries.

See the [Custom agents](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/) guide for more information on building custom agents.

### Can I provide my own LLM for agents to use?

You cannot change the LLM used by agents provided by the JavaScript Maps SDK, including the LLM used for agent orchestration. However, you may use whatever LLM you like when building custom agents [with LangGraph](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/#langgraph) as long as you set up your own backend for accessing those LLMs. As of v5.1, you cannot use your own LLM for building custom agents using the [agent utilities](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/#agent-utilities) provided by the JavaScript Maps SDK.

### Why did my agent stop working after upgrading to the latest JS SDK version?

At v5.1, the ArcGIS Assistant orchestrator-agent contract uses structured inputs and outputs instead of message-only exchanges to improve reliability for multi-step workflows, routing, and shared state management. This may have caused some agents to stop working if they were not updated to handle the new structured inputs and outputs. The following changes were made to the orchestrator-agent contract:

- **Orchestrator → Agent**: Agents now receive a structured `agentExecutionContext` object (for example: userRequest, assignedTask, messages, priorSteps, sharedState).
- **Agent → Orchestrator**: Agents now return a structured `AgentResult` object, including outputMessage, status, summary, and an optional sharedStatePatch.
- Migration guidance: update existing agents to
- The orchestrator continues to normalize missing or invalid fields for compatibility, but explicit structured responses are recommended.

## Feedback

### How can I provide feedback or request features for AI components?

We welcome your feedback and feature requests for AI components! Please submit any feedback or requests through [Esri Support](https://support.esri.com/en-us/contact) or [Esri Community](https://community.esri.com/t5/arcgis-maps-sdk-for-javascript/ct-p/arcgis-api-for-javascript).