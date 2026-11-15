# Process Gap Analysis: the Platform

**Compares:** what SRS v0.1 and SAD v0.1 say the system does, against a complete and consistent business process, step by step.

**Prepared by:** QA (requirements confirmation) · **Date:** 15 November 2026 · **Companions:** [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) · [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) · [CONTEXT.md](CONTEXT.md)

---

## 1. How to read this

> **The business's real process is not yet known.** The SRS and SAD were written from the code. Nobody has written down how staff do this work today. So this document cannot yet say "the business does X and the system does Y". It says where the documented system is incomplete, contradicts itself, or leaves a rule unstated.

The column **"How the business does it today"** is empty on purpose. Fill it in during the workshops, using the as-is questions in the [workshop scripts](workshops/README.md). A gap is only confirmed, changed or closed once that column is filled.

| Field | Meaning |
|---|---|
| **GAP ID** | Permanent. Never renumber. New gaps take the next number. |
| **What the documents say** | Always worded as what the system currently does, with its source. |
| **Question** | The question in [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) whose answer settles the gap. Decisions are recorded there, not here. |
| **Proposed resolution** | A recommendation only. It is not agreed until the owner confirms it. |

### Gap types

| Type | Meaning |
|---|---|
| **Missing** | The process needs it and no requirement covers it. |
| **Contradiction** | Two statements in the documents disagree. |
| **Undefined** | A term, value or rule is used but never stated. |
| **Unbuilt** | The requirement exists but is Planned, Partial or limited. |
| **Unverified** | Claimed as done, but not proven at real scale or by the right person. |
| **Control** | A weakness in who may do what, or in the record of it. |

### Severity

| Severity | Meaning |
|---|---|
| **High** | Blocks go-live, or puts money, compliance or data at risk. |
| **Medium** | A workaround exists, but it costs effort or causes errors. |
| **Low** | Cosmetic, or already accepted by the business (needs a named person who accepted it). |

---

## 2. Summary

**72 gaps.**

| By severity | Count | | By type | Count |
|---|---|---|---|---|
| High | 21 | | Missing | 20 |
| Medium | 38 | | Undefined | 17 |
| Low | 13 | | Unbuilt | 14 |
| | | | Control | 7 |
| | | | Contradiction | 7 |
| | | | Unverified | 7 |

### The ten to raise first

| # | Gap | In one line | Owner |
|---|---|---|---|
| 1 | GAP-56 | Four **Must** requirements are not built, so by the SRS's own rule the system cannot be released. | Business owner |
| 2 | GAP-57 | No backup and restore for two single-file databases. | Technical lead |
| 3 | GAP-15 | A manager can submit and approve the same file. | Business owner |
| 4 | GAP-16 | An approved file can be edited and re-billed with no second check. | Operations lead |
| 5 | GAP-33 | "One invoice per file" cannot bill the many customers of a consolidation. | Accounting lead |
| 6 | GAP-35 | No exchange rate rule, although invoices are in USD and the ledger is in PHP. | Accounting lead |
| 7 | GAP-38 | No credit note. | Accounting lead |
| 8 | GAP-45 | Nothing stops one person approving, billing and posting the same file. | Business owner |
| 9 | GAP-01 | No plan for loading existing data or opening balances. | Business owner |
| 10 | GAP-53 | Nothing after the invoice: no customer payments, receipts or aging. | Accounting lead |

---

## 3. Gaps by process step

```
Before ──► 1 Quote ──► 2 Booking ──► 3 APPROVAL ──► 4 Movement ──► 5 Tracking
                                         │
                                         ▼
                                    6 Billing ──► 7 BRIDGE ──► 8 Ledger ──► After
```

