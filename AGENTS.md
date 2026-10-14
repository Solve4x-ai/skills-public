# Working notes: public skills

This repo holds generic, scrubbed agent skills (`skills/<name>/SKILL.md`) and the tools that check and install them (`tools/`).

- Follow the `skill-authoring` skill for every change. Everything here is public: no client names, hostnames, IPs, emails, machine paths or secrets.
- Before committing: `pwsh -File tools/check-skills.ps1 -Root . -Expect public` (the pre-commit hook in `.githooks/` runs it once `git config core.hooksPath .githooks` is set).
- Add every new skill to the table in README.md.
- When a skill turns out wrong, fix it in the same session and update its `last-verified` date.
