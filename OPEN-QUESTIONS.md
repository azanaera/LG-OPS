# Open Questions Log: the Platform (SRS v0.1 / SAD v0.1)

**Purpose:** a single list of every question raised while reviewing the SRS and SAD, so that each one gets an owner, an answer and a decision on record. Answers here feed SRS/SAD v0.2.

**Owner of this log:** QA (requirements confirmation)
**Started:** 8 November 2026
**Sources:** `Document_SRS_v0.1_REDACTED.pdf`, `Document_SAD_v0.1_REDACTED.pdf`

## How to use this log

| Field | Meaning |
|---|---|
| **ID** | `Q` = interview with QA lead, `BO` = Business owner, `AC` = Accounting lead, `OP` = Operations lead, `TL` = Technical lead, `DOC` = document fix for Engineering |
| **Ref** | Where the question comes from (SRS / SAD section or requirement ID) |
| **Proposed** | The recommended answer, offered to speed up the decision. It is **not** agreed until the owner confirms it |
| **Status** | `Open` → `Answered` → `Closed` (written into v0.2). Or `Deferred` (owner accepted it for a later release, with a reason) |
| **Answer / decision** | Who decided, when, and what. Link to meeting notes if there are any |

When a question is answered, also update the affected requirement. If the answer settles a business term, update [CONTEXT.md](CONTEXT.md) at once: remove the ⚑ flag and adjust the definition.

---

## Summary

| Group | Count | Open |
|---|---|---|
| A. Interview with QA lead (Round 1) | 9 | 9 |
| B. Business owner | 11 | 11 |
| C. Accounting lead | 18 | 18 |
| D. Operations lead | 12 | 12 |
| E. Technical lead | 10 | 10 |
| F. Document fixes for Engineering | 14 | 14 |
| **Total** | **74** | **74** |

---

## A. Interview with QA lead (Round 1)

These set up how the confirmation work is run. Q5 to Q8 are business questions. If the answer is "ask stakeholder", they move to the linked stakeholder question.

| ID | Question | Proposed | Links | Status | Answer / decision |
|---|---|---|---|---|---|
| Q1 | **Mandate.** Does "refine and confirm" mean (a) get the four owners to sign v0.1 as written, (b) produce a v0.2 that reflects decisions the business actually made, or (c) prepare for user acceptance testing? Who are the named people for Business owner, Accounting lead, Operations lead and Technical lead? | (b). Run one confirmation session per owner area, record decisions in this log, and have Engineering issue v0.2 from it. Signing v0.1 as written would lock in the gaps. | - | Open | |
| Q2 | **Is the platform live?** The SAD mentions a "live site" that deploys automatically from main, and a stopped earlier production instance. Are staff already using it with real shipments? | (fact to confirm) This decides whether the work is pre-go-live confirmation or a gap review after the fact. | BO-09 | Open | |
| Q3 | **Release gate.** Is there a go-live date? For the Must items that are not built, are they blockers, or will the owner downgrade them in writing? | Treat them as blockers until an owner signs a downgrade. Backup and restore is a blocker regardless, because R-01 is rated High. | BO-01 | Open | |
| Q4 | **Summary document audience and format.** Is it for stakeholders, the delivery team, or both? Where should it live (Claude doc, Word, Confluence, other)? | Both. A short stakeholder brief on top of a team reference. Store it wherever the team already reviews documents. | - | Open | |
| Q5 | **Name of the core record.** Users and documents say "file", "shipment" and "booking". Which word do users actually say? Is "booking number" the carrier's reference or the company's? | Use **Freight File** as the canonical term. Use "booking number" only for the carrier's booking reference. | OP-01 | Open | |
| Q6 | **Billing a consolidation.** For a MAWB with 40 HAWBs, is there one invoice to a single party (agent or consolidator), or one invoice per HAWB? | Ask the Accounting lead. If billing is per house, "one live invoice per file" is wrong for consolidations. | AC-01 | Open | |
| Q7 | **Edits after approval.** Should an edit to an approved file send it back for approval? Can accountants edit freight data at all? | An edit to any billable field after approval sends the file back to pending. Accountants stay read-only on freight data. | OP-02, AC-16, DOC-01 | Open | |
| Q8 | **Exchange rate and VAT on foreign-currency invoices.** Who sets the exchange rate, and when (booking, invoice issue or posting)? Is 12% VAT applied to international freight, or is it zero-rated? | Ask the Accounting lead. Proposed: fix the rate at invoice issue from a source the company chooses, and store it on the invoice. | AC-03, AC-04 | Open | |
| Q9 | **How the team works.** Where do requirements and tests live today (Jira, Azure DevOps, Excel, none)? What meetings already exist (standups, sprint reviews)? | Put requirement IDs into the tracker, link test cases to them, and run a 30-minute walkthrough per module. | - | Open | |

