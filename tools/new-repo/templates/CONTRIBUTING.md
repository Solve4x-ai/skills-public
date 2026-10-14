# Contributing to {{NAME}}

Thanks for helping. Small, focused changes are easiest to review.

1. **Start from `dev`:** `git checkout dev && git pull`, then make a branch: `git checkout -b <your-name>/<short-description>`.
2. **Make the change,** with a test or check that proves it works, including what should happen when something goes wrong.
3. **Run the checks** before committing:

   ```sh
   {{CHECKS}}
   ```

4. **Write a clear commit message:** what changed and why, in plain words.
5. **Open a pull request into `dev`.** Say what changed, how you tested it, and anything you're unsure about.

AI agents follow the same steps, plus the rules in [AGENTS.md](AGENTS.md).

Never commit passwords, keys, tokens or personal data. If you did by accident, say so right away so it can be changed.
