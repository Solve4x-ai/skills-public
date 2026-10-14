---
name: agents-md
description: Use when starting or updating a repo's AGENTS.md, or when a rule that should apply to every repo changes.
visibility: public
scope: personal
last-verified: 2026-10-13
---
# agents-md

Give every repo an AGENTS.md that every AI tool reads, built from one shared base so a rule changed once lands everywhere.

How it fits together:
- **AGENTS.md** is read automatically by Cursor, Codex, Devin and Grok. Claude Code reads `CLAUDE.md`, so each repo also gets a one-line `CLAUDE.md` containing `@AGENTS.md` (an import).
- **Always-on rules** go in AGENTS.md: things that are true for every task (secrets, commit rules, branch rules, frozen names, how to run the checks).
- **Procedures** go in skills (`.agents/skills/`), which load only when needed. AGENTS.md just points to them.

1. **Keep one shared base.** In your private skills repo, keep `agents/AGENTS.base.md` with only the rules true in *every* repo. Verify: each line holds for every repo you'd sync it to; if one doesn't, it belongs in that repo's own section.
2. **Sync it in.** A script (e.g. `tools/sync-agents.ps1`) replaces everything between two marker comments in each repo's AGENTS.md with the base, appends the block when the markers are missing, and creates `CLAUDE.md` if it's absent. Everything outside the markers is the repo's own and is never touched. Verify: re-running it reports every file as current.
3. **Write the repo's own part** above the markers, short, with real commands:
   - what the repo is and where things live (link the architecture doc);
   - how to check a change (build, lint, test) before committing;
   - rules specific to this repo (security model, frozen names, test machines, data that must not be touched);
   - where its procedures are (skills, scripts).
4. **Commit** each repo's AGENTS.md and CLAUDE.md following its branch rules.
5. **When a rule changes,** edit the base, run the sync, and commit every repo it touched in the same session.

## gotchas
- AGENTS.md has no include mechanism; that's why a sync script copies the base between markers.
- Edits made by hand between the markers are overwritten by the next sync. Change the base instead.
- A public repo shouldn't get a private base (names, hosts). Give it its own short, generic AGENTS.md, or a separate public base.
- Don't put workarounds, one-off instructions or temporary restrictions in AGENTS.md. Every agent obeys it on every task, so a stale line does damage quietly.

## never
- Never put secrets, keys or passwords in AGENTS.md; say where they're stored.
- Never let AGENTS.md and a skill disagree. Fix whichever is wrong the moment you notice.
- Never paste a whole procedure into AGENTS.md; make it a skill and point to it.
