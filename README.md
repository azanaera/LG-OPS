# Requirements Elicitation Pack: the Platform

Everything QA needs to confirm the requirements of the Platform with its four owners (Business owner, Accounting lead, Operations lead, Technical lead) and turn SRS v0.1 and SAD v0.1 into a confirmed v0.2.

> **Remember:** Engineering wrote the SRS and SAD from the code. They describe what the system does today, not what the business has agreed it needs. Nothing in this pack is agreed until its owner confirms it.

**Pack date:** 15 November 2026 · **Source documents:** `Document_SRS_v0.1_REDACTED.pdf`, `Document_SAD_v0.1_REDACTED.pdf` (both 8 November 2026)

## Start here (QA reading order)

1. BA Requirements Study Guide
2. [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md)
3. Process Gap Analysis
4. Requirements breakdown
5. Internal Triage Agenda
6. Workshop scripts

## The process

| # | Step | Uses | Output |
|---|---|---|---|
| 1 | Internal triage | Internal Triage Agenda, Stakeholder Register | Named owners; every question routed; workshop dates |
| 2 | Send the pre-read, five working days before the first workshop | Stakeholder Summary, Glossary | Owners arrive having read the process description |
| 3 | Run the workshops: Operations, Accounting, Business owner, Technical, then a play-back | Workshop scripts, Session Notes Template | Decisions and as-is facts |
| 4 | Record decisions within one working day | [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) | One log of who decided what, and when |
| 5 | Engineering issues SRS and SAD v0.2 | Requirements breakdown, the log | Documents the owners can sign |

## The documents

| File | What it is for | Audience |
|---|---|---|
| [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) | What the system does today, in plain language | Team and stakeholders |
| [CONTEXT.md](CONTEXT.md) | Canonical term names and the words to avoid | Developers, testers |
| [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) | The one log of questions, proposals and decisions | QA (owner) |
| `tools/check-docs.sh` | Checks that every requirement and question is covered and every link works. Run `bash tools/check-docs.sh` from this folder. | QA |

## Rules for keeping the pack consistent

- **One log.** Answers and decisions are written only in [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md). Other documents link to the question ID.
- **One list of terms.** [CONTEXT.md](CONTEXT.md) holds the term names. The stakeholder glossary shows the same terms in plain words.
- **IDs never change.** New questions take the next number in their group. Refined requirements are children of the original (`FR-AP-02.1`). Candidate new requirements are `CR-nn`. Gaps are `GAP-nn`.
- **Describe, do not agree.** Write "the system currently does this" until the owner confirms it.
