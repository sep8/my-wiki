# Python SDK

## Summary
`pageindex` package (`pip install -U pageindex`). Thin client around the [[document-processing-api]] and [[chat-api]], plus `pageindex.utils` helpers used in the cookbooks (e.g. `print_tree`, `create_node_mapping`, `remove_fields`, `print_wrapped`).

## Explanation

### Init
```python
from pageindex import PageIndexClient
pi_client = PageIndexClient(api_key="YOUR_API_KEY")
```

### Common calls
```python
doc_id = pi_client.submit_document("./report.pdf")["doc_id"]
status = pi_client.get_document(doc_id)["status"]

# readiness helper
if pi_client.is_retrieval_ready(doc_id):
    tree = pi_client.get_tree(doc_id, node_summary=True)["result"]

# chat
response = pi_client.chat_completions(
    messages=[{"role": "user", "content": "Key findings?"}],
    doc_id=doc_id,
)
```

### Utilities used in cookbooks
- `utils.print_tree(tree)` — pretty-print a [[tree-index]].
- `utils.create_node_mapping(tree)` — flatten tree into `{node_id: node}` for fast lookup.
- `utils.remove_fields(tree_copy, fields=["text"])` — strip large fields before sending the tree to the LLM in a [[llm-tree-search]] prompt.
- `utils.print_wrapped(...)` — text wrapping for terminal output.

## Related
[[javascript-sdk]] · [[document-processing-api]] · [[chat-api]] · [[cookbooks]]
