---
name: finding-writeup
description: Use to turn a PoC-confirmed hypothesis into a report-ready finding. Takes a hypothesis ID and the auditor's severity, reads notes/ and the PoC, writes findings/<ID>-<slug>.md.
---

# Finding Write-up

Goal: write a finding a protocol team can read, reproduce and fix.
The report never claims more than the evidence proves.

## Rules
- Write only to findings/. Never edit src/, tests or notes/.
- Only write up hypotheses whose latest verdict in notes/poc-results.md is
  CONFIRMED. If it is REFUTED or INCONCLUSIVE, STOP and tell the auditor.
- Severity comes from the auditor in the command (e.g. severity=Medium).
  If it is missing, STOP and ask, showing the impact and likelihood facts
  from the notes. Never choose it yourself.
- If the auditor passes severity=TBD, write a DRAFT: use "TBD" in the title
  and table, and add a section "Severity notes for the auditor" listing the
  facts that support each plausible level. Do not recommend one.
- Every claim must trace to the PoC results, the test code or the source
  (file:line). If a claim was refuted in a later revision, do not use it.
- Use "What the PoC does NOT prove" from the results to limit the Impact section.
- Mitigation is a suggestion in a diff block inside the report. Mark it
  "untested" unless a test proves it.
- Plain, factual tone. No "critical", "catastrophic" or similar words unless
  the severity is Critical. No speculation presented as fact.

## Step 1 - Gather evidence
Read, for the given ID:
- The hypothesis in notes/threat-model.md.
- ALL entries for the ID in notes/poc-results.md. The latest revision wins.
- The review in notes/reviews.md, if it exists.
- The PoC in test/audit/<ID>.t.sol.
- The commit hash (`git rev-parse --short HEAD`).

## Step 2 - Title
One sentence: root cause + impact.
Good: "Strict share/asset equality in flashLoan lets anyone disable flash loans with a 1 wei donation"
Bad: "DoS in vault"

## Step 3 - Write
Follow finding-template.md in this skill's folder. Code snippets: only the
lines needed, with file:line and the commit hash.

## Step 4 - Reproducibility
The PoC section must contain the exact command and the expected result, so
anyone can rerun it at the same commit.

## Step 5 - Self-check
- Latest verdict is CONFIRMED and the severity matches the auditor's command (or is TBD).
- No sentence claims something the PoC results say it does not prove.
- Every code reference has file:line and the commit.
- The PoC command is copied exactly from notes/poc-results.md.
- Mitigation is marked untested (unless proven).
- Only findings/ was written (`git status --short`).
