# Audit workflow rules

- Phases are separate: recon, threat model, PoC, review. Do not run the next
  phase unless the auditor asks for it.
- After a subagent review (e.g. devils-advocate), show its verdict and its
  suggested follow-ups, then STOP and wait for the auditor's decision.
- Never edit tests, notes or findings based on a review without the auditor's
  explicit approval in the chat.
- Records in notes/ are append-only: never rewrite or delete earlier entries.
- Severity is decided by the auditor. You may only write "Severity suggestion
  for the auditor:".