---

## B. Business owner

| ID | Question | Why it matters | Ref | Proposed | Status | Answer / decision |
|---|---|---|---|---|---|---|
| BO-01 | Four **Must** requirements are not fully built: credit note (FR-BL-09), penetration test (NFR-SE-07), backup and restore (NFR-AV-01), and paging on every list (NFR-PF-02). The SRS says Must means "required for release". Are these go-live blockers, or will you downgrade some in writing? | By the document's own rule, it cannot be released today. | SRS §1, App. A | Blockers until downgraded with a signature. | Open | |
| BO-02 | **Self-approval.** May a manager or superadmin approve a file they submitted themselves? If not, which rule applies: block self-approval, or require a second approver? What about an office with only one approver? | Rated a **High** risk (R-02), but only a Should requirement (FR-AP-07). This is a key control before billing. | SRS FR-AP-07; SAD §3.3, R-02 | Block self-approval. For one-person offices, allow approval by a named alternate (for example a manager from another office or a superadmin), with an audit record. | Open | |
| BO-03 | **More than one company.** Will more than one company use the platform? If yes, how are the other companies' invoices accounted for, given that only this deployment's company has a ledger? | The design supports several companies (D-02), but the ledger serves one company only (FR-FS-09). Billing for any other company has nowhere to post. | SRS FR-FS-09; SAD D-02, §7.10 | Confirm a single company for go-live. If more are planned, record it as a future requirement. | Open | |
| BO-04 | **Branches.** Does the company run several branches or offices? Should users, files or approvals be limited to a branch? | The map shows branches and R-02 mentions "single-person offices", but branches do not exist in roles or data. | SRS FR-MP-01, App. A; SAD R-02 | (decision needed) | Open | |
| BO-05 | **Customer portal.** Do customers need to sign in (FR-TR-04/05) at go-live, or is the public lookup enough for now? | Planned, not started. Customer web account records already exist with permission flags that do nothing yet. | SRS FR-TR-03/04/05 | Defer to a later phase. Hide the web account permission flags until then. | Open | |
| BO-06 | **Password reset.** There is no self-service password reset or registration. Is it acceptable for users to raise a support ticket and have an admin reset the password? | No requirement covers it either way. Users who forget their password are locked out until an admin acts. | SAD §11.1; SRS FR-AD-04 | Accept for go-live and record it as an explicit requirement. | Open | |
| BO-07 | **What the public lookup shows.** Exactly which fields can a public visitor see (status, milestones, ports, shipper or consignee names)? File numbers follow a pattern. Is it acceptable that anyone who guesses one sees its status? | "Tracking fields only" is not defined. Customer privacy and competitor visibility are both at stake. | SRS FR-PT-01/02 | List the allowed fields explicitly. Exclude party names. | Open | |
| BO-08 | **Live connectors.** Are the barcode scanner, signature pad, label printer, government filing and carrier API connectors needed for go-live? | FR-AD-05 says they "are required", but its priority is Could. | SRS FR-AD-05, IFR-07 | Could, after go-live. Correct the wording. | Open | |
| BO-09 | **Owner decisions in SAD §13.** (a) When will the legacy ledger cleanup run on production (R-06)? (b) Will the stopped earlier production instance be removed? | Both are listed as owner decisions and have no date. | SAD §2.3, §13 | (a) Before go-live, after the dry run and a verified backup. (b) Remove it after its data is archived. | Open | |
| BO-10 | **Business volumes.** How many files a month, how many users at the same time, and how much growth is expected in the next 2 years? | SQLite limits concurrent writers (R-01, High). Performance was only measured on a demo copy. | SAD R-01, §12.2; SRS NFR-PF-03 | (fact needed) | Open | |
| BO-11 | **Record retention.** How long must freight and accounting records be kept? May they ever be deleted or archived? | No retention requirement exists. Legal and tax record-keeping periods apply. | SRS §7.2, DR-05 | Confirm the legal retention period with Accounting. | Open | |

