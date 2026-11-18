# Requirements Elicitation Pack: the Platform

Everything QA needs to confirm the requirements of the Platform with its four owners (Business owner, Accounting lead, Operations lead, Technical lead) and turn SRS v0.1 and SAD v0.1 into a confirmed v0.2.

> **Remember:** Engineering wrote the SRS and SAD from the code. They describe what the system does today, not what the business has agreed it needs. Nothing in this pack is agreed until its owner confirms it.

**Pack date:** 15 November 2026 · **Source documents:** `Document_SRS_v0.1_REDACTED.pdf`, `Document_SAD_v0.1_REDACTED.pdf` (both 8 November 2026)

**Where things stand:** 125 requirements · 99 open questions, none answered yet · 72 gaps, 21 of them High · 80 requirements not yet detailed enough to confirm as written.

## Start here (QA reading order)

1. [BA-REQUIREMENTS-STUDY-GUIDE.md](BA-REQUIREMENTS-STUDY-GUIDE.md) — how to do this job, with a seven-day study plan
2. [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) — what the system does today
3. [PROCESS-GAP-ANALYSIS.md](PROCESS-GAP-ANALYSIS.md) — what is missing, contradictory or undefined
4. [requirements-breakdown/](requirements-breakdown/README.md) — each requirement refined, with worked examples
5. [INTERNAL-TRIAGE-AGENDA.md](INTERNAL-TRIAGE-AGENDA.md) — the first meeting to hold
6. [workshops/](workshops/README.md) — the scripts for each stakeholder session

For the whole shipment on one page, see the [process map](process-map/freight-lifecycle-map.html).

## The process

| # | Step | Uses | Output |
|---|---|---|---|
| 1 | Internal triage | [INTERNAL-TRIAGE-AGENDA.md](INTERNAL-TRIAGE-AGENDA.md), [STAKEHOLDER-REGISTER.md](STAKEHOLDER-REGISTER.md) | Named owners; every question routed; workshop dates |
| 2 | Send the pre-read, five working days before the first workshop | [STAKEHOLDER-SUMMARY.md](STAKEHOLDER-SUMMARY.md), [GLOSSARY.md](GLOSSARY.md) | Owners arrive having read and marked up the process description |
| 3 | Run the workshops: Operations, Accounting, Business owner, Technical, then a play-back | [workshops/](workshops/README.md), [SESSION-NOTES-TEMPLATE.md](SESSION-NOTES-TEMPLATE.md) | Decisions and as-is facts |
| 4 | Record decisions within one working day | [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) | One log of who decided what, and when |
| 5 | Engineering issues SRS and SAD v0.2 | [requirements-breakdown/](requirements-breakdown/README.md), the log | Documents the owners can sign |

## The documents

### For stakeholders

| File | What it is for |
|---|---|
| [STAKEHOLDER-SUMMARY.md](STAKEHOLDER-SUMMARY.md) | Business Process Summary for Validation. The process in business words, 61 numbered items to mark correct or wrong, what is not done today, ten decisions, and a sign-off block. |
| [GLOSSARY.md](GLOSSARY.md) | The words we use, in plain language, with the words each office may use for the same thing. |
| [process-map/](process-map/freight-lifecycle-map.html) | The freight lifecycle top to bottom, steps 1 to 14, with the documents needed at each step and what the platform covers. Source swimlane: [swimlane.png](process-map/swimlane.png). Open the HTML in a browser (filter by ocean, air or consolidation) or use the [PNG](process-map/freight-lifecycle-map.png). |
| [process-map/PLAIN-ENGLISH.md](process-map/PLAIN-ENGLISH.md) | One page for people new to logistics: how a shipment works from first request to month-end, using a made-up example. |

### For QA and the delivery team

| File | What it is for |
|---|---|
| [BA-REQUIREMENTS-STUDY-GUIDE.md](BA-REQUIREMENTS-STUDY-GUIDE.md) | Self-study for a QA doing business-analyst work: freight and accounting basics, how to read a requirement, how to ask, how to run the room, a self-test. |
| [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) | Plain-language summary of scope, roles, process, rules, build status and owners. |
| [PROCESS-GAP-ANALYSIS.md](PROCESS-GAP-ANALYSIS.md) | 72 gaps by process step, each with a type, a severity, the question that settles it and a blank column for how the business works today. |
| [requirements-breakdown/README.md](requirements-breakdown/README.md) | The "detailed enough" test, the entry template and the totals. |
| [requirements-breakdown/01-operations.md](requirements-breakdown/01-operations.md) | 42 requirements confirmed by the Operations lead. |
| [requirements-breakdown/02-accounting.md](requirements-breakdown/02-accounting.md) | 33 requirements confirmed by the Accounting lead. |
| [requirements-breakdown/03-business-and-technical.md](requirements-breakdown/03-business-and-technical.md) | 50 requirements confirmed by the Business owner and the Technical lead, plus constraints and assumptions. |
| [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) | The one log of 99 questions, proposed answers and decisions. |
| [CONTEXT.md](CONTEXT.md) | Canonical term names and the words to avoid, for tickets, tests and screens. |

### For running the sessions

| File | What it is for |
|---|---|
| [STAKEHOLDER-REGISTER.md](STAKEHOLDER-REGISTER.md) | Who decides what, who to interview, who is responsible, and the tie-break rule. Names are blank until triage. |
| [INTERNAL-TRIAGE-AGENDA.md](INTERNAL-TRIAGE-AGENDA.md) | 120-minute agenda and a triage sheet listing every question. |
| [workshops/README.md](workshops/README.md) | Session order, ground rules, the topic layout, cross-owner questions, what to do afterwards. |
| [workshops/01-operations.md](workshops/01-operations.md) | Script: Operations lead. |
| [workshops/02-accounting.md](workshops/02-accounting.md) | Script: Accounting lead. |
| [workshops/03-business-owner.md](workshops/03-business-owner.md) | Script: Business owner. |
| [workshops/04-technical.md](workshops/04-technical.md) | Script: Technical lead. |
| [SESSION-NOTES-TEMPLATE.md](SESSION-NOTES-TEMPLATE.md) | Minutes, decisions, as-is facts, parking lot and confirmation steps. Copy once per session. |

### Tooling

| File | What it is for |
|---|---|
| `tools/check-docs.sh` | Checks that every requirement and question is covered, every glossary term is present and every link works. Run `bash tools/check-docs.sh` from this folder; it prints `OK` when the pack is consistent. |

## Rules for keeping the pack consistent

- **One log.** Answers and decisions are written only in [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md). Other documents link to the question ID.
- **One list of terms.** [CONTEXT.md](CONTEXT.md) holds the term names. [GLOSSARY.md](GLOSSARY.md) shows the same terms in plain words.
- **IDs never change.** New questions take the next number in their group. Refined requirements are children of the original (`FR-AP-02.1`). Candidate new requirements are `CR-nn`. Gaps are `GAP-nn`. Validation items are `V-nn`.
- **Describe, do not agree.** Write "the system currently does this" until the owner confirms it.
- **Update order after an answer:** the log → the terms → the breakdown → the gap analysis. Then run the check.

## Not in this pack yet

| Document | When |
|---|---|
| Requirements traceability matrix and test plan | After v0.2, from the confirmed breakdown |
| User acceptance test scripts per role | After the owners sign |
| To-be process maps (swim lanes) | Once the as-is facts from the workshops are in |
| Data migration and cut-over plan | After the Business owner answers BO-12 |
