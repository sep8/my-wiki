# JavaScript SDK

## Summary
`@pageindex/sdk` (`npm install @pageindex/sdk`). Two layers: `client.api` (REST surface) and `client.tools` (typed wrappers for MCP capabilities). Errors are `PageIndexError` with a `code` enum.

## Explanation

### Init
```js
import { PageIndexClient } from "@pageindex/sdk";
const client = new PageIndexClient({ apiKey: "YOUR_API_KEY" });
```

Config: `apiKey` (required), `apiUrl` (default `https://api.pageindex.ai`), `folderScope` (restrict to a folder + subfolders).

### `client.api` — REST
- `submitDocument(file, fileName, options?)` → `{ doc_id }`. `options.mode`, `options.folderId`.
- `getTree(doc_id, { nodeSummary })` → `{ status, result }`.
- `chatCompletions({ messages, doc_id, stream, temperature, stream_metadata, enable_citations })` — non-streaming returns `choices`; streaming yields async iterator of chunks.

### `client.tools` — MCP-style typed wrappers
Use when you want to compose PageIndex tools with other tools, customize behavior, or integrate with frameworks like the Vercel AI SDK. Tools include:
- `findRelevantDocuments({ query })`
- `getDocumentStructure({ docName, part?, waitForCompletion?, folderId? })` — returns `{ structure, total_parts? }`; large docs may be split into parts.
- `getPageContent({ docName, pages })` — page spec `"5"`, `"3,7,10"`, or `"5-10"`.

If your framework natively supports MCP, prefer connecting to [[pageindex-mcp]] directly without the SDK wrapper.

### Error codes
`UNAUTHORIZED` (401), `NOT_FOUND` (404), `RATE_LIMITED` (429), `USAGE_LIMIT_REACHED` (403), `INVALID_INPUT` (400), `SERVICE_UNAVAILABLE` (503), `INTERNAL_ERROR` (500).

## Related
[[python-sdk]] · [[pageindex-mcp]] · [[chat-api]] · [[document-processing-api]]
