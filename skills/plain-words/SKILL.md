---
name: plain-words
description: Use when writing or reviewing anything a non-technical person will read in a product or report, such as UI labels, errors, empty states, approval prompts or status summaries.
visibility: public
scope: personal
last-verified: 2026-10-13
---
# plain-words

Make text a busy, non-technical office manager understands on first read, with one obvious next step.

1. **Lead with what it means for them.** "75 devices found, none answered SNMP yet", not "SNMP probe: no_response x75".
2. **Name things the way they do.** Use the device name they'd say, "printer", "the front desk". No internal IDs, code names, table names or cmdlets on the first screen.
3. **Say what to do next.** Every problem, empty state or warning ends with one action: a button, or one plain sentence ("Add a read-only SNMP credential to name them").
4. **Be honest about effect and risk.** "Only looks, changes nothing" or "Makes changes on this machine". Say plainly what can't be undone.
5. **Cut.** Short sentences. One idea each. Remove words that don't change the meaning ("simply", "please note", "in order to").
6. **Check it.** Read it as someone who's never seen the product. If a word needs explaining, replace it or add a few words in brackets the first time.

## gotchas
- Error codes are for logs and support; the person needs what happened and what to do.
- Counts beat adjectives: "3 of 98 have the agent" says more than "low coverage".
- Status words drift: keep one word per state (online, offline, stale) everywhere in the product.

## never
- Never blame the person ("you entered an invalid…"); say what's needed instead.
- Never show a raw stack trace, JSON blob or internal ID as the main message.
- Never promise more than the system does ("always", "never fails", "fully secure").