---

## C. Accounting lead

| ID | Question | Why it matters | Ref | Proposed | Status | Answer / decision |
|---|---|---|---|---|---|---|
| AC-01 | **Consolidation billing.** Is a MAWB billed as one invoice, or is each HAWB invoiced to its own shipper or consignee? | "One live invoice per file" cannot invoice 40 house customers. Known gap 8 (house number repeats the MAWB number) is a symptom. | SRS FR-BL-04, App. B #8; SAD §7.3, R-07 | (decision needed) | Open | |
| AC-02 | **Several bill-to parties.** Can one file have charges billed to different parties (prepaid vs collect, origin vs destination charges, overseas agent)? | One invoice per file and one bill-to field cannot express this. | SRS FR-AP-02, FR-BL-04 | (decision needed) | Open | |
| AC-03 | **Exchange rate.** The ledger records in PHP, but invoices can be in USD or other currencies. Which rate source applies, at which moment (booking, issue, posting), and who can override it? How are exchange gains and losses handled when the customer pays? | There is no rule at all. The exchange rate service is called from the browser, so the rate used for posting is not controlled. | SRS C-05; SAD §7.7, §10.3 | Fix the rate at invoice issue from one source the company chooses, store it on the invoice, and let only an accountant override it. | Open | |
| AC-04 | **VAT and other taxes.** When is an invoice 12% VAT, zero-rated or exempt, and who chooses? Is withholding tax in scope? | Only the 12% rate is specified. The rules for choosing a treatment are missing. | SRS FR-SH-06, §7.1 | (decision needed) | Open | |
| AC-05 | **Official invoice compliance.** Is the system's invoice the official tax invoice? What do the tax authorities require for invoice number series, voided numbers and the printed format? | Void and re-issue creates new revisions. Gaps or reused numbers may not be acceptable. | SRS FR-BL-04/05/06, DR-04 | Confirm the BIR requirements and add them as requirements. | Open | |
| AC-06 | **Credit note.** Is void-and-re-issue acceptable until a credit note exists? What should the credit note look like and when is it needed? | Must but Planned (known gap 1). Zero or negative invoices are refused today. | SRS FR-BL-09; SAD R-04 | (decision needed) | Open | |
| AC-07 | **Revenue split by service.** Which revenue accounts should freight, handling, documentation and other charges post to? | All charges post to one sales account today (known gap 2). The design waits for this decision. | SRS FR-BL-10; SAD R-05 | Provide the mapping from charge code to revenue account. | Open | |
| AC-08 | **After the invoice: receivables.** Are customer payments, receipts, AR aging and statements of account in scope? | A "receipt" voucher number is mentioned, but there are no requirements for collections. | SRS FR-BR-07 | (decision needed) | Open | |
| AC-09 | **Supplier costs.** Cost lines are estimates from tariffs. How are actual supplier bills recorded and matched? How is the difference handled? | Without matching, AP in the ledger may never agree with what suppliers bill. | SRS FR-BL-01; SAD §7.8 | (decision needed) | Open | |
| AC-10 | **Profit per file.** Do you need a sell vs buy (profit) report per file, customer or lane? | It is a core management report for forwarders, and it is not specified. | - | Add it as a Should requirement. | Open | |
| AC-11 | **Which income is official?** The Overview counts monthly income by estimated or actual dates, and the ledger counts it by posting date. Which figure does management use? | Two different "income" numbers will confuse readers and cause disputes. | SRS FR-OV-01, App. B #5; SAD §7.1 | The ledger is official. Relabel the Overview figure as "estimated". | Open | |
| AC-12 | **Reopening a closed month.** "Reopening is an owner decision made outside the system." How is it actually done, who authorises it, and how is it recorded? | A change made outside the system bypasses the audit trail. | SRS §7.1, FR-FS-04 | Define a written procedure with approval and a backup. Or add an audited reopen function. | Open | |
| AC-13 | **Billing-to-ledger mode.** Which mode at go-live: manual, review (the default) or auto? Who may change it? | Auto mode posts without a person checking. | SRS FR-BL-08, FR-AD-02 | Review mode. Only a superadmin can change it, with approval from the Accounting lead. | Open | |
| AC-14 | **"Rate note".** Auto mode posts only when "no rate note is open". What is a rate note? Who opens and closes one? | The term is not defined anywhere. | SRS FR-BL-08; SAD §7.8 | (definition needed) | Open | |
| AC-15 | **Segregation of duties.** Managers approve files and also have "all ledger functions". Superadmins can do everything. Which roles may trial-post and post bridge items? | FR-BR does not name roles. One person could approve, bill and post the same file. | SRS Table 2-1, FR-BR-04/05; SAD §2.6 | Only accountants post. Managers approve but do not post. | Open | |
| AC-16 | **Accountant rights on freight files.** Can accountants edit approved files, or are they read-only? | The SAD says both (see DOC-01). | SAD §2.6 vs §3.3 | Read-only. | Open | |
| AC-17 | **Billing for cartage, vehicles and dispatch.** How are trucking, RORO vehicle shipping and dispatch charged to customers? | Billing runs only on air and ocean files, so these services have no way to be billed. | SAD §7.8; SRS FR-BL-01 | (decision needed, with the Operations lead) | Open | |
| AC-18 | **Tariff data entry.** Who enters tariffs and charge packages, and by when? Only one lane has a known rate today. | Automatic billing depends on tariffs (R-03, High). | SRS A-01, App. B #4; SAD §14.1, R-03 | A named owner and a target date before go-live. | Open | |

