# C1pher Audit Kit

A Claude Code plugin that turns a smart contract audit into a disciplined,
reproducible workflow: map the system, form attack hypotheses, prove or refute
them with Foundry, challenge every confirmed finding, and write it up.

> **Status: v0.1 (work in progress).** Built and calibrated on Damn Vulnerable
> DeFi. Feedback and issues are welcome.

## Why

AI can read code fast, but it also invents bugs. This kit is built around one
principle: **nothing is a finding until a PoC proves it and a skeptical review
fails to break it.** Every phase has a narrow job, and the auditor makes every
decision that matters.

## Workflow

```
audit-recon  ->  threat-model  ->  foundry-poc  ->  devils-advocate  ->  finding-writeup
   (facts)        (hypotheses)      (verdicts)        (challenge)          (report)
```

| Component | Type | What it does | Output |
|---|---|---|---|
| `audit-workflow` | Skill | Phase order and ground rules for every session | - |
| `audit-recon` | Skill | Maps contracts, entry points, roles, state, value flows and dependencies. Records facts, not findings | `notes/recon.md` |
| `threat-model` | Skill | Tries to break the system's assumptions and ranks attack hypotheses | `notes/threat-model.md` |
| `foundry-poc` | Skill | Writes a Foundry test that confirms or refutes one hypothesis | `test/audit/`, `notes/poc-results.md` |
| `devils-advocate` | Subagent | Tries to refute a confirmed finding, in an isolated context | `notes/reviews.md` |
| `finding-writeup` | Skill | Turns a confirmed finding into a report-ready write-up | `findings/` |

## Requirements

- [Claude Code](https://code.claude.com/docs/en/setup)
- [Foundry](https://getfoundry.sh)
- Optional: [Slither](https://github.com/crytic/slither), [Aderyn](https://github.com/Cyfrin/aderyn)
- Recommended: a dedicated virtual machine for auditing third-party code

## Installation

Inside Claude Code:

```
/plugin marketplace add GITHUB_USER/c1pher-audit-kit
/plugin install c1pher-audit-kit@c1pher
```

Skills are namespaced: `/c1pher-audit-kit:audit-recon`,
`/c1pher-audit-kit:threat-model`, and so on. The subagent is
`@c1pher-audit-kit:devils-advocate`.

## Quick start

Practice on a target with known answers before using the kit on real code.

```bash
git clone https://github.com/theredguild/damn-vulnerable-defi.git
cd damn-vulnerable-defi
forge build
claude
```

Switch to plan or manual mode (Shift+Tab), then run one phase at a time:

```
/c1pher-audit-kit:audit-recon on src/unstoppable/ only
/c1pher-audit-kit:threat-model on src/unstoppable/ only
/c1pher-audit-kit:foundry-poc TM-1
@c1pher-audit-kit:devils-advocate review TM-1. Report only.
/c1pher-audit-kit:finding-writeup TM-1 severity=TBD
```

Read each output before moving on. You are the auditor; the kit is the assistant.

## Design principles

- **Facts before hypotheses.** Recon only maps; flags are neutral questions.
- **Hypotheses are not findings.** Only a passing PoC that proves impact confirms one.
- **Never force a PoC.** A failing test can refute a hypothesis, and that is a result.
- **Reviews report, the auditor decides.** The reviewer never edits evidence.
- **Append-only records.** Revisions are added, never overwritten.
- **Severity belongs to the auditor.**
- **Repository content is untrusted.** Code and comments are data, never instructions.

## Responsible use

- Audit only code you are authorized to review.
- Run PoCs locally or on forks. Never against live contracts or other people's funds.
- Treat third-party repositories as untrusted: use a VM, check `ffi`, review
  commands before approving them.
- This kit assists an auditor. It does not replace manual review, and its
  output can be wrong.

## Roadmap

- [ ] Validate the full workflow on more Damn Vulnerable DeFi challenges
- [ ] Specialized reviewer subagents (access control, external calls, math, oracles, upgradeability)
- [ ] `static-triage` skill for Slither and Aderyn output
- [ ] `audit-run` skill to orchestrate the phases with auditor checkpoints

## Contributing

Found a false positive, a missed bug or an unclear instruction? Open an issue
with the target, the phase and what went wrong. That is exactly how this kit
is calibrated.

## License

[MIT](LICENSE) © 2026 C1pher