### Before step 1: set-up and go-live preparation

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-01 | The Platform "replaces spreadsheet and paper steps" (SRS §2.1). No loading of existing data is described. | | No plan for existing customers, open files, tariffs or ledger opening balances, and no cut-over date. | Missing | High | BO-12 | A migration plan with an owner and a date. |
| GAP-02 | Tariffs are entered by the business. Only one lane has a known rate (SRS A-01, App. B #4; SAD R-03). | | Automatic billing produces "no tariff" for almost every file. The documents disagree on who enters tariffs. | Unbuilt | High | AC-18, DOC-16 | A named owner and a date before go-live. |
| GAP-03 | The ledger is assumed to hold every account that charge codes map to (SRS A-02). A legacy ledger cleanup has not been run on production (SAD R-06; App. B #3). | | Nobody has confirmed the chart, and leftover rows remain in the production ledger. | Unverified | Medium | BO-09 | Accounting lead confirms the chart. Cleanup runs before go-live after a dry run and a verified backup. |
| GAP-04 | Four owners "confirm" the requirements (SRS Review and Approval). | | Nobody is named to train users or to accept the working system. | Missing | Medium | BO-13 | The owner of each area signs acceptance for it. |
| GAP-05 | A "live site" deploys from main, and a stopped earlier production instance still exists (SAD §2.3). | | It is unclear whether staff already use the system for real shipments, and what happens to the old instance. | Undefined | Medium | BO-09 | Confirm the fact (Q2). Archive, then remove, the old instance. |
| GAP-06 | The owner rotates development credentials before go-live (SRS A-04; SAD R-13). | | No named person and no date. | Unbuilt | Medium | TL-05 | A named person and a date, signed off. |

### Step 1: Quote

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-07 | A quote is Draft, Sent, Accepted, Rejected or Expired. An accepted quote replaces the tariff prices on the file (SRS FR-RT-04, FR-SH-07). | | Nothing says who marks a quote Sent or Accepted, what proves the customer accepted, or how a quote expires. | Undefined | Medium | OP-14 | Record who accepted and when. Expire by validity date. |

### Step 2: Booking, cargo and documents

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-08 | Submit checks shipper, consignee, bill-to, origin, destination, "dates" and "cargo" (SRS FR-AP-02). | | Which dates and which cargo fields is not stated, nor whether they differ by mode. | Undefined | Medium | OP-15 | List the required fields for each mode. |
| GAP-09 | A file is ocean or air, and export, import or domestic (SRS FR-SH-01). | | "Domestic" is not explained. Trucking-only work has no file. | Undefined | Medium | OP-13 | Define a domestic file. |
| GAP-10 | A file created through the API, not the form, gets a generic file number (SRS App. B #11; SAD R-11). | | If files are ever imported, their numbers will not follow the pattern. | Unbuilt | Low | OP-08 | Add prefix rules only if imports are planned. |
| GAP-11 | Operators can edit each other's draft files (SRS App. B #7; SAD R-08). | | "Accepted by the business", but no named person accepted it. | Control | Low | OP-05 | Record who accepted it. |
| GAP-12 | A consolidation holds many house air waybills under one master. Its invoice repeats the master number as the house number (SRS App. B #8; SAD R-07). | | The invoice cannot show which house customer it is for. | Missing | Medium | OP-11 | Follows the decision on consolidation billing (GAP-33). |
| GAP-13 | Documents print from the browser with branded layouts. The SAD lists a house bill of lading; the SRS does not (SRS FR-SH-09; SAD §7.2). | | Nobody has checked the layouts against legal or carrier formats. | Unverified | Medium | OP-07, DOC-07 | Operations lead lists the documents with a required format. |
| GAP-14 | The arrival notice email is a preview until email sending is set up (SRS App. B #10; SAD R-10). | | Arrival notices cannot be emailed from the system. | Unbuilt | Medium | OP-09 | Decide whether email is needed at go-live. |

### Step 3: Approval

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-15 | A manager or superadmin can approve a file they submitted. The block is Planned and only a Should (SRS FR-AP-07; SAD R-02, rated High). | | The control that sits before billing can be bypassed by one person. | Control | High | BO-02, DOC-02 | Block self-approval. Name an alternate approver for one-person offices. |
| GAP-16 | Managers and superadmins can edit an approved file, and each save re-rates the billing. The SAD says accountants are both "read-only" and "may still edit" (SAD §2.6, §3.3, §7.8). | | A billable change after approval gets no second check. Accountant rights are contradictory. | Control | High | OP-02, AC-16, DOC-01 | An edit to a billable field returns the file to Pending. Accountants are read-only on freight data. |
| GAP-17 | A file is Draft, Pending, For Correction or Approved (SRS FR-AP). | | There is no way to cancel a shipment. A cancelled job stays approved and billable. | Missing | High | OP-03 | Add a Cancelled status (manager only, with a reason). |
| GAP-18 | Managers approve or return pending files (SRS FR-AP-04/05). | | No target time for a decision, and no deputy when the approver is away. | Missing | Medium | OP-12 | Agree a turnaround and a deputy rule. |
| GAP-19 | The Overview shows counts and a to-do list (SRS FR-OV-01). | | Nothing tells an approver a file is waiting, or an operator that a file was returned. | Missing | Medium | OP-16 | The to-do list at minimum. |
| GAP-20 | Files that existed before the approval step are treated as approved (SAD §3.3, §8.4). | | Those files reach billing without anyone approving them. | Control | Medium | OP-18 | Review any that are not yet invoiced. |
| GAP-21 | The documents use "for correction" and "returned", "encoder" and "operator", "reviewer" and "approver" for the same things (SRS Table 2-1; SAD §3.3). | | Mixed words on screens, tests and training. | Undefined | Low | DOC-09 | Use the terms in CONTEXT.md. |

### Step 4: Movement (RORO vehicles, cartage, dispatch)

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-22 | A "dispatcher" owns the movement step, but there are only five roles and none is dispatcher (SAD Table 3-1). | | Unclear whether dispatchers need different permissions from operators. | Contradiction | Low | OP-04, DOC-04 | Map dispatchers to the operator role. |
| GAP-23 | A proof-of-delivery signature is captured only when a signature pad is connected. No connector exists (SRS FR-FD-04). | | Delivery cannot be proven in the system today. | Unbuilt | Medium | OP-10 | Allow a photo of the paper proof as an attachment. |
| GAP-24 | A RORO vehicle has a Hold status, a customs hold flag and a lien release flag (SRS FR-VH-02/03). | | No rule on who sets or clears each, or which one stops shipment. | Undefined | Medium | OP-17 | Define each marker and who may change it. |
| GAP-25 | The vehicle number decode works for US-format numbers only, and its "engine" label shows the engine layout (SRS App. B #6; SAD R-09). | | Non-US vehicles must be typed by hand. | Unbuilt | Low | OP-17 | Confirm it is acceptable when RORO holds are discussed. |
| GAP-26 | Billing runs only on ocean and air files (SAD §7.8). | | Cartage, RORO vehicle shipping and dispatch have no way to be billed. | Missing | High | AC-17 | Decide how each service is charged. |
| GAP-27 | Vehicles, cartage and dispatch are verified by "functional review" only. The rehearsal skipped the RORO inspection dialog and the milestone screens (SRS §8, App. B #12; SAD §12.3). | | These modules have no automated checks and were not all exercised. | Unverified | Medium | TL-07 | QA writes manual test cases. End-to-end scripts join the automated checks. |

### Step 5: Tracking, public lookup and map

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-28 | Staff record every milestone by hand (SRS FR-TR-02). | | No rule on who enters them or how soon. The public lookup is only as current as staff make it. | Missing | Medium | OP-06 | Name who enters milestones and by when. |
| GAP-29 | The public lookup returns "tracking fields only" for a file, booking, waybill, master or house number, with no sign-in (SRS FR-PT-01/02). | | The fields are not listed. File numbers follow a pattern, so anyone who guesses one sees its status. | Undefined | High | BO-07 | List the allowed fields. Exclude party names. |
| GAP-30 | Customer web account records exist with permission flags, but customers cannot sign in (SRS FR-TR-03/04/05; SAD R-12). | | The flags do nothing. | Unbuilt | Low | BO-05 | Defer the portal. Hide the flags until then. |
| GAP-31 | The live map needs internet and a ship feed token; without the token no ships show (SRS App. B #9; SAD R-09). | | The map may be empty at go-live. | Unbuilt | Low | BO-08 | Decide with the other connectors whether the feed is needed. |
| GAP-32 | Live device, government and carrier connectors "are required", with priority Could. None exists (SRS FR-AD-05; SAD R-12). | | The requirement contradicts its own priority. | Contradiction | Low | BO-08, DOC-03 | Could, after go-live. Correct the wording. |

### Step 6: Billing and invoices

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-33 | Each file has one live invoice (SRS FR-BL-04). | | A consolidation with 40 house customers cannot be invoiced per customer. | Missing | High | AC-01 | Accounting lead decides: one invoice, or one per house. |
| GAP-34 | A file has one bill-to party (SRS FR-AP-02). | | Charges split between parties (prepaid and collect, origin and destination, overseas agent) cannot be expressed. | Missing | High | AC-02 | Decide whether split billing is needed. |
| GAP-35 | Amounts keep their currency and the ledger records in PHP. The exchange rate service is called from the browser (SRS C-05; SAD §10.3). | | No rule for which rate applies, when, or who may override it. The rate used for posting is not controlled. | Missing | High | AC-03, TL-08 | Fix the rate at invoice issue from one chosen source, held by the server. |
| GAP-36 | VAT is 12% on taxable lines, and each invoice is 12%, zero-rated or exempt. The rule sits in the freight group, not billing (SRS FR-SH-06). | | No rule for choosing the treatment or who chooses. Withholding tax is not mentioned. | Undefined | High | AC-04, DOC-10 | Accounting lead states the rules. |
| GAP-37 | Invoice numbers are fixed at issue and never reused. A void drafts a new revision (SRS FR-BL-04/05/06, DR-04). | | Nobody has checked the numbering and voiding against the tax authority's rules for official invoices. | Unverified | High | AC-05 | Confirm the rules and add them as requirements. |
| GAP-38 | No credit note. An invoice with a zero or negative total is refused; the correction is void and re-issue (SRS FR-BL-09, App. B #1; SAD R-04). | | A **Must** requirement is not built. | Unbuilt | High | AC-06 | Decide whether void and re-issue is acceptable at go-live. |
| GAP-39 | A re-rate after issue "marks the invoice for re-issue" (SAD §7.8). | | Nobody is told, and the customer may hold an invoice that no longer matches the file. | Undefined | Medium | AC-20 | Define who re-issues and when. |
| GAP-40 | The Overview sums monthly income by estimated or actual dates. The ledger counts income by posting date (SRS FR-OV-01, App. B #5). | | Two different "income" figures. | Contradiction | Medium | AC-11 | The ledger is official. Label the Overview figure "estimated". |
| GAP-41 | Acceptance for the billing rules is "check:billing passes" and similar (SRS §4). | | An owner cannot confirm a rule from an engineering check name. | Unverified | Medium | TL-10, DOC-11 | Worked examples with numbers for each rule. |
| GAP-42 | Invoice references use a daily sequence, invoice numbers a monthly one, and periods close by month (SRS FR-BL-04/05, FR-FS-04). | | No time zone is stated. An entry near midnight could land in the wrong day or month. | Undefined | Medium | TL-09 | Asia/Manila for all business dates. |

### Step 7: Accounting bridge

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-43 | The company chooses manual, review (default) or auto posting. Auto posts with no person checking (SRS FR-BL-08). | | No decision on the mode at go-live or on who may change it. | Control | Medium | AC-13 | Review mode. Only a superadmin changes it, with the Accounting lead's approval. |
| GAP-44 | Auto mode posts only when "no rate note is open" (SRS FR-BL-08). | | "Rate note" is not defined anywhere. | Undefined | Medium | AC-14 | Engineering defines it. Accounting lead confirms. |
| GAP-45 | Managers approve files and have "all ledger functions". The bridge requirements name no roles (SRS Table 2-1, FR-BR-04/05; SAD §2.6). | | One person could approve, bill and post the same file. | Control | High | AC-15 | Only accountants post. Managers approve but do not post. |
| GAP-46 | All charges post to one sales account (SRS FR-BL-10, App. B #2; SAD R-05). | | Revenue cannot be reported by service. | Unbuilt | Medium | AC-07 | Accounting lead provides the mapping from charge code to revenue account. |
| GAP-47 | The bridge has a "miscellaneous invoice" item type and tab (SAD §7.9). | | No requirement covers it. It is a route to the ledger that does not start from an approved file. | Missing | Medium | AC-19 | Define its use and who may raise one. |
| GAP-48 | A check disbursement register exists. "CDV" is a check disbursement voucher in one place and a cash disbursement voucher in another (SRS FR-BR-06, FR-FS-02, Table 1-1). | | Unclear what payments are recorded, and where payments that are not by check go. | Undefined | Medium | AC-22, DOC-09 | Define the term and the payment types covered. |

### Step 8: Ledger and month-end

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-49 | The system cannot reopen a closed month. Reopening is "an owner decision made outside the system" (SRS §7.1). | | A change made outside the system leaves no audit record. | Control | High | AC-12 | A written procedure with approval and a backup, or an audited reopen function. |
| GAP-50 | Month-end close creates closing entries and closes the period (SRS FR-FS-06). | | No fiscal year and no year-end close are stated. | Missing | Medium | AC-21 | State the fiscal year and any year-end steps. |
| GAP-51 | Every record carries a company code so several companies can be supported, but only this deployment's company has a ledger (SRS FR-FS-09; SAD D-02). | | A second company's invoices would have nowhere to post. | Contradiction | Medium | BO-03, DOC-05 | Confirm a single company for go-live. |
| GAP-52 | Viewers have "read access to modules". Ledger pages need a separate ledger access check (SRS Table 2-1; SAD §11.2). | | Unclear whether an auditor with the viewer role can read the ledger. | Undefined | Low | DOC-13 | State the viewer's ledger access. |

### After step 8: what happens once the invoice is posted

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-53 | A "receipt" voucher number is fixed per invoice (SRS FR-BR-07). Nothing else is said about payments received. | | No customer payments, receipts, aging or statements of account. | Missing | High | AC-08 | Decide whether collections are in scope for go-live. |
| GAP-54 | Cost lines are estimates from tariffs (SRS FR-BL-01; SAD §7.8). | | Actual supplier bills are not recorded or matched, so payables may never agree with what suppliers bill. | Missing | High | AC-09 | Decide how supplier bills are recorded and matched. |
| GAP-55 | Sell and cost lines exist on every file. | | No profit report by file, customer or lane. | Missing | Medium | AC-10 | Add it as a Should requirement. |

---

## 4. Cross-cutting gaps

### Release readiness, recoverability and performance

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-56 | "Must = required for release." Four Must items are not fully built: credit note, penetration test, backup and restore, paging on every list (SRS §1, App. A). | | By its own rule the system cannot be released, and no go-live date or gate is stated. | Contradiction | High | BO-01, DOC-06 | Blockers until the Business owner downgrades them in writing. |
| GAP-57 | A health check exists. No routine backup and restore procedure exists for either database. Recovery depends on file copies (SRS NFR-AV-01; SAD §6.5, R-01, rated High). | | A lost or damaged file could lose all freight or ledger data. | Unbuilt | High | TL-01 | Daily backup at minimum. A restore tested before go-live. Agree how much data may be lost and how long a restore may take. |
| GAP-58 | Performance targets were met on a demo copy. The databases allow limited concurrent writing (SRS NFR-PF-03; SAD §12.2, R-01). | | No business volumes are stated, so nobody knows whether the system will cope. | Unverified | High | BO-10, TL-02, DOC-12 | Business owner gives volumes. Technical lead shares load test results against them. |
| GAP-59 | A penetration test and dependency audit are required before go-live and are not scheduled (SRS NFR-SE-07). | | A **Must** requirement is not built. | Unbuilt | High | TL-03 | Book it before go-live. |
| GAP-60 | Every list must be paged; some are not (SRS NFR-PF-02). | | A **Must** requirement is partly built, and the unpaged lists are not named. | Unbuilt | Medium | TL-06 | Engineering lists the endpoints. |
| GAP-61 | Encryption of the database files depends on the host and is "planned for review" (SAD §11.4). | | Ledger and customer data may be stored unencrypted. | Unverified | Medium | TL-04 | Confirm the host's setting. |

### Roles, access and organisation

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-62 | No password reset and no self-registration exist. Help requests become support tickets (SAD §11.1; SRS FR-AD-04). | | A user who forgets a password is locked out until an administrator acts. No requirement says so. | Missing | Medium | BO-06 | Accept for go-live and write it as a requirement. |
| GAP-63 | A password policy, a password history and an idle time-out exist (SRS FR-AU-06/07/08). | | The values are not stated, except a 72-byte maximum. | Undefined | Low | TL-11 | State the values. Business owner confirms. |
| GAP-64 | Branches appear on the map and in "single-person offices" (SRS FR-MP-01; SAD R-02). | | Branches do not exist in roles or data, so nothing can be limited to a branch. | Missing | Medium | BO-04 | Decide whether users, files or approvals are limited by branch. |
| GAP-65 | Managers have "no user administration", yet "a manager shall not manage superadmin accounts" (SRS Table 2-1, FR-AU-12). | | Unclear whether managers can manage other users. | Contradiction | Medium | DOC-14 | State which user changes a manager may make. |
| GAP-66 | An "authorised user" manages users and companies. "Authorised roles" read the audit trail. Deletion is "limited to roles allowed by the route" (SRS FR-AD-01/02/03, DR-05). | | The roles are not named, so the rules cannot be tested or confirmed. | Undefined | Medium | BO-14 | Name the roles in each requirement. |

### Records, terms and documents

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-67 | Records are "the company's records", retrieved by file number, invoice number and journal reference (SRS §7.2). | | No retention period and no rule on archiving or deleting. | Missing | Medium | BO-11 | Confirm the legal retention period with Accounting. |
| GAP-68 | Attachments up to 15 MB are stored inside the database. A separate file store is Planned (SRS FR-AD-04, DR-06). | | Accepted file types and scanning are not stated. The database grows with every attachment. | Undefined | Low | TL-12 | State the accepted types. |
| GAP-69 | "File", "shipment" and "booking" are used for the same record. "Vehicle" means three things (SRS §4.4, §4.7, §4.9). | | Staff, screens and tests may each use different words. | Undefined | Medium | OP-01 | Use the terms in CONTEXT.md once the Operations lead confirms them. |
| GAP-70 | Both documents have two revisions numbered 0.1. The SAD has no Operations lead in its approval table. SAD §15 leaves out three Planned requirements (Document Control; SAD §15). | | The documents cannot be signed cleanly as they stand. | Contradiction | Low | DOC-08, DOC-15, DOC-17 | Fix in v0.2. |

---

## 5. Gaps with no owner

These cannot be closed until someone is named to decide them.

| GAP ID | What the documents say the system does | How the business does it today | Gap | Type | Severity | Question | Proposed resolution |
|---|---|---|---|---|---|---|---|
| GAP-71 | The traceability matrix assigns each requirement group to an owner (SRS §8). | | The usability requirements, constraints C-01 to C-05 and assumptions A-01 to A-04 are not in the matrix, so nobody confirms them. | Missing | Medium | DOC-18 | Assign each an owner. |
| GAP-72 | Screens must work at phone width, and every list must show loading, empty and error states. Both are Partial (SRS NFR-US-01, IFR-02). | | The screens that fail are not named, and no owner confirms usability. | Unbuilt | Low | DOC-18 | Engineering lists the screens. The owner from GAP-71 accepts or rejects. |

### Gaps that need two owners

| Gaps | Decides | Must be consulted | Why |
|---|---|---|---|
| GAP-12, GAP-33 | Accounting lead | Operations lead | How a consolidation is invoiced decides what the documents show. |
| GAP-15 | Business owner | Operations lead | The rule must work in a one-person office. |
| GAP-16 | Operations lead (re-approval); Accounting lead (accountant rights) | Each other | One edit rule affects both approval and billing. |
| GAP-26 | Accounting lead | Operations lead | Operations knows which services are sold; Accounting knows how they are charged. |
| GAP-45 | Business owner | Accounting lead | Segregation of duties is a business control. |
| GAP-02 | Business owner | Accounting lead, Operations lead | Someone must be named to enter tariffs. |
| GAP-67 | Business owner | Accounting lead | The legal retention period comes from tax rules. |

---

## 6. Where each source item went

| Source | Items | Covered by |
|---|---|---|
| Known limitations (SRS App. B) | 1 to 12 | GAP-38, GAP-46, GAP-03, GAP-02, GAP-40, GAP-25, GAP-11, GAP-12, GAP-31, GAP-14, GAP-10, GAP-27 |
| Risks (SAD §13) | R-01 to R-13 | R-01 GAP-57 · R-02 GAP-15 · R-03 GAP-02 · R-04 GAP-38 · R-05 GAP-46 · R-06 GAP-03 · R-07 GAP-12 · R-08 GAP-11 · R-09 GAP-25, GAP-31 · R-10 GAP-14 · R-11 GAP-10 · R-12 GAP-30, GAP-32 · R-13 GAP-06 |
| Open questions, groups B to F | 84 | Every question appears in the Question column of at least one gap above. |
