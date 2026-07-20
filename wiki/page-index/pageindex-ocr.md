# PageIndex OCR

## Summary
PageIndex's in-house OCR model, marketed as the "first long-context OCR model" (blog, August 5, 2025). Powers the `?type=ocr` results of the [[document-processing-api]], returning markdown + base64 images per page (or per node, or raw concatenated).

## Explanation
Documented mainly via the blog post "PageIndex OCR: The First Long-Context OCR Model" and the OCR formats in the [[document-processing-api]]:
- `format=page` (default) — list of `{ page_index, markdown, images }`.
- `format=node` — organized by document structure.
- `format=raw` — single concatenated markdown string.

The "Do We Still Need OCR?" blog (Oct 2025) and the [[vision-rag]] cookbook discuss whether OCR is still necessary as a discrete step when a VLM can read page images directly. The two views aren't necessarily in tension — see [[contradictions]] — but they sit alongside each other in the corpus.

## Related
[[document-processing-api]] · [[vision-rag]] · [[pageindex]]
