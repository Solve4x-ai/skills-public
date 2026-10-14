---
name: skill-authoring
description: Use when creating, moving, editing or publishing an agent skill (SKILL.md), so it lands in the right place with the right privacy and the same shape as the rest.
visibility: public
scope: personal
---
# skill-authoring

Write skills the same way every time: the right home, honest privacy markings, a short uniform shape, and no secrets.

Set these up once and use them in place of the placeholders below:
- `<private-skills-repo>`: your private repo for personal, cross-project skills.
- `<public-skills-repo>`: your public repo for scrubbed, generic skills.

1. **Is it a skill?** Only if it's done more than once. A one-time task is not a skill. Rule of thumb: if you've explained the same thing to an agent twice, it's a skill.
2. **Pick its home.** When unsure, choose the more private option and ask.
   - **Project skill:** tied to one codebase, client, server or workflow. It goes in that project's repo at `.cursor/skills/<skill-name>/SKILL.md`, where it travels with the project and inherits its privacy. This is the default for anything project-specific.
   - **Private personal skill:** reused across projects, but it mentions your clients, infrastructure, hostnames or internal procedures. It goes in `<private-skills-repo>` under `skills/<skill-name>/SKILL.md`.
   - **Public skill:** generic and useful to anyone. It goes in `<public-skills-repo>` under `skills/<skill-name>/SKILL.md`. Only scrubbed, generic content.
   - If it's a project skill, check that the project repo is private before writing hostnames or paths into it (`gh repo view <owner>/<repo> --json visibility`). If it isn't, treat the skill as public.
3. **Decide public or private.** A skill is private if it contains or depends on any of these:
   - client or company names;
   - hostnames, domains, IPs, or server or service names from your infrastructure;
   - file paths on your machines;
   - account emails or usernames;
   - internal procedures, or anything about a specific project.

   Everything else can be public, but only after scrubbing (step 7).
4. **Create the folder.** One folder per skill, named in kebab-case to match `name`: `skills/<skill-name>/SKILL.md`, plus any helper scripts the skill needs. In a repo with a template, start from it (`cp -r skills/skill-template skills/<skill-name>`).
5. **Write the frontmatter.** It must match where the file lives: public skills only in the public repo, and project skills only in that project's repo.
   ```yaml
   ---
   name: <kebab-case-name>
   description: Use when <the situation that should trigger this skill>. One sentence, focused on WHEN.
   visibility: private | public
   scope: project | personal
   project: <repo or project name, only if scope is project>
   ---
   ```
   The description decides when an agent picks the skill. Say *when*, not *what*.
6. **Write the body in this order:**
   - `# <skill-name>` and a one-line purpose;
   - numbered short steps, each with the real command and how to verify it worked;
   - `## gotchas`: what tripped you up before;
   - `## never`: what must not happen.

   Keep it short and in plain English. Point to *where* things are stored, never *what* the secrets are.
7. **Scan before committing.** Search the skill for secrets and specifics:
   ```bash
   grep -rnEi '([0-9]{1,3}\.){3}[0-9]{1,3}|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-z]{2,}|(api[_-]?key|token|secret|passw(or)?d)\s*[:=]|-----BEGIN|[A-Z]:\\|/home/|/Users/' skills/<skill-name>/
   ```
   Every hit must be removed or justified (for example `127.0.0.1` in a private skill). For a public skill, also read it once for client names, hostnames, domains and project names, and remove every one.
8. **Publishing a private skill.** Make a generic **copy** in `<public-skills-repo>`. Replace specifics with placeholders like `<your-server>` or `<service-name>`. Keep the private original where it is, and never link from the public copy to anything private.
9. **List it.** If the repo's README has a skills table, add a row: the name and "use it when …".
10. **Commit.** Push it following the repo's branch rules. Verify that the file is on the remote: `git log --oneline -1 -- skills/<skill-name>`.
11. **Report.** For each skill: what you created, where you put it, its visibility and scope, and anything you scrubbed or weren't sure about.

## gotchas
- Different agent tools load skills from different folders. Cursor reads `.cursor/skills/`; other tools have their own (for example `.claude/skills/`). If you use more than one tool, link those folders to the same files rather than keeping copies.
- Older skills may predate the `visibility` and `scope` fields. Add them the next time you touch the skill.
- A "private" project skill is only as private as its repo. Check the repo's visibility.
- Helper scripts get the same scan as SKILL.md.

## never
- Never put secrets in any skill, private or public: no passwords, API keys, tokens, private keys, SSNs, or personal addresses or phone numbers. Say where they're stored instead (for example, "the key file in ~/.ssh" or "the password manager entry for X").
- Never let a skill's location disagree with its frontmatter.
- Never move a private skill to public. Copy it, scrub the copy, and leave the original.
- Never link from a public skill to a private one.
- Never make a skill out of a one-time task.