---

## D. Operations lead

| ID | Question | Why it matters | Ref | Proposed | Status | Answer / decision |
|---|---|---|---|---|---|---|
| OP-01 | **Terminology.** Confirm the names staff use: file, shipment or booking? "Vehicle" means three things: the customer's car on RORO, a company truck, and the vehicle on a dispatch route. | Mixed terms cause wrong tests and wrong training. | SRS §4.4, §4.7, §4.9 | **Freight File**; **RORO Vehicle** (cargo); **Fleet Vehicle** (company truck). | Open | |
| OP-02 | **Edits after approval.** If a manager changes an approved file (for example its weight or charges), should it go back for approval? | Editing re-rates the billing with no second check. | SAD §3.3, §7.8 | Yes, for billable fields. | Open | |
| OP-03 | **Cancelling a shipment.** How is a booking cancelled? A file only has draft, pending, for correction and approved. | A cancelled shipment stays "approved" and billable. | SRS FR-AP; SAD glossary "Operation status" | Add a Cancelled status (manager only, with a reason). | Open | |
| OP-04 | **Dispatcher.** The SAD names a "dispatcher" as a process owner. Is that a separate job? Does it need its own role? | No dispatcher role exists among the 5 roles. | SAD Table 3-1 | Map dispatchers to the operator role, unless their permissions differ. | Open | |
| OP-05 | **Shared desk.** Confirm that operators may edit each other's draft files. | Accepted by the business (known gap 7). It needs a named person who accepted it. | SRS App. B #7; SAD R-08 | Confirm, and record who accepted it. | Open | |
| OP-06 | **Milestones.** Who enters tracking milestones, and how soon after an event? Are automatic carrier updates needed? | All milestones are entered by hand. Public lookup data is only as current as staff make it. | SRS FR-TR-02 | (decision needed) | Open | |
| OP-07 | **Legal documents.** Does the company issue its own house bills of lading or house air waybills as a carrier or consolidator? Which printed documents must follow a legally required format? | The documents are printed from the browser with branded layouts, and nobody has checked them legally. | SRS FR-SH-09; SAD §7.2 | (fact needed) | Open | |
| OP-08 | **File numbers for imports and integrations.** Will files ever be created by import or API, not by the form? | Those files get a generic number (known gap 11). | SRS App. B #11; SAD R-11 | If yes, add prefix rules before go-live. | Open | |
| OP-09 | **Arrival notice email.** Must arrival notices be emailed at go-live? | It is preview only until SMTP is configured (known gap 10). | SRS App. B #10; SAD R-10 | (decision needed) | Open | |
| OP-10 | **Proof of delivery.** Signature pads are not connected, so POD capture is disabled. Is a paper POD, or an uploaded photo of one, acceptable for now? | The POD requirement is only partly met (FR-FD-04). | SRS FR-FD-04 | Allow a photo attachment in the meantime. | Open | |
| OP-11 | **House number on a consolidation invoice.** What should the invoice show as the house number for a consolidation? | It repeats the MAWB number today (known gap 8). It depends on AC-01. | SRS App. B #8; SAD R-07 | Follows AC-01. | Open | |
| OP-12 | **Approval turnaround.** How quickly must files be approved or returned? Who covers when the approver is away? | No service level and no deputy rule. Billing waits on approval. | SRS FR-AP-04/05 | (decision needed) | Open | |

