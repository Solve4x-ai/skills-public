---
name: handoff
description: Use when handing work to another AI agent or a person (a new session, a different tool, a contractor), so they can start without asking you anything.
visibility: public
scope: personal
last-verified: 2026-10-13
---
# handoff

Write one self-contained brief: where things are, what to do, what not to touch, and what "done" means.

1. **The goal, in one or two sentences.** One feature or job per brief; split bigger work.
2. **Where things are.** Repos (URL and local folder), branch to start from, and the docs to read first (AGENTS.md, the design or spec doc). Name the files that matter if you know them.
3. **How to work.** Branch name to create, plan-first or not ("write a short plan and stop for approval"), and that work comes back as a pull request, never a direct push to the main branches.
4. **Rules that must hold.** Security model, secrets, frozen names, file-size or style limits, test machines. Copy the few that matter; point to AGENTS.md for the rest.
5. **Off-limits.** Systems, folders, data and machines they must not touch, and what needs a person (sign-ins, approvals).
6. **Done means.** The exact checks that must pass, tests for new behavior including failure cases, docs updated, and what the PR description must say (what changed, how it was tested, what's uncertain).
7. **Read it as the receiver.** Could someone with no context start from this alone? Fill any gap.

## gotchas
- Agents fill gaps with guesses. Anything you leave out, they'll invent.
- Give real paths and commands, not descriptions of them.
- If the work spans repos, say which repo owns which piece and how they connect.

## never
- Never include secrets in a brief; say where they're stored.
- Never hand off "build the whole thing" as one task.
- Never let a handoff grant more access than the work needs (read-only for reviews).
