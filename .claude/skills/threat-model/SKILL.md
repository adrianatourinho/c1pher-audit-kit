---
name: threat-model
description: Use after audit-recon, to turn the recon map into ranked attack hypotheses by trying to break the system's assumptions. Reads notes/recon.md, produces notes/threat-model.md.
---

# Threat Model

Goal: find what can go wrong. Security starts by trying to break the system's
assumptions. This phase produces HYPOTHESES, not confirmed findings.

## Rules
- Read-only. Never edit src/. Write only to notes/.
- Input is notes/recon.md. If it does not exist, STOP and ask the user to run /audit-recon.
- Every hypothesis cites file:line and states how it could be proven with a Foundry PoC.
- Never call a hypothesis "confirmed" or a "vulnerability". Use "unconfirmed hypothesis".
- Do not write PoCs here.
- Severity is an estimate. Final classification belongs to the auditor.
- If the user limits the run (one contract, some steps), follow that over the steps below.

## Step 1 - Attacker profiles
Refine the recon's attacker lens for each profile:
- Unprivileged user (any EOA or contract)
- Privileged role acting maliciously or with a compromised key
- External dependency misbehaving (oracle, token, integrated protocol)
- Transaction orderer (MEV searcher, validator)
For each profile answer, citing code:
1. What can I control?  2. What can I call?  3. What can I manipulate?  4. What can I gain?

## Step 2 - Break the assumptions
For each assumption and invariant in recon section 3, ask: what would have to
be true for it to FAIL, who can make that happen, and through which entry point?
Try these techniques:
- Direct transfers / donations that change balances without going through the code
- Transaction ordering: front-running, back-running, sandwiching
- Reentrancy and callbacks (hooks, ERC-777/721/1155, flash loan receivers)
- Extreme values: 0, 1 wei, max uint, empty arrays, same address twice
- First and last user (empty vault, last withdrawal)
- Time: before/after deadlines, same block, long inactivity
- State transitions: paused, uninitialized, mid-upgrade, after ownership change
- Unusual tokens: fee-on-transfer, rebasing, no return value, non-18 decimals
- Rounding direction in conversions and fee math

## Step 3 - Resolve every recon flag
For each item in recon section 10, answer the question by reading the code.
Then either turn it into a hypothesis or close it with a one-line reason and file:line.

## Step 4 - Surface sweep
Check nothing was skipped. For ACCESS, STATE, VALUE and CALL, plus user inputs
and oracles: is there any entry point or variable from the recon that no
hypothesis or closed flag covers? If so, analyze it now.

## Step 5 - Impact and likelihood
For each hypothesis estimate:
- Impact: High (direct loss or permanent freeze of funds), Medium (temporary
  freeze, DoS, loss under specific conditions, broken core function),
  Low (griefing, minor accounting errors without loss).
- Likelihood: High (any user, cheap, no special conditions), Medium (specific
  conditions or meaningful cost), Low (privileged role, unlikely state, very high cost).
- Suggested severity from the matrix:
  |            | Impact H | Impact M | Impact L |
  | Likelihood H | High   | High     | Medium   |
  | Likelihood M | High   | Medium   | Low      |
  | Likelihood L | Medium | Low      | Low      |

## Step 6 - Prioritize
Rank hypotheses for PoC work: suggested severity first, then confidence,
then cost to prove.

## Step 7 - Output
Write notes/threat-model.md following threat-model-template.md in this skill's folder.

## Step 8 - Self-check
Before finishing, verify:
- Every recon flag appears as a hypothesis or as a closed flag.
- Every hypothesis has preconditions, file:line and "how to prove".
- No text says "confirmed" or "vulnerability" about a hypothesis.
- src/ is untouched (`git status --short`).
- All tool side effects are listed in the final message.