---

## E. Technical lead

| ID | Question | Why it matters | Ref | Proposed | Status | Answer / decision |
|---|---|---|---|---|---|---|
| TL-01 | **Backup and restore.** When will a backup and restore procedure exist for both database files? How much data may be lost, and how long may a restore take? | Must but Partial. Single-file databases are risk R-01 (High). | SRS NFR-AV-01; SAD §6.5, R-01 | Daily backup at minimum, with a restore tested before go-live. | Open | |
| TL-02 | **Concurrency.** With BO-10 volumes, will SQLite cope? What did the load tests show? | Risk R-01 (High). | SAD §12.2, §14.2 | Share the load test notes. | Open | |
| TL-03 | **Penetration test and dependency audit.** When are they scheduled, and who does them? | Must but Planned. | SRS NFR-SE-07 | Booked before go-live. | Open | |
| TL-04 | **Encryption at rest.** Are the database files encrypted on the host? | "Planned for review." The ledger and customer data are sensitive. | SAD §11.4 | Confirm the host's encryption setting. | Open | |
| TL-05 | **Credential rotation.** Who rotates the development credentials and feed tokens, and when? | Owner action before go-live (R-13, A-04). | SRS A-04; SAD R-13 | A named person and a date, signed off. | Open | |
| TL-06 | **Paging.** Which list endpoints still return everything without paging? | Must but Partial. | SRS NFR-PF-02 | Provide the list of endpoints. | Open | |
| TL-07 | **Test coverage.** Will the end-to-end scripts run in CI? Who covers the areas the rehearsal skipped (milestone screens, RORO inspection dialog, keyboard focus order, forced server errors)? | Vehicles, cartage and dispatch have no automated checks. | SAD §12.3; SRS App. B #12, §8 | QA writes manual test cases for these, and the end-to-end scripts are added to CI. | Open | |
| TL-08 | **Exchange rate in the browser.** Is the browser-fetched exchange rate ever used for invoice or ledger amounts? | Linked to AC-03. Money rules should not depend on the browser. | SAD §10.3, §11.3 | Fetch and store the rate on the server. | Open | |
| TL-09 | **Time zone.** Which time zone is used for dates, the daily and monthly invoice sequences, and period close? | It is not specified. Entries near midnight could land in the wrong day or month. | SRS FR-BL-04/05, FR-FS-04 | Asia/Manila for all business dates. | Open | |
| TL-10 | **Acceptance criteria stakeholders can read.** Can Engineering turn the main checks (check:billing, check:invoice, check:bridge, check:air-booking) into worked examples that stakeholders can confirm? | "check:billing passes" means nothing to an Accounting lead. | SRS §4 (acceptance column) | Provide 3 to 5 worked examples for each rule. | Open | |

