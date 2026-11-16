# Internal Triage Agenda

**Meeting:** internal triage of the open questions, before any stakeholder is asked
**Chair:** QA (requirements confirmation) · **Length:** 120 minutes · **Prepared:** 15 November 2026

---

## 1. Purpose and outcome

There are **99 open questions**. Stakeholders' time is short, so they should only be asked what needs them. This meeting sorts every question into one of three piles:

| Pile | Meaning | What happens |
|---|---|---|
| **Answer internally** | Engineering can state the fact from the code or the hosting set-up. | Answered here. The owner is only asked to confirm. |
| **Ask a stakeholder** | It needs a business decision or a business fact. | Routed to one workshop, with one owner. |
| **Document fix** | The SRS or SAD is wrong or unclear. | Engineering fixes it in v0.2, now or after a linked answer. |

**We leave the room with:**

1. The four owners named, with deputies ([STAKEHOLDER-REGISTER.md](STAKEHOLDER-REGISTER.md)).
2. Every question routed (the triage sheet in section 4, complete).
3. The ten questions that block go-live, ranked.
4. Dates for four workshops and a play-back.
5. A send date for the pre-read.

## 2. Who, what to read, what to bring

| | |
|---|---|
| **Attend** | QA (chair) · Technical lead · an engineer who wrote the SRS and SAD · project lead |
| **Note-taker** | Not the chair. Use [SESSION-NOTES-TEMPLATE.md](SESSION-NOTES-TEMPLATE.md). |
| **Read before (30 min)** | [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) sections 1, 9 and 10 · [PROCESS-GAP-ANALYSIS.md](PROCESS-GAP-ANALYSIS.md) section 2 |
| **Bring** | Engineering: access to the code and the production settings, to answer facts on the spot. Project lead: calendars of the four owners. |
| **Not in this meeting** | Stakeholders. Solution design. Arguing about whether a gap is "really" a gap: log it and move on. |

## 3. Agenda

| # | Min | Item | Questions | Output |
|---|---|---|---|---|
| 1 | 10 | **Mandate and people.** What are we producing: a signed v0.1, or a v0.2 that reflects real decisions? Is the system already in use with real shipments? Is there a go-live date? Who are the four owners? Where do requirements and tests live? | Q1, Q2, Q3, Q4, Q9 | Register filled in. Mandate written in one sentence. |
| 2 | 15 | **Answer from the code now.** Engineering states each fact. QA writes it in the log as "Answered (Engineering), to be confirmed by owner". | TL-02, TL-04, TL-06, TL-08, TL-11, TL-12, TL-13, AC-14, AC-23, AC-25, AC-19, BO-07 (field list only), OP-15 (field list only), DOC-09 | Facts recorded. Fewer questions for stakeholders. |
| 3 | 20 | **Document fixes.** For each: fix now, or wait for which question? | DOC-01 to DOC-18 | Each DOC item marked "Fix now" or "Waits for …". |
| 4 | 25 | **Route the business questions.** One owner and one workshop each. Mark the ones that cross two owners. | Q5 to Q8; BO-01 to BO-15; AC-01 to AC-26; OP-01 to OP-18 | Route and Session columns filled. |
| 5 | 15 | **Technical items that need a name and a date.** | TL-01, TL-03, TL-05, TL-07, TL-09, TL-10 | Owner and target date for each. Worked examples (TL-10) requested, due before the first workshop. |
| 6 | 15 | **Rank what blocks go-live.** Start from the ten in the gap analysis. Agree the order to raise them. | BO-01, TL-01, BO-02, OP-02, AC-01, AC-03, AC-06, AC-15, BO-12, AC-08 | Ranked list of ten. "Blocks go-live?" column filled. |
| 7 | 10 | **Schedule.** Four workshops of 90 minutes and a 30-minute play-back, in this order: Operations, Accounting, Business owner, Technical. Pre-read goes out five working days before the first. | — | Dates in calendars. |
| 8 | 10 | **Actions.** Read back every action with an owner and a date. | — | Action list. |

**If time runs out:** items 1, 4 and 7 must finish. Items 2 and 3 can be completed by Engineering in writing within two working days.

## 4. Triage sheet

Every question is listed. **Route** and **Pre-work** are filled in as a starting point; change them in the meeting. Fill in the last two columns in the meeting.

Routes: `Internal` · `Operations` · `Accounting` · `Business` · `Technical` · `Doc fix`. Two routes means the first decides and the second is consulted.

### A. Interview questions

| ID | Topic | Route | Pre-work from Engineering | Blocks go-live? | Session |
|---|---|---|---|---|---|
| Q1 | Mandate; names of the four owners | Internal | | | Triage |
| Q2 | Is the system live with real shipments? | Internal | State what "live site" means | | Triage |
| Q3 | Go-live date and release gate | Internal → Business | | | |
| Q4 | Audience and home of the summary | Internal | | | Triage |
| Q5 | Name of the core record | Operations | | | |
| Q6 | Billing a consolidation | Accounting, Operations | | | |
| Q7 | Edits after approval | Operations, Accounting | | | |
| Q8 | Exchange rate and VAT on foreign-currency invoices | Accounting | | | |
| Q9 | Where requirements and tests live; existing meetings | Internal | | | Triage |

