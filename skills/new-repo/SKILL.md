---
name: new-repo
description: Use when someone wants a new GitHub repository (a new project, app, tool, site or docs collection), before creating anything.
visibility: public
scope: personal
last-verified: 2026-10-13
---
# new-repo

Create a complete, well-set-up repository in one go, after asking a few plain questions. Works for people who've never made a repo before.

1. **Ask the questions.** Use plain words and give your recommended answer for each, so the person can just say "yes". Ask them together, not one by one, unless they seem unsure. Explain any term they might not know (in brackets is how).
   1. **What is it, and who is it for?** One or two sentences. This becomes the description and the top of the README.
   2. **Name?** Suggest one: short, lowercase, words joined by dashes (e.g. `front-desk-app`).
   3. **Private or public?** Recommend **private** unless they want strangers to see and reuse it. (Private: only people you invite can see it. Public: anyone on the internet can read it, but only you can change it.)
   4. **Will it ever hold client or personal data, passwords, or business documents?** If yes, it must be private, and extra protections are added. Recommend keeping such data out of code repos altogether.
   5. **What kind of project?** Go, Node/TypeScript, Python, PowerShell scripts, documents only, or something else / not sure yet. ("Not sure" is fine; it can be set up later.)
   6. **Does it work with any of your existing repos?** For each: which one, and how (uses its code, talks to it, documents it). These become links in the README and AGENTS.md.
   7. **Who will work in it?** Just you, AI agents, other people, or a mix. AI agents and other people mean pull requests for review and protected branches where the plan allows.
   8. **Any rules that must always hold?** Things that must never happen, machines or data that are off-limits, how it must be tested. Offer examples from their other repos if you know them.
   9. **Run automatic checks on GitHub (CI)?** Recommend **no** if their GitHub Actions minutes are limited; checks then run on their own computer before each commit. (CI means GitHub runs the tests on every change.)
   10. **Public only: license?** Recommend **MIT** (anyone may use it, with credit). Apache 2.0 if they want explicit patent terms.
2. **Confirm a summary** in plain words: name, private/public, what gets created, where the folder will be. Wait for a yes.
3. **Create it** with the script, from your skills tools folder (PowerShell):
   ```powershell
   .\tools\new-repo\new-repo.ps1 -Name <name> -Description "<what it is>" -Visibility private|public `
     -Kind go|node|python|powershell|docs|other -Related "<owner/repo>: <how>" -Rules "<rule>" `
     [-ClientData] [-CI] [-License MIT|Apache-2.0] -Config <your new-repo.json>
   ```
   The config file holds your defaults (GitHub owner, where repos live on disk, and your AGENTS.md and skills sync scripts), so you don't repeat them. Without one, pass `-Owner` and `-LocalRoot`. Add `-WhatIf` to preview, or `-LocalOnly` to build the folder without touching GitHub. Verify: it ends with `done:` and prints the repo's address.
4. **What it creates:**
   - **Docs:** README, AGENTS.md (with your shared rules for private repos), CLAUDE.md, CONTRIBUTING, SECURITY, CHANGELOG, `docs/ARCHITECTURE.md`; LICENSE and CODE_OF_CONDUCT for public repos.
   - **Hygiene:** a `.gitignore` for the project kind that always blocks secrets (plus client-data folders when asked), `.gitattributes` for line endings, `.editorconfig`.
   - **GitHub:** PR and issue templates, CODEOWNERS, Dependabot updates, optional CI, `main` and `dev` branches, auto-deleted merged branches, topics; on public repos, secret scanning, push protection and branch protection.
   - **Your setup:** an empty `.agents/skills/` for the repo's own skills, and the repo is added to your AGENTS.md and skills sync, so shared rules and skills reach it.
5. **Fill in the specifics with the person:** the README's "Getting started", the AGENTS.md rules, and `docs/ARCHITECTURE.md`. Commit on `dev`, then fast-forward `main`.
6. **Report** in plain words: the link, private or public, what was set up, what's left to fill in, and anything that needs a paid plan or a manual step.

## gotchas
- On a free GitHub account, branch protection only works on public repos. For private ones the script says so; until then, give outside AI tools read-only access.
- Dependabot reports errors until the project has its dependency file (`go.mod`, `package.json`, `requirements.txt`); that's expected on day one.
- The name can't be changed easily once people and tools link to it. Get it right in step 1.
- If the script or this skill is wrong, fix it in the same session.

## never
- Never create the repo before the person has confirmed the summary.
- Never make a repo public if it will hold client or personal data, passwords or business documents.
- Never put secrets, client names or personal data into the README, AGENTS.md or any starter file.
