# [<Severity>] <Title: root cause + impact>

| Field | Value |
|---|---|
| ID | <ID> |
| Severity | <from auditor> |
| Impact | <H/M/L> |
| Likelihood | <H/M/L> |
| Commit | <hash> |
| Affected code | file.sol:line |
| Status | Open |

## Summary
Two or three sentences: what is wrong, who can exploit it, what happens.

## Vulnerability Details
Root cause, with the relevant code snippet (file:line @ commit).
Explain why the code behaves this way. No impact talk here.

## Impact
Who loses what (funds, core function, time) and for how long.
Limits: what the PoC does not prove, and any recovery paths.

## Proof of Concept
Attack steps:
1.
2.

Test: test/audit/<ID>.t.sol :: test_PoC_<ID>
```bash
forge test --mt <exact command from poc-results>
```
Expected result: <what passes and what it demonstrates>

Key code excerpt from the test (the attack and the impact assertions only).

## Recommended Mitigation
Explanation of the fix, then:
```diff
- old line
+ new line
```
Status of the mitigation: untested.

## References
- notes/threat-model.md (<ID>), notes/poc-results.md (latest revision)
