# Requirements Breakdown: method

**Purpose:** take each of the 125 requirements in SRS v0.1, test whether it is detailed enough to build and test, and refine it where it is not. The refined statements and worked examples are what the owners confirm in the workshops.

**Prepared by:** QA (requirements confirmation) · **Date:** 15 November 2026

| File | Owner who confirms | Requirement groups | Entries |
|---|---|---|---|
| [01-operations.md](01-operations.md) | Operations lead | FR-OV, FR-AP, FR-SH, FR-VH, FR-PD, FR-FD, FR-TR, FR-PT, FR-MP | 42 |
| [02-accounting.md](02-accounting.md) | Accounting lead | FR-RT, FR-BL, FR-BR, FR-FS, NFR-AU | 33 |
| [03-business-and-technical.md](03-business-and-technical.md) | Business owner; Technical lead | FR-AU, FR-AD, IFR, NFR-SE, NFR-PF, NFR-AV, NFR-US, NFR-MT, DR, plus constraints and assumptions | 50 |

Owners follow the SRS traceability matrix (SRS §8).

---

## The "detailed enough" test

A requirement passes only if **all six** are true.

| # | Test | Fails when the requirement says… |
|---|---|---|
| 1 | **One behaviour.** | Several behaviours joined by "and". |
| 2 | **A named Role as the actor.** | "User", "staff", "an authorised user". |
| 3 | **A trigger and a starting condition.** | What happens, but not when or from which state. |
| 4 | **A result a tester can see** without reading code. | "check:billing passes". |
| 5 | **Every value stated.** | "A period of inactivity", "a recent password", "by the carrier rule". |
| 6 | **Every term defined** in [CONTEXT.md](../CONTEXT.md) and not marked ⚑. | "Rate note", "equipment", "tracking fields". |

## Verdicts

| Verdict | Meaning | What happens next |
|---|---|---|
| **Detailed enough** | Passes the test, or fails only on small points listed under "ask". | The owner confirms the examples. |
| **Refined** | Split into child statements (`FR-AP-02.1`). | The owner confirms each child. Engineering adopts the children in v0.2. |
| **Blocked** | Cannot be refined until the linked question is answered. | Answer the question first, then refine. |

## Entry template

Every entry uses this layout. The heading is always `### <ID> <short title>`.

```markdown
### FR-AP-02 Submit a Freight File for approval
**Source (SRS, verbatim):** "The system shall move a draft or returned file to pending on submit, …"
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-02.1 | A Freight File in Draft or For Correction can be submitted. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* … *when* … *then* …  (at least one that succeeds and one that is refused)

**Not stated — ask:** what is missing, with the question ID.
**Engineering check:** the automated check the SRS names, if any.
```

Non-functional requirements use a fit table in place of the worked examples: `Measure | Target | How measured | On what data | Current evidence`.

## Rules

1. **Quote the SRS exactly.** The source line is never reworded.
2. **Do not invent behaviour.** A child statement only splits or names what the SRS or SAD already says. Detail taken from the SAD cites its section.
3. **Anything new is a candidate requirement.** It goes in the "Candidate requirements" table at the end of each file as `CR-nn`, tied to a question. It is not a requirement until the owner agrees.
4. **Examples use real numbers.** The same numbers are used in the [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) and the [workshop scripts](../workshops/README.md), so everyone confirms the same case. Every example is "to be confirmed" until the owner ticks it.
5. **Terms** follow [CONTEXT.md](../CONTEXT.md).
6. **Decisions are not recorded here.** Tick "Confirmed" only after the answer is in [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md).

## Candidate requirement numbering

| Range | File |
|---|---|
| CR-01 to CR-19 | 01-operations.md |
| CR-20 to CR-39 | 02-accounting.md |
| CR-40 to CR-59 | 03-business-and-technical.md |

## Totals

| File | Detailed enough | Refined | Blocked | Total |
|---|---|---|---|---|
| 01-operations.md | | | | 42 |
| 02-accounting.md | | | | 33 |
| 03-business-and-technical.md | | | | 50 |
| **All** | | | | **125** |
