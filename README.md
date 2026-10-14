# 🧰 Solve4x Skills

**Little recipes that make AI agents less forgetful.**

Every time you explain a task to an agent, you're writing instructions it will forget tomorrow. A *skill* fixes that: a short, plain-English playbook the agent loads on demand and follows the same careful way every time.

These are the skills from [Solve4x](https://solve4x.ai) that are generic enough to share. Grab what's useful, remix the rest.

## ⚡ Quick start

```bash
git clone https://github.com/Solve4x-ai/skills-public.git
```

Copy (or symlink) any folder under `skills/` into:

- `~/.cursor/skills/` to use it in every project, or
- `<your-project>/.cursor/skills/` for just one.

Then type `/` in Cursor's agent chat, pick a skill, and tell it what you need:

```
/skill-template help me write a skill for resetting a user's MFA
```

Run `git pull` now and then to get new skills.

## 📚 What's inside

| Skill | Reach for it when... |
|---|---|
| [`skill-authoring`](./skills/skill-authoring/SKILL.md) | you're creating, moving, or publishing a skill and want it in the right place, marked private or public. |
| [`skill-template`](./skills/skill-template/SKILL.md) | you're writing a new skill and want a solid starting shape. |

More are on the way as they get cleaned up for public use.

## ✍️ Write your own

1. Copy `skills/skill-template/` to `skills/<your-skill-name>/`.
2. Write a `description` that says **when** to use it. That's how the agent decides to pick it up.
3. Keep the steps short, numbered, and checkable.
4. Put the "never do this" rules at the bottom, where they're hard to miss.

> **Rule of thumb:** if you've explained it to an agent twice, it's a skill.

## 🔒 House rules

No secrets, keys, IPs, client names, or personal info. Skills say *where* to find things, never *what* they are.

## 🤝 Contributing

Found a bug or have an improvement? Open an issue or a PR. Small and practical beats big and clever.

---

Built by [Solve4x](https://solve4x.ai) 🌲
