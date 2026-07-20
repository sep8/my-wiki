# Codex Workflow Skills Design

## Goal

Make `./setup.sh codex` expose this repository's six wiki workflows as repo-local Codex Skills without creating user-level configuration or generating `.codex/prompts/`.

## Design

Keep `templates/workflows/*.md` as the shared workflow-content source. During Codex setup, generate one skill per workflow at `.agents/skills/<workflow>/SKILL.md`. `setup.sh` supplies the required YAML frontmatter (`name` and a trigger-oriented `description`) and appends the corresponding workflow body.

Keep `query-wiki` as its existing repo-local skill. Do not add global files under `~/.codex`.

The generated skills are invoked explicitly with `$<workflow>`, for example `$linting-wiki page-index`, and remain eligible for implicit invocation when their descriptions match a request.

## Legacy cleanup

Stop creating `.codex/prompts/`. On Codex setup, remove only the six known workflow prompt files previously generated there. Remove the now-empty prompt directory when possible, but preserve unknown user-created files under `.codex/`.

## Documentation

Update repository documentation and setup output to describe `.agents/skills/<workflow>/SKILL.md`, `$skill-name` invocation, and the removal of project-local custom prompts. Claude and Copilot generation remain unchanged.

## Validation

- Check `setup.sh` with `bash -n`.
- Run `./setup.sh codex` twice to verify idempotency.
- Verify all six workflow skills plus `query-wiki` exist.
- Validate every generated `SKILL.md` with the Skill Creator validator.
- Verify the six legacy `.codex/prompts/*.md` files are absent and unknown `.codex` files are preserved.
- Search tracked documentation for obsolete claims that Codex workflows live in `.codex/prompts/`.