---

## F. Document fixes for Engineering (SRS/SAD v0.2)

| ID | Issue | Ref | Proposed fix | Status |
|---|---|---|---|---|
| DOC-01 | Accountants are "read-only on freight records" in one place, and "may still edit" approved files in another. | SAD §2.6 vs §3.3 | Resolve with AC-16 and update both sections. | Open |
| DOC-02 | Self-approval is rated a High risk (R-02), but FR-AP-07 is only a Should. | SRS FR-AP-07; SAD R-02 | Align the priority after BO-02. | Open |
| DOC-03 | FR-AD-05 says live connectors "are required", but its priority is Could. | SRS FR-AD-05 | Reword it after BO-08. | Open |
| DOC-04 | A "dispatcher" is named as a process owner but is not a role. | SAD Table 3-1 | Resolve with OP-04. | Open |
| DOC-05 | The multi-company design (D-02) conflicts with a ledger for a single company (FR-FS-09). | SRS FR-FS-09; SAD D-02 | Resolve with BO-03. | Open |
| DOC-06 | "Must = required for release", yet four Must items are not built. | SRS §1, App. A | Add a release-readiness statement after BO-01. | Open |
| DOC-07 | The SAD lists a house bill of lading among the printed documents. FR-SH-09 does not. | SAD §7.2; SRS FR-SH-09 | Add it to FR-SH-09 or remove it from the SAD. | Open |
| DOC-08 | The revision history has two entries numbered "0.1". | SRS & SAD Document Control | Issue the next revision as v0.2. | Open |
| DOC-09 | Terms are used but never defined: "rate note", "billing review", "encoder", "for correction" vs "returned", "live invoice". | SRS FR-BL-08, Table 2-1; SAD §3.3 | Add them to the SAD glossary. | Open |
| DOC-10 | The VAT requirement (FR-SH-06) sits in the Freight Files group, not in Billing. | SRS §4.4 | Move it to FR-BL. | Open |
| DOC-11 | Acceptance criteria are engineering checks that stakeholders cannot verify. | SRS §4 | Add business examples after TL-10. | Open |
| DOC-12 | NFR-PF-03 is marked Built, but it was measured on a demo copy, not at production volume. | SRS NFR-PF-03; SAD §12.2 | Re-state the target against BO-10 volumes. | Open |
| DOC-13 | Viewers have "read access to modules". It is unclear whether this includes the ledger, since ledger routes need a separate ledger access check. | SRS Table 2-1; SAD §11.2 | State the viewer's ledger access explicitly. | Open |
| DOC-14 | Managers have "no user administration" (Table 2-1), yet FR-AU-12 says "a manager shall not manage superadmin accounts", which implies managers manage other users. | SRS Table 2-1 vs FR-AU-12 | Clarify which user changes a manager may make. | Open |
