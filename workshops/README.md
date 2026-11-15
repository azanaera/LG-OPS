# Workshop Walkthrough Scripts

**Purpose:** scripts for the facilitator (QA) to walk each owner through their part of the process, learn how the work is really done, and get decisions on the open questions.

**Prepared:** 15 November 2026 · **Run after:** the [internal triage](../INTERNAL-TRIAGE-AGENDA.md) · **Pre-read sent to owners:** [STAKEHOLDER-SUMMARY.md](../STAKEHOLDER-SUMMARY.md), [GLOSSARY.md](../GLOSSARY.md)

---

## 1. The sessions, and why in this order

| # | Session | Owner | Length | Script | Why here |
|---|---|---|---|---|---|
| 1 | Operations | Operations lead | 90 min | [01-operations.md](01-operations.md) | The process starts with a booking. Everything later depends on how files are created, approved and consolidated. |
| 2 | Accounting | Accounting lead | 90 min | [02-accounting.md](02-accounting.md) | Billing rules build on what Operations said about files and consolidations. |
| 3 | Business owner | Business owner | 90 min | [03-business-owner.md](03-business-owner.md) | Decides what sessions 1 and 2 could not, and the release gate. |
| 4 | Technical | Technical lead | 90 min | [04-technical.md](04-technical.md) | Turns the decisions into dates and names. |
| 5 | Play-back | All four | 30 min | Read back the decisions from [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md); collect sign-off on the Stakeholder Summary | Everyone hears the same decisions once. |

Leave at least two working days between sessions, so that the log is updated and carried items are ready.

## 2. Ground rules for the facilitator

1. **As-is before to-be.** For every topic, first ask how the work is done today. Only then show what the system does. The documents were written from the code; the owner has probably never been asked.
2. **Open question first.** Never open with the proposed answer. If the owner has a view, record it. Offer the proposal only when they have none, and say plainly that it is a proposal.
3. **One question at a time.** Then wait. Silence is thinking.
4. **Ask for the last real case.** "Tell me about the last file you sent back" gets a truer answer than "what is your approval policy?"
5. **Say the decision back in one sentence, and write it where they can see it.** "So: a change to the weight after approval sends the file back for approval. Correct?"
6. **"I don't know" is a good answer.** It goes in the parking lot with a name and a date.
7. **No solution design in the room.** If the talk turns to screens and buttons, say: "Let's note the need; the team will design it."
8. **A fact from a practitioner is not a decision.** Record what an operator or accountant tells you as an as-is fact. Decisions come from the owner.
9. **Stop on time.** Unfinished topics are carried, not rushed.

## 3. Who is in the room

| Role | Who | Job in the session |
|---|---|---|
| Facilitator | QA | Runs the script. Does not take the notes. |
| Note-taker | A second team member | Fills in [SESSION-NOTES-TEMPLATE.md](../SESSION-NOTES-TEMPLATE.md) live. |
| Owner | The lead for the area | Decides. |
| Practitioners | One or two people who do the work daily (see [STAKEHOLDER-REGISTER.md](../STAKEHOLDER-REGISTER.md) section 2) | Describe today's process. |
| Engineer | One who knows the build | Answers "what does it do today?" and shows the demo copy. **Listens; does not defend the build.** |

## 4. What to prepare

- [ ] Pre-read sent five working days before; owner asked to mark it up.
- [ ] The script printed or open, with the triage results written in: which questions were already answered internally and only need confirming.
- [ ] The demo copy of the system open on the right screens. **Never the production system.**
- [ ] Worked examples from Engineering for this session's rules (TL-10).
- [ ] Real artefacts asked for in advance: a recent file, an invoice, a manifest, the rate sheet.
- [ ] A copy of [SESSION-NOTES-TEMPLATE.md](../SESSION-NOTES-TEMPLATE.md) for the note-taker.
- [ ] Carried items from earlier sessions listed at the top of the script.

## 5. How every topic is laid out

Each topic in a script uses the same block. Work down it in order.

```markdown
### Topic 3 — Approving a file (15 min) · V-14 to V-21 · OP-02, OP-12
**As-is — ask first:** the question about how it is done today.
**Listen for:** what to notice in the answer.
**Show:** the page of the Stakeholder Summary, or the demo screen.
**Say:** what the system does today, in the owner's words.
**Ask:**
1. A question. → the question ID it answers
**If no view — offer:** the Proposed answer from OPEN-QUESTIONS.md for that ID. Say it is a proposal.
**Record:** decision · who decided · any new term.
**Probe if time:** edge cases.
```

