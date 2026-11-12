---
name: foundry-poc
description: Use to confirm or refute a threat-model hypothesis with a Foundry test. Takes a hypothesis ID from notes/threat-model.md, writes the PoC under test/audit/ and records the verdict in notes/poc-results.md.
---

# Foundry PoC

Goal: prove or disprove ONE hypothesis with a test whose assertions demonstrate
the impact. A PoC that "passes" without proving impact is worse than no PoC.

## Rules
- Write only to test/audit/ and notes/. Never edit src/, existing tests or config.
- If foundry.toml has `ffi = true`, STOP and warn the user before running anything.
- One PoC per hypothesis. Name: test/audit/<ID>.t.sol, contract <ID>_PoC,
  function test_PoC_<ID>. Drop dashes in Solidity names (TM-1 -> TM1).
- The attacker uses only what the hypothesis preconditions allow. No pranking
  privileged roles, no deal() of unrealistic balances, no vm.store, no warping
  past conditions the hypothesis did not state. If a cheatcode is needed to set
  up a precondition, justify it in a comment.
- Never weaken or delete an assertion to make the test pass.
- Use fork mode only if the hypothesis depends on real chain state. Read the RPC
  from the ETH_RPC_URL environment variable. Never write private keys.
- Severity is not decided here.

## Step 1 - Define success
Read the hypothesis in notes/threat-model.md. Write down, before coding:
- The exact assertion(s) that would prove the impact (balance, state, revert).
- What result would refute the hypothesis.

## Step 2 - Reuse the project's setup
Look at the existing tests for this contract. Reuse their imports, remappings,
deployment and actors when possible, instead of building a new setup.

## Step 3 - Write the PoC
Follow poc-template.t.sol in this skill's folder:
1. Baseline: assert the expected behavior BEFORE the attack.
2. Attack: only permissionless calls and the attacker's own resources.
3. Impact: assert the change that proves the hypothesis. Log key values with console.log.

## Step 4 - Run
`forge test --mt test_PoC_<ID> -vvv` (use -vvvv to debug a failure).

## Step 5 - Interpret
- Passes and assertions prove the impact -> CONFIRMED (for the claim as tested only).
- Fails because the hypothesis is wrong -> REFUTED. Explain why with file:line.
- Fails because of the test itself -> fix the test and rerun.
- After 3 failed attempts without a clear answer -> INCONCLUSIVE. Explain what is missing.

## Step 6 - Record
Append the result to notes/poc-results.md following poc-results-template.md.
Do not change the hypothesis text in notes/threat-model.md.
Never rewrite or delete earlier entries in notes/poc-results.md. If a PoC is
revised, append a new section "<ID> - revision <n> (<reason>)" and keep the
earlier entries intact. Keep the Attempts field.
If you have a severity opinion, write it only as "Severity suggestion for the auditor:".

## Step 7 - Self-check
- The baseline assertion exists and passes.
- The impact assertion matches the success criterion from Step 1.
- No forbidden cheatcodes, or each one is justified in a comment.
- src/ is untouched (`git status --short`).
- All tool side effects are listed in the final message.
