# Vision-based RAG

## Summary
A vectorless RAG pipeline that uses PageIndex for [[reasoning-based-rag]] *navigation* but skips OCR entirely — feeding PDF page images directly to a vision-language model (e.g. GPT-4.1) for both reasoning and answer generation. Argues that with modern VLMs, OCR may no longer be necessary as an intermediate step.

## Explanation

### Pipeline
1. Build a PageIndex [[tree-index]] for the document.
2. Run tree search to pick relevant nodes (LLM-driven).
3. Extract the *PDF page images* for those nodes (not the OCR'd text).
4. Pass images + query to a VLM (e.g. GPT-4.1, Qwen-VL, DeepSeek-OCR) to produce the answer.

### Why
- Traditional OCR is a two-stage layout-then-text pipeline; new end-to-end VLMs jointly understand visual + textual content.
- If a VLM can already process page images + query directly, the intermediate OCR step becomes optional.

### Caveats from the source
The cookbook is explicitly a **minimal** example to illustrate the idea, not a production-ready system. See the companion blog post "Do We Still Need OCR?" for the broader argument and [[pageindex-ocr]] for PageIndex's own OCR product (which still has a role for downstream text consumers).

## Related
[[pageindex]] · [[reasoning-based-rag]] · [[pageindex-ocr]] · [[tree-search]] · [[cookbooks]]