- **V-numbers** are the numbered items in the [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) that the owner was asked to mark.
- **Question IDs** point to [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md). Read the question's "Why it matters" before the session; do not read it out.
- **"Say" lines are written to be read aloud.** They contain no requirement numbers and no technical words.

## 6. Questions that cross two owners

Raise each with the owner who **decides**, and confirm it with the one who is **consulted**. If they disagree, the Business owner decides ([register](../STAKEHOLDER-REGISTER.md), rule 2).

| Question | About | Decides | Consulted | Raised in | Confirmed in |
|---|---|---|---|---|---|
| AC-01, OP-11 | How a consolidation is invoiced; the house number on the invoice | Accounting lead | Operations lead | Session 1 (as-is only) | Session 2 |
| OP-02, AC-16 (Q7) | Re-approval after an edit; whether accountants can edit files | Operations lead (re-approval); Accounting lead (accountant rights) | Each other | Session 1 | Session 2 |
| AC-17 | Billing for trucking, vehicle shipping and delivery runs | Accounting lead | Operations lead | Session 1 (which services are sold) | Session 2 |
| BO-02 | Self-approval | Business owner | Operations lead | Session 1 (the one-person-office reality) | Session 3 |
| BO-04 | Branches | Business owner | Operations lead | Session 1 | Session 3 |
| BO-07 | What the public lookup shows | Business owner | Operations lead | Session 1 | Session 3 |
| BO-11 | Record retention | Business owner | Accounting lead | Session 2 (the legal period) | Session 3 |
| AC-15 | Who may post | Business owner | Accounting lead | Session 2 | Session 3 |
| AC-18, DOC-16 | Who enters tariffs | Business owner | Accounting lead, Operations lead | Session 2 | Session 3 |
| AC-13 | Billing-to-ledger mode at go-live | Accounting lead | Business owner | Session 2 | Session 3 |
| AC-03, TL-08 | Exchange rate rule and where the rate comes from | Accounting lead | Technical lead | Session 2 | Session 4 |
| BO-10, TL-02 | Volumes and whether the system copes | Business owner (volumes) | Technical lead | Session 3 | Session 4 |
| TL-01 | How much data may be lost; how long a restore may take | Business owner (the limits) | Technical lead (the method) | Session 3 | Session 4 |
| TL-09 | Time zone | Technical lead | Accounting lead | Session 2 | Session 4 |
| TL-11 | Password and idle time-out values | Business owner | Technical lead | Session 3 | Session 4 |

## 7. After each session

Within **one working day**:

1. Update [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md): status, who decided, date, the decision in one sentence.
2. If a term changed, update [CONTEXT.md](../CONTEXT.md) and [GLOSSARY.md](../GLOSSARY.md).
3. Tick or correct the matching entries in [requirements-breakdown/](../requirements-breakdown/README.md).
4. Fill in "How the business does it today" in [PROCESS-GAP-ANALYSIS.md](../PROCESS-GAP-ANALYSIS.md) for every as-is fact learned.
5. Send the notes to the owner: "This is what I understood. Please correct anything by (date)."
6. Add unanswered and parking-lot items to the top of the next session's script.

## 8. When it goes off script

| What happens | What to do |
|---|---|
| "That's not how we work at all." | Good. Stop showing the system. Ask them to walk you through the real steps and write them down. That is the most valuable thing you can learn. |
| "Just make it work like the old way." | "Walk me through the old way for one real job." Then note each step. |
| The owner starts designing screens. | "I'll note that you need to see X at that point. The team will work out how." |
| The engineer explains why it was built that way. | "Thanks. Let's hear how the business needs it first." |
| "Yes, yes, that's fine" to everything. | Ask for an example: "When did that last happen? What did you do?" |
| The owner cannot decide. | Parking lot, with a name and a date. Ask: "What would you need to know to decide?" |
| Two people in the room disagree. | Write both views down. Do not settle it. The owner decides, or it goes to the Business owner. |
| A new question comes up. | Give it the next ID in its group and add it to the log after the session. |
