---
title: "ArcGIS Maps SDK for JavaScript"
source: "https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/"
author:
published:
created: 2026-07-20
description: "Guide for building custom AI agents in the ArcGIS Maps SDK for JavaScript."
tags:
  - "clippings"
---
Developers can create custom agents to extend the capabilities of the `arcgis-assistant` component. Custom agents can be designed to handle specific tasks or workflows that are unique to the application’s requirements or an organization’s data. A custom agent could be created to provide specialized data analysis, integrate with external services, or support domain-specific queries.

For example, given a web map with zoning and planning data for a city, you could create an agent that looks up information from documents or an external service that provides additional details about the rules and regulations for a parcel selected by a user.

Custom agents can be created using one of the following methods:

- [Agent utilities](#agent-utilities) - This method uses the agent utilities provided in the AI components package to create agents with consistent patterns and reduced boilerplate.
- [LangGraph](#langgraph) - For more controlled and complex agent workflows, you can use LangGraph to define the orchestration graph for your custom agent. This method allows for more advanced state management, multi-step workflows, and integration with external services.

Use agent utilities when you want the fastest path to a custom agent with less boilerplate and built-in patterns for common workflows; use LangGraph when you need full control over orchestration, state, and multi-step logic across complex agent behavior. If your use case is mostly straightforward tool-calling and routing, start with agent utilities; if you expect advanced branching, custom graph design, or deep workflow control, choose LangGraph.

## Agent utilities

You can build custom agents using the utilities provided in the AI components package. These agent utilities simplify the creation and management of AI agents by providing higher-level building blocks with consistent patterns and reduced boilerplate. Developers can choose the agent or workflow pattern that matches their use case and add tools, middleware, or human-in-the-loop behavior as needed.

The agent utilities are organized into three main categories: agents, workflows and middlewares/tools.

- **Agents** are the core building blocks that define the behavior and capabilities of an AI agent. They can be created using one of the available agent types:
	- [LLMAgent](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/LLMAgent/) - Uses an LLM as the decision maker and can call tools to complete a user request
		- [FunctionAgent](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/FunctionAgent/) - Runs deterministic custom code you provide to process state and return structured results
		- [WorkflowAgent](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/WorkflowAgent/) - Orchestrates one or more agents through of of the defined workflow patterns: [Sequential](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/workflows/SequentialWorkflow/), [Router](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/workflows/RouterWorkflow/), [Conditional](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/workflows/ConditionalWorkflow/), [Parallel](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/workflows/ParallelWorkflow/), [Loop](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/workflows/LoopWorkflow/), or [Switch](https://developers.arcgis.com/javascript/latest/references/ai-components/agent-utils/workflows/SwitchWorkflow/)
- **Workflows** only apply to Workflow agents. They define the sequence of steps and decision-making logic that a Workflow agent follows to complete a task. Workflows can be created using patterns like Conditional, Loop, Parallel, Router, Sequential, or Switch.
- **Middlewares and tools** extend the functionality of agents by providing additional capabilities, such as calling external services, processing data, or supporting human-in-the-loop interactions. Examples include `FunctionTool` and other custom tools that can be integrated into an agent’s workflow.

You can then create an agent by choosing one of the three agent types and providing the required properties. All of these agents have the following required properties in common:

- `name` should be brief and understandable as it may be displayed in tooling / output. Names should be unique to avoid registration conflicts.
- `description` is important as it helps the orchestrator behind the assistant component determine which agent to use for a given user input. Be sure to write a clear and descriptive description that outlines the intended purpose and capabilities of the agent along with example user prompts that should trigger the agent.

Each agent has additional properties required for its specific operation, such as

| Agent | Property | Notes |
| --- | --- | --- |
| FunctionAgent | execute | Contains core logic of agent, receives current state and returns structured output and/or messages for display. |
| LLMAgent | tools | An array of FunctionTools available for use during execution. |
| WorkflowAgent | workflow | Defines the workflow implementation the agent runs, such as Sequential, Router, Conditional, Parallel, Loop, or Switch. |

See the documentation for each agent type for more details on the required properties and their usage.

##### Follow these steps to create a custom agent using agent utilities

Building custom agents with agent utilities does not require installing third-party dependencies, but you may use [Zod](https://zod.dev/) (v4) to enforce structured outputs, schemas, and typing. If you choose to use Zod, you must explicitly install it in your application. Do not rely on it to be installed through `@arcgis/ai-components`. Run the following commands to install the required packages:

```txt
npm install @arcgis/ai-components zod
```

Afterward, you’ll need to individually import each component you use.

```js
import "@arcgis/ai-components/components/arcgis-assistant";
import "@arcgis/ai-components/components/arcgis-assistant-agent";
```

Then you can create a custom agent by instantiating one of the available agent types and providing the required properties. For example, to create a custom `LLMAgent`, you would define its `name`, `description`, `prompt`, `modelTier`, and `tools` properties.

```js
const myCustomAgent = new LLMAgent({
  name: "My Custom Agent",
  description: "An agent that does custom things. Use this agent when users want to do custom things.",
  prompt: myCustomAgentPrompt,
  modelTier: "fast",
  tools: myCustomAgentTools,
});
```

Once the agent is defined, it can be registered to the [`arcgis-assistant`](https://developers.arcgis.com/javascript/latest/references/ai-components/components/arcgis-assistant/) component by creating an [`arcgis-assistant-agent`](https://developers.arcgis.com/javascript/latest/references/ai-components/components/arcgis-assistant-agent/) element and setting its `agent` property to the custom agent object. The `arcgis-assistant-agent` element should then be appended as a child of the `arcgis-assistant` component.

```js
const assistant = document.querySelector("arcgis-assistant");
const assistantAgent = document.createElement("arcgis-assistant-agent");

assistantAgent.agent = myCustomAgent.registration;
assistant.appendChild(assistantAgent);
```

#### Agent utils examples

See the following samples for examples of how to build custom agents using agent utilities:

- [AI Components - agent utils with tools (React)](https://github.com/Esri/jsapi-resources/tree/main/templates/ai-components-agent-utils-tools-react) - This sample shows how to create a custom agent that may call tools on behalf of the user. The agent defined in this example includes one tool that calculates a service area from natural language input. Download this code to experiment with adding additional tools to the agent.
- [AI Components - agent utils using HIL (React)](https://github.com/Esri/jsapi-resources/tree/main/templates/ai-components-agent-utils-hil-react) - This sample shows how to create a custom agent with a human-in-the-loop (HIL) workflow that asks the user for confirmation before creating a maintenance request. Human-in-the-loop provides an interrupt in an agentic workflow that prompts the human/user for additional information prior to proceeding with the workflow. This is often used to safeguard against LLMs making decisions that lead to destructive actions. For example, you may use an interrupt to prompt the user to confirm whether to proceed with given parameters before executing a tool. The LLM may also not have confidence in a user’s intent and could prompt them to provide more information in freeform text. You can also present deterministic options as a menu to the user before proceeding with a workflow.

## LangGraph

If you need more control over the definition of your custom agent, you can use LangGraph to define the agent’s orchestration graph. LangGraph is a JavaScript library that allows developers to create complex workflows and manage state in a structured manner. LangGraph is useful when you need full control over orchestration, state, and multi-step logic across complex agent behavior.

##### Follow these steps to create a custom agent using agent utilities

Building custom agents with LangGraph requires installing the following third-party dependencies:

- [LangGraph](https://docs.langchain.com/oss/javascript/langgraph/overview) (v1.2) is used to define the orchestration graph agents and tools, manages global state and LLM calls, and defines multi-step workflows
- [LangChainJS](https://docs.langchain.com/oss/javascript/langchain/overview) (v1.3) manages LLM and embeddings calls
- [Zod](https://zod.dev/) (v4) enforces structured outputs, schemas, and typing

You must explicitly install LangChainJS and LangGraph in your application. Do not rely on it to be installed through `@arcgis/ai-components`.

```txt
npm install @arcgis/ai-components @langchain/langgraph langchain zod
```

Afterward, you’ll need to individually import each component you use.

```js
import "@arcgis/ai-components/components/arcgis-assistant";
import "@arcgis/ai-components/components/arcgis-assistant-agent";
```

You can then create an agent by defining an [AgentRegistration](https://developers.arcgis.com/javascript/latest/references/ai-components/utils/index/#AgentRegistration) object. This object includes properties such as `id`, `name`, `description`, `createGraph`, and `workspace`. The `createGraph` property defines the agent’s orchestration graph using LangGraph, while the `workspace` property defines the agent’s context and relevant variables using an `AnnotationRoot` type from LangGraph.

The description is important as it helps the orchestrator behind the assistant component determine which agent to use for a given user input. Be sure to write a clear and descriptive description that outlines the intended purpose and capabilities of the agent along with example user prompts that should trigger the agent.

```js
const myCustomAgent = {
  id: "my-custom-agent",
  name: "My Custom Agent",
  description: "An agent that does custom things. Use this agent when users want to do custom things.",
  createGraph: {
    // StateGraph definition using LangGraph
  },
  workspace: {
    // AnnotationRoot definition using LangGraph
    // relevant variables and context required by the agent
  },
};
```

Once the agent object is defined, it can be registered to the [`arcgis-assistant`](https://developers.arcgis.com/javascript/latest/references/ai-components/components/arcgis-assistant/) component by creating an [`arcgis-assistant-agent`](https://developers.arcgis.com/javascript/latest/references/ai-components/components/arcgis-assistant-agent/) element and setting its `agent` property to the custom agent object. The `arcgis-assistant-agent` element should then be appended as a child of the `arcgis-assistant` component.

```js
const assistant = document.querySelector("arcgis-assistant");
const assistantAgent = document.createElement("arcgis-assistant-agent");

assistantAgent.agent = myCustomAgent;
assistant.appendChild(assistantAgent);
```

#### Custom agents with LangGraph examples

See the following samples for examples of how to build custom agents using LangGraph:

- [AI Components - custom agent with tools (React)](https://github.com/Esri/jsapi-resources/tree/main/templates/ai-components-custom-agent-tools-react) - This sample shows how to create a custom agent that may call tools on behalf of the user. The agent defined in this example includes one tool that calculates a service area from natural language input. Download this code to experiment with adding additional tools to the agent.
- [AI Components - custom agent using HIL (React)](https://github.com/Esri/jsapi-resources/tree/main/templates/ai-components-custom-agent-hil-react) - This sample shows how to create a custom agent with a human-in-the-loop (HIL) workflow that asks the user for confirmation before creating a maintenance request. Human-in-the-loop provides an interrupt in an agentic workflow that prompts the human/user for additional information prior to proceeding with the workflow. This is often used to safeguard against LLMs making decisions that lead to destructive actions. For example, you may use an interrupt to prompt the user to confirm whether to proceed with given parameters before executing a tool. The LLM may also not have confidence in a user’s intent and could prompt them to provide more information in freeform text. You can also present deterministic options as a menu to the user before proceeding with a workflow.