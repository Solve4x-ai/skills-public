---
name: root-cause
description: Use when fixing a bug, a wrong number, a false alert or anything that "shouldn't happen", before writing the fix.
visibility: public
scope: personal
last-verified: 2026-10-13
---
# root-cause

Fix the defect and the reason nobody caught it, so it can't come back quietly.

1. **Reproduce it.** Find the real input or data that triggers it, and look at it (the actual values, not your guess). Verify: you can make it happen on demand, or you've seen the exact record that caused it.
2. **Find the cause, not the symptom.** Ask "why" until you reach a decision in the code or the data. A wrong label, a timeout or a crash is usually the symptom.
3. **Find what hid it.** Why did no test, check, alert or review catch it? (A tool that only checked half the rules; a test that asserted something too loose; a value nobody looked at.)
4. **Fix both.** Change the cause, and add the safeguard: a test with the failing case, a stricter check, or a script step that makes the mistake impossible.
5. **Look for siblings.** Search for the same pattern elsewhere (other callers, other files touched in the same change) and fix those too.
6. **Verify.** The test fails without your fix and passes with it; the full suite still passes; the original symptom is gone in the real place it appeared.
7. **Report.** One line each: what broke, why, what let it slip, what you changed, and how it's now guarded.

## gotchas
- "It works now" after a restart or re-run isn't a fix. Find out why it failed.
- A fix with no test tends to come back the next time someone touches that code.
- Data from the outside world (devices, users, APIs) is messier than the happy path: empty, zero-sized, duplicated, renamed, stale.

## never
- Never weaken or delete a test just to make it pass.
- Never hide a symptom (filter it from the UI, catch and ignore the error) without fixing why it happens.
- Never call it fixed before you've seen it fixed.
