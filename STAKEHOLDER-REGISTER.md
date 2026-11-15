# Stakeholder Register

**Purpose:** who decides what, who must be consulted, and who knows how the work is really done. Fill in the blanks at the internal triage meeting ([INTERNAL-TRIAGE-AGENDA.md](INTERNAL-TRIAGE-AGENDA.md), item 1).

**Owner of this register:** QA (requirements confirmation) · **Date:** 15 November 2026

> **Privacy.** This is the only document in the pack that holds people's names. Keep contact details out of it if the repository is shared outside the team; write "see company directory" in that column.

---

## 1. The four owners

The SRS names four owner roles but no people (open question Q1). Nothing can be confirmed until each row has a name.

| Area | Role in the SRS | Name | Deputy | Decides | Is consulted on | Best way to reach | Availability |
|---|---|---|---|---|---|---|---|
| Business | Business owner | | | Scope, priorities, roles and controls, the release gate, go-live readiness. Questions BO-01 to BO-14. Breaks any tie between owners. | Segregation of duties (AC-15), tariff ownership (AC-18), what the public sees (BO-07) | | |
| Accounting | Accounting lead | | | Billing, tax, exchange rates, the Accounting Bridge, the Ledger, Periods. Questions AC-01 to AC-22. | Retention period (BO-11), edits after approval (OP-02), house number on invoices (OP-11) | | |
| Operations | Operations lead | | | Freight Files, approval, cartage, dispatch, tracking, printed documents. Questions OP-01 to OP-18. | Consolidation billing (AC-01), billing of trucking and RORO (AC-17), Self-approval in small offices (BO-02), Branches (BO-04) | | |
| Technical | Technical lead | | | Feasibility, security, performance, backup, deployment. Questions TL-01 to TL-12 and document fixes DOC-01 to DOC-18. | Exchange rate source (AC-03), volumes (BO-10), time zone (TL-09) | | |

## 2. Other people to interview

The owners decide. These people **know how the work is done today**. Invite one or two to the matching workshop, or shadow them for half an hour beforehand.

| Who | Why they matter | Name | Workshop | Ask them to bring |
|---|---|---|---|---|
| An Operator who types up bookings (ocean) | Knows the real steps, the workarounds and the fields nobody fills in | | 1 Operations | The last three files they booked |
| An Operator who handles air consolidations | Knows how houses are entered and billed today | | 1 Operations, 2 Accounting | One real consolidation: manifest, house waybills, invoices |
| A Manager who approves files | Knows what is actually checked, and what happens when they are away | | 1 Operations | Examples of files they sent back, and why |
| A dispatcher or trucking coordinator | Not a Role in the system (OP-04); knows cartage and proof of delivery | | 1 Operations | A day's delivery sheet and a signed proof of delivery |
| A person who handles RORO vehicles | Knows holds, titles and customs steps | | 1 Operations | A vehicle intake record |
| An Accountant who bills | Knows how charges are really worked out and corrected | | 2 Accounting | A real invoice, a corrected invoice, the current rate sheet |
| An Accountant who posts and closes the month | Knows the month-end steps and what goes wrong | | 2 Accounting | The month-end checklist; the chart of accounts |
| The Superadmin or system administrator | Knows how users are set up and what support requests come in | | 3 Business owner, 4 Technical | The list of users and Roles |
| An engineer who wrote the SRS and SAD | Answers "what does it do today?" | | All | — |

## 3. Who is responsible for what (RACI)

**R** does the work · **A** is accountable and signs · **C** is consulted before · **I** is told after

| Activity | QA | Business owner | Accounting lead | Operations lead | Technical lead | Engineering |
|---|:-:|:-:|:-:|:-:|:-:|:-:|
| Prepare and run workshops; keep the question log | R, A | I | I | I | I | C |
| Answer a business question in their own area | R (records) | A (BO) | A (AC) | A (OP) | C | C |
| Answer a technical question | R (records) | I | I | I | A | R |
| Change a requirement's wording in the SRS | C | I | A (own area) | A (own area) | A (own area) | R |
| Accept a gap or limitation for go-live | C | A | C | C | C | I |
| Downgrade a **Must** requirement | C | A | C | C | C | I |
| Decide when two owners disagree | R (presents both views) | A | C | C | C | I |
| Issue SRS and SAD v0.2 | C | I | I | I | A | R |
| Sign v0.2 | I | A | A | A | A | I |
| Accept the working system (user acceptance) — *owner not yet named, BO-13* | C | A | R | R | C | I |

## 4. Rules

1. **One owner per question.** Each question in [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) has exactly one person who decides. Others are consulted.
2. **Tie-break.** When two owners disagree, QA writes down both positions in one sentence each and takes them to the Business owner, who decides. The decision is logged with both positions.
3. **A deputy can decide** only if the owner has said so in writing. Otherwise the deputy's answer is recorded as "provisional" and confirmed by the owner afterwards.
4. **Silence is not agreement.** An unanswered question stays Open. After two reminders it goes to the Business owner.
5. **Practitioners inform; owners decide.** What an Operator or Accountant tells us about today's process is recorded as an as-is fact, not as a decision.

## 5. Contact log

| Date | Who | About (question IDs) | Outcome | Next step |
|---|---|---|---|---|
| | | | | |