### B. Business owner

| ID | Topic | Route | Pre-work from Engineering | Blocks go-live? | Session |
|---|---|---|---|---|---|
| BO-01 | Four Must items not built: blockers or downgrade? | Business | Effort and date for each | | |
| BO-02 | Self-approval | Business, Operations | | | |
| BO-03 | More than one company? | Business | | | |
| BO-04 | Branches | Business, Operations | | | |
| BO-05 | Customer portal at go-live? | Business | | | |
| BO-06 | Password reset by support ticket | Business | | | |
| BO-07 | What the public lookup shows | Business | The exact list of fields returned today | | |
| BO-08 | Live connectors needed? | Business | | | |
| BO-09 | Legacy ledger cleanup; old production instance | Business, Technical | Dry-run result of the cleanup | | |
| BO-10 | Business volumes | Business | | | |
| BO-11 | Record retention | Business, Accounting | | | |
| BO-12 | Data migration and cut-over | Business | What import tools exist, if any | | |
| BO-13 | Training and acceptance sign-off | Business | | | |
| BO-14 | Administration, delete rights and audit access | Business | Which Role can manage users, change settings, delete what, and read the audit trail, today | | |
| BO-15 | Government filing: in scope or not? | Business | | | |

### C. Accounting lead

| ID | Topic | Route | Pre-work from Engineering | Blocks go-live? | Session |
|---|---|---|---|---|---|
| AC-01 | Consolidation: one invoice or one per house | Accounting, Operations | | | |
| AC-02 | Several bill-to parties on one file | Accounting | | | |
| AC-03 | Exchange rate source, timing, override | Accounting | Where the rate comes from today (see TL-08) | | |
| AC-04 | VAT treatment rules; withholding tax | Accounting | | | |
| AC-05 | Official invoice compliance | Accounting | One real invoice reference and invoice number; a printed sample | | |
| AC-06 | Credit note | Accounting | | | |
| AC-07 | Revenue split by service | Accounting | The list of charge codes | | |
| AC-08 | Collections, receipts, aging | Accounting | | | |
| AC-09 | Supplier bills and matching | Accounting | | | |
| AC-10 | Profit per file | Accounting | | | |
| AC-11 | Which income figure is official | Accounting | How the Overview figure is worked out | | |
| AC-12 | Reopening a closed month | Accounting | How it would be done today | | |
| AC-13 | Billing-to-ledger mode at go-live | Accounting, Business | | | |
| AC-14 | What is a "rate note"? | Internal → Accounting | Definition from the code | | |
| AC-15 | Who may trial-post and post | Business, Accounting | Which Roles can post today | | |
| AC-16 | Accountant rights on approved files | Accounting, Operations | What the code allows today | | |
| AC-17 | Billing for cartage, vehicles, dispatch | Accounting, Operations | | | |
| AC-18 | Who enters tariffs, by when | Business, Accounting | Format for bulk entry, if any | | |
| AC-19 | "Miscellaneous invoice" bridge item | Internal → Accounting | What it does and who can raise one | | |
| AC-20 | Re-issue after a re-rate | Accounting | What "marked for re-issue" shows on screen | | |
| AC-21 | Fiscal year and year-end close | Accounting | | | |
| AC-22 | Check disbursements and other payments | Accounting | | | |
| AC-23 | Is the trial post mandatory? | Internal → Accounting | Whether a Staged item can be posted directly today | | |
| AC-24 | Bridge items after a re-rate | Accounting | What happens to them today | | |
| AC-25 | Periods: one open month or several | Internal → Accounting | How periods behave today | | |
| AC-26 | Charge packages and Incoterm | Accounting | Where each is maintained today | | |

### D. Operations lead

| ID | Topic | Route | Pre-work from Engineering | Blocks go-live? | Session |
|---|---|---|---|---|---|
| OP-01 | Terminology: file, shipment, booking; vehicle | Operations | | | |
| OP-02 | Re-approval after an edit | Operations, Accounting | | | |
| OP-03 | Cancelling a shipment | Operations | | | |
| OP-04 | Dispatcher role | Operations | | | |
| OP-05 | Operators editing each other's drafts | Operations | | | |
| OP-06 | Who enters milestones, how soon | Operations | | | |
| OP-07 | Legal documents and formats | Operations | Printed sample of each document | | |
| OP-08 | File numbers for imported files | Operations | The file number prefixes | | |
| OP-09 | Arrival notice email | Operations | | | |
| OP-10 | Proof of delivery without a signature pad | Operations | | | |
| OP-11 | House number on a consolidation invoice | Accounting, Operations | | | |
| OP-12 | Approval turnaround and deputy | Operations | | | |
| OP-13 | What is a domestic file? | Operations | | | |
| OP-14 | Quote lifecycle | Operations | How a quote becomes Expired today | | |
| OP-15 | Required fields at submit | Internal → Operations | The exact required fields per mode | | |
| OP-16 | Notifications | Operations | What the to-do list shows per Role | | |
| OP-17 | RORO holds | Operations | Whether any marker blocks a status change | | |
| OP-18 | Legacy files treated as approved | Operations | How many such files exist | | |

