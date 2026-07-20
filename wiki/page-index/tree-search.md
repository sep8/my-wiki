# Tree Search

## Summary
The step in PageIndex's retrieval loop that selects which nodes of a [[tree-index]] are likely to answer a query. Two main strategies: pure [[llm-tree-search]], and [[hybrid-tree-search]] combining LLM reasoning with a vector-based value function.

## Explanation
A tree search returns a `node_list` — the set of `node_id`s the system will fetch raw content for and feed to the answer-generation step. Strategies:

- **[[llm-tree-search]]** — give the LLM the tree (titles + summaries) plus the query; ask it for relevant node IDs in JSON. Simple, transparent, supports expert-knowledge injection by prompt.
- **[[hybrid-tree-search]]** — run LLM tree search *and* a value-based search (per-node vector score) in parallel, dedup via a queue, let an LLM agent decide when enough context has been gathered. PageIndex's docs say this is the **default** in their retrieval API. (See also: [[contradictions]] — the legacy retrieval API is marked deprecated in favor of the [[chat-api]].)
- **MCTS variant** — PageIndex's dashboard combines LLM tree search with value-function-based [Monte Carlo Tree Search](https://en.wikipedia.org/wiki/Monte_Carlo_tree_search). Details not yet public.

For scaling across many documents (not within one), see [[doc-search]].

## Related
[[llm-tree-search]] · [[hybrid-tree-search]] · [[node-scoring]] · [[tree-index]] · [[agentic-retrieval-loop]] · [[doc-search]]
