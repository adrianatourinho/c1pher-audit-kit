---
name: audit-recon
description: Use at the start of a smart contract audit, before hunting for bugs, to map contracts, entry points, roles, state, value flows and external dependencies. Produces notes/recon.md.
---

# Audit Recon

Goal: build an accurate map of the system. This phase records facts, not findings.

Principle: where there is logic, there is attack surface. Every point of
ACCESS, STATE, VALUE and CALL mapped here is a place where something can
go wrong later. Map them all.

## Rules
- Read-only. Never edit files in src/. Write only to notes/.
- Every claim cites file:line.
- Do not report vulnerabilities in this phase. Flags are neutral observations
  of surprising code, one line each, phrased as a question, with file:line.
  No attack chains, no impact, no exploit reasoning.
  Good: "Vault.sol:85 compares a share amount to an asset amount. Is the rate always 1:1?"
  Bad: "An attacker can transfer tokens to break the check and DoS the vault."
- Report any side effects of tools you run (files deleted, rebuilt or created).
- If something cannot be determined from the code, write UNKNOWN and state
  what is missing (deployment config, off-chain component, docs).

## Step 0 - Context
- Read CLAUDE.md: scope, commit, trust assumptions.
- If foundry.toml has `ffi = true`, STOP and warn the user before running anything.
- Run `forge build`. List in-scope files with line counts.

## Step 1 - Attacker lens
Before reading the code in detail, use README, docs and NatSpec to write
first answers to:
1. What can I control? (inputs, amounts, timing, tx ordering, tokens or contracts I deploy)
2. What can I call? (every function reachable without privileges)
3. What can I manipulate? (prices, balances, shared state, state read by other contracts)
4. What can I gain? (funds, privileges, blocking others, mispriced assets)
Then list every assumption and invariant the developers rely on, stated or
implied. Do not try to break them here; the threat-model skill will.

## Step 2 - Inventory
- Contracts, inheritance tree, libraries and their versions (e.g. OpenZeppelin).
- Proxy / upgrade pattern, if any. Compiler version and pragmas.
- Helpful: `slither . --print inheritance,human-summary`

## Step 3 - Attack surface: entry points
Table with every external/public function that changes state, plus view
functions other contracts may depend on:
| Contract | Function | Who can call | Moves value? | State written | External calls | User inputs |
Helpful: `slither . --print function-summary`

## Step 4 - Access control
For each role (owner, admin, keeper, etc.):
- Who grants and revokes it? Is it a multisig, EOA, timelock or UNKNOWN?
- Which functions can it execute?
For each privileged function:
- Who can call it, and which permission checks exist (file:line)?
- What value can it move or what parameters can it change?
- Initializers: who can call them and can they be called twice?
Flag any sensitive function without a permission check.
Helpful: `slither . --print vars-and-auth`

## Step 5 - State
Critical state variables (balances, shares, totals, prices, config, pause flags):
which functions write them, which read them. If upgradeable, record storage
layout with `forge inspect <Contract> storage-layout`.

## Step 6 - Value flows
Every path where ETH or tokens enter or leave the system. Which tokens are
accepted (any ERC-20? fee-on-transfer? rebasing?). Where internal accounting
can diverge from real balances.

## Step 7 - External dependencies
Oracles (source, freshness and sanity checks), other protocols, callbacks and
hooks, keepers and off-chain actors. For each: what the system trusts it to do.

## Step 8 - Output
Write notes/recon.md following recon-template.md in this skill's folder.
End with "Flags for threat model" and "Open questions for the team".