### E. Technical lead

| ID | Topic | Route | Pre-work from Engineering | Blocks go-live? | Session |
|---|---|---|---|---|---|
| TL-01 | Backup and restore | Technical, Business | Options and effort | | |
| TL-02 | Concurrency and load test results | Internal | Load test notes | | |
| TL-03 | Penetration test and dependency audit | Technical | Quote and available dates | | |
| TL-04 | Encryption at rest | Internal | Host setting | | |
| TL-05 | Credential rotation | Technical | List of credentials to rotate | | |
| TL-06 | Unpaged list endpoints | Internal | The list | | |
| TL-07 | Test coverage of untested areas | Technical | | | |
| TL-08 | Exchange rate fetched in the browser | Internal → Accounting | Where the rate is used | | |
| TL-09 | Time zone | Technical, Accounting | Time zone in use today | | |
| TL-10 | Worked examples for the main checks | Technical | 3 to 5 examples per rule | | |
| TL-11 | Password policy and idle time-out values | Internal → Business | The values | | |
| TL-12 | Attachment types and scanning | Internal | The accepted types | | |
| TL-13 | Sign-in lifetimes and request limits | Internal | The production values | | |

### F. Document fixes

| ID | Topic | Route | Waits for | Blocks go-live? | Session |
|---|---|---|---|---|---|
| DOC-01 | Accountant "read-only" vs "may still edit" | Doc fix | AC-16 | | |
| DOC-02 | Self-approval: High risk but Should | Doc fix | BO-02 | | |
| DOC-03 | Connectors "required" but Could | Doc fix | BO-08 | | |
| DOC-04 | Dispatcher is not a Role | Doc fix | OP-04 | | |
| DOC-05 | Multi-company design vs single ledger | Doc fix | BO-03 | | |
| DOC-06 | Must items not built; no readiness statement | Doc fix | BO-01 | | |
| DOC-07 | House bill of lading in SAD only | Doc fix | OP-07 | | |
| DOC-08 | Two revisions numbered 0.1 | Doc fix | Fix now | | |
| DOC-09 | Undefined terms | Internal → Doc fix | AC-14, AC-22 for two of them | | |
| DOC-10 | VAT requirement in the wrong group | Doc fix | Fix now | | |
| DOC-11 | Acceptance criteria owners cannot read | Doc fix | TL-10 | | |
| DOC-12 | Performance "Built" on demo data only | Doc fix | BO-10 | | |
| DOC-13 | Viewer's ledger access unstated | Doc fix | Business owner to confirm | | |
| DOC-14 | Manager user-administration contradiction | Doc fix | BO-14 | | |
| DOC-15 | SAD has no Operations lead sign-off | Doc fix | Fix now | | |
| DOC-16 | Who maintains tariffs: two answers | Doc fix | AC-18 | | |
| DOC-17 | SAD traceability omits three Planned items | Doc fix | Fix now | | |
| DOC-18 | Usability, constraints, assumptions have no owner | Doc fix | Business owner to assign | | |

## 5. Triage rules

1. **A question goes to a stakeholder only if it needs a business decision or a business fact.** If Engineering can answer it from the code, answer it here and ask the owner only to confirm.
2. **One owner, one workshop.** A question that crosses two owners is raised with the one who decides and confirmed with the other. The cross-owner list is in [workshops/README.md](workshops/README.md).
3. **Never drop a question.** If nobody wants it, mark it `Deferred` in the log with a reason and a name.
4. **Do not answer for the business.** "They'll want it this way" is a proposal, not an answer. It stays in the Proposed column.
5. **A fact is not a decision.** "The code allows managers to post" answers "what happens today". It does not answer "should it".
6. **Record as you go.** Every answer goes into [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) in the meeting, with who said it and the date.

## 6. Output checklist

- [ ] Four owners and their deputies named in [STAKEHOLDER-REGISTER.md](STAKEHOLDER-REGISTER.md)
- [ ] Practitioners to invite named (register, section 2)
- [ ] Every row of the triage sheet has a Route and a Session
- [ ] Internal answers written into [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) as "Answered (Engineering), to be confirmed"
- [ ] Each DOC item marked "Fix now" or "Waits for …"
- [ ] Ten go-live blockers ranked
- [ ] Engineering pre-work assigned, due two working days before the workshop that needs it
- [ ] Worked examples requested from Engineering (TL-10)
- [ ] Four workshops and the play-back in calendars
- [ ] Pre-read ([STAKEHOLDER-SUMMARY.md](STAKEHOLDER-SUMMARY.md) and [GLOSSARY.md](GLOSSARY.md)) send date agreed: five working days before the first workshop
- [ ] Demo copy of the system available for the workshops
