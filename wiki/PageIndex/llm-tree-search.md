# LLM Tree Search

## Summary
The simplest [[tree-search]] strategy: hand the LLM the JSON [[tree-index]] (titles + summaries) and the query, ask it to return the list of relevant `node_id`s. Slower than vector retrieval but transparent and easy to inject expert knowledge into.

## Explanation

### Basic prompt
```text
You are given a query and the tree structure of a document.
You need to find all nodes that are likely to contain the answer.

Query: {query}
Document tree structure: {PageIndex_Tree}

Reply in the following JSON format:
{
  "thinking": <your reasoning about which nodes are relevant>,
  "node_list": [node_id1, node_id2, ...]
}
```

### Injecting expert knowledge / user preference
Unlike vector RAG (where adapting to domain knowledge often means fine-tuning the embedding model), here you just *add the rules to the prompt*:

```text
Expert Knowledge of relevant sections: {Preference}
```

Example preference snippet:
> "If the query mentions EBITDA adjustments, prioritize Item 7 (MD&A) and footnotes in Item 8 (Financial Statements) in 10-K reports."

Preferences themselves can be retrieved per-query (keyword / semantic / LLM-based) from a rules database before being slotted into the prompt.

### Limitations
- **Speed** — every retrieval is an LLM call.
- **Summary-based selection** — relying on node summaries can miss details in the underlying text.

These motivate [[hybrid-tree-search]].

## Related
[[tree-search]] · [[hybrid-tree-search]] · [[tree-index]] · [[agentic-retrieval-loop]]
