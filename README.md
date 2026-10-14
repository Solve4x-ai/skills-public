# solve4x skills (public)

hey, i'm james from [Solve4x](https://solve4x.ai). i run a small IT and MSP shop, and i lean on AI agents for a lot of the repetitive stuff.

**these are the skills i'm happy to share.** each one is a short, plain-english recipe an agent can follow so it does the job the same careful way every time. take whatever's useful.

## install

```bash
git clone https://github.com/Solve4x-ai/skills-public.git
```

then copy or symlink the folders under `skills/` into `~/.cursor/skills/` (all projects) or a project's `.cursor/skills/`. `git pull` for updates.

## usage

type `/` in Cursor's agent chat, pick a skill, and say what you want:

```
/skill-template help me write a skill for resetting a user's MFA.
```

## skills

| skill | use it when |
|---|---|
| [`/skill-authoring`](./skills/skill-authoring/SKILL.md) | you're creating, moving, editing or publishing a skill and want it in the right place, marked private or public, in the same shape as the rest. |
| [`/skill-template`](./skills/skill-template/SKILL.md) | you're writing a new skill and want the starting shape. |

more coming as i clean them up.

## add a skill

1. copy `skills/skill-template/` to `skills/<your-skill-name>/`.
2. fill in `name` and `description` (the description says *when* to use it; that's how the agent picks it).
3. keep the steps short and in order, with the "never do this" rules at the bottom.
4. keep it generic: no client names, hostnames, keys or personal info.

good rule of thumb: if you've explained the same thing to an agent twice, it's a skill.

## thanks

the shape of this repo is borrowed from poteto's [pstack](https://github.com/cursor/plugins/tree/main/pstack). go look at it.

— james 🌲
