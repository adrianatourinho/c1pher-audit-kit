# Threat Model - <Protocol> @ <commit>
Based on: notes/recon.md (revision <n>)

## 1. Attacker profiles
| Profile | Can control | Can call | Can manipulate | Can gain |

## 2. Assumptions under attack
| # | Assumption | How it could fail | Who / via which entry point | Result |
Result = hypothesis ID or "holds (reason, file:line)"

## 3. Hypotheses (ranked)
### TM-1: <short title>
- Status: unconfirmed hypothesis
- Location: file.sol:line
- Attacker profile:
- Hypothesis: one sentence (who attacks, what they call, what they gain)
- Preconditions:
- Attack sequence: numbered steps
- Impact: H/M/L - justification in value at risk
- Likelihood: H/M/L - justification
- Suggested severity:
- Confidence: H/M/L
- Why it might not hold: (required for High)
- How to prove: what a Foundry PoC must demonstrate (balances, state, revert)

## 4. Closed flags
| Recon flag | Reason it does not hold | file:line |

## 5. Coverage gaps
What could not be analyzed and why (off-chain parts, missing docs, out of scope).
