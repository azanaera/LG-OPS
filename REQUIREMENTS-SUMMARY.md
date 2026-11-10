# Requirements Summary: the Platform

**A plain-language guide to SRS v0.1 and SAD v0.1 (rev. 2), both dated 8 November 2026**

**Prepared by:** QA (requirements confirmation) · **Companions:** [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) · [CONTEXT.md](CONTEXT.md) (shared terminology)

> **Read this first.** Engineering wrote both source documents from the code (they are "revised to the origin/main state"). They describe **what the system does today**, not what the business has agreed it needs. No owner has signed either one. Treat every statement below as *"the system currently does this"* until the owner in Section 10 confirms it.

---

## 1. At a glance

| | |
|---|---|
| **What it is** | The internal operations and accounting web app of a freight forwarder. It follows a shipment from quote to booking, approval, movement, billing, accounting bridge and general ledger. |
| **Who uses it** | Encoders (operators), managers, accountants, read-only staff and auditors, and the public (tracking lookup only). |
| **Core idea** | One **file number** links everything. **Approval** comes before billing. The **bridge** is the only way into the ledger. |
| **Requirements** | About 125 in total: 91 functional, 18 non-functional, 10 interface, 6 data. |
| **Build status** | 110 Built · 8 Partial · 7 Planned |
| **Release blockers (by the SRS's own rule)** | 4 **Must** items not fully built: credit note, penetration test, backup and restore, paging on every list. |
| **Tech in one line** | React web client and Node/Express API. Two SQLite databases (application + accounting) on Azure App Service. Deploys from the `main` branch. |

### Priority and status labels used in the SRS

| Priority | Meaning | | Status | Meaning |
|---|---|---|---|---|
| **Must** | Required for release | | **Built** | In the code today |
| **Should** | Required unless the owner accepts an alternative | | **Partial** | Part built; the missing part is named |
| **Could** | Desirable | | **Planned** | Not built (SRS Appendix A) |

---

## 2. Scope

| In scope | Out of scope |
|---|---|
| Ocean and air freight files (export, import, domestic) | Payroll |
| Air consolidation: one master air waybill (MAWB) with many house air waybills (HAWBs) | Customer relationship management (CRM) |
| Approval of freight files | Bank file transfers (checks are printed by staff) |
| RORO vehicle inventory; pickup and delivery cartage; fleet, drivers, dispatch, proof of delivery | Direct filing to government systems (*Planned*, status records only) |
| Rates, tariffs, charge packages, quotes, commodities | Warehouse management beyond cargo location fields |
| Billing lines, invoices, accounting bridge, general ledger | Customer portal sign-in (*Planned*) |
| Tracking milestones, public lookup, live map | |
| Users, companies, audit, attachments, support tickets, demo data | |

---

## 3. Who does what

### User roles

| Role | Who | In short |
|---|---|---|
| **superadmin** | Technical administrator | Everything. The only role that can change another superadmin. |
| **manager** | Branch or department manager | Logistics and ledger functions. **Approves and returns** files. |
| **operator** | Encoders: freight, cartage and dispatch staff | Creates, edits and submits draft or returned files. No approval. **No ledger access.** |
| **accountant** | Accounting staff | Billing review, bridge, ledger. **Sees approved files only.** |
| **viewer** | Read-only staff, auditors | Reads. Every write is refused by the server. |
| **Public visitor** | Anyone with a reference number | Public tracking lookup only. No account. |
| *Customer web account* | *Customer* | *Records exist; sign-in is Planned.* |

### Permission matrix (as documented)

`✔` allowed · `✖` refused · `R` read only · `?` unclear or contradictory (see the linked question)

| Action | superadmin | manager | operator | accountant | viewer |
|---|:-:|:-:|:-:|:-:|:-:|
| Create or edit a **draft / for correction** file | ✔ | ✔ | ✔ | ✖ | ✖ |
| Submit a file for approval | ✔ | ✔ | ✔ | ✖ | ✖ |
| Edit a **pending** file | ✖ | ✖ | ✖ | ✖ | ✖ |
| Approve or return a file | ✔ | ✔ | ✖ | ✖ | ✖ |
| Approve a file **they submitted** | ✔ ⚠ | ✔ ⚠ | n/a | n/a | n/a |
| Edit an **approved** file | ✔ | ✔ | ✖ | ? (AC-16) | ✖ |
| See files that are not yet approved | ✔ | ✔ | ✔ | ✖ | R |
| Billing, bridge, trial post, post | ✔ | ? (AC-15) | ✖ | ✔ | R? |
| Ledger (vouchers, journals, month-end) | ✔ | ✔ | ✖ | ✔ | ? (DOC-13) |
| Manage users | ✔ | ? (DOC-14) | ✖ | ✖ | ✖ |
| Change a superadmin account | ✔ | ✖ | ✖ | ✖ | ✖ |

⚠ Self-approval is **not blocked** today (risk R-02, rated High). See BO-02.

---

## 4. End-to-end process

```
1 Quote ──► 2 Booking ──► 3 APPROVAL ──► 4 Movement ──► 5 Tracking
                              │
                              ▼ (billing released only after approval)
                         6 Billing ──► 7 BRIDGE ──► 8 Ledger & month-end
                                       (only route into the ledger)
```

| Step | Who | What happens |
|---|---|---|
| 1. Quote | Operator / manager | Quote is Draft → Sent → Accepted / Rejected / Expired. An accepted quote can become a file, and its lines replace the tariff sell lines. |
| 2. Booking | Operator | Freight file created as **draft**. The file number is generated by the system (its prefix comes from mode and direction). |
| 3. Approval | Operator submits; manager or superadmin decides | Submit checks the required fields, then the file is **pending** and locked for everyone. **Approve** makes it approved. **Return** needs a note (an image is optional) and sends the file to *for correction*. |
| 4. Movement | Operator | RORO vehicles, cartage orders, dispatch routes with proof of delivery. |
| 5. Tracking | Staff | Milestones are entered by hand. The public can look up status by reference number. |
| 6. Billing | System on save; accountant reviews | Each save of an approved file rates it into sell lines (billing) and buy lines (cost), then drafts the invoice. |
| 7. Bridge | Accountant | Items are **Staged → Trial Verified → Posted**. A charge code with no ledger account is refused. |
| 8. Ledger | Accountant | Vouchers and journals, month-end close, reports. A posted invoice is **reversed**, never edited. |

---

## 5. The state machines

| Record | Statuses | Key rule |
|---|---|---|
| **Freight file (operation status)** | Draft → Pending → Approved, or Pending → For correction → Pending | Pending is locked for everyone. Approved is locked for operators. *No Cancelled state* (OP-03). Unknown or empty values count as pending. Files created before the approval step are treated as approved. |
| **Quote** | Draft, Sent, Accepted, Rejected, Expired | Only an accepted quote can be converted or linked to a file. |
| **Invoice** | Draft → Issued → Posted → Void | Reference number at draft. Invoice number fixed at issue. Voiding creates a reversal and the next revision. |
| **Bridge item** | Staged → Trial Verified → Posted | Each item is staged only once (duplicate-safe). Trial posting writes nothing. |
| **Check disbursement** | Draft, Printed, Posted, Void | The journal reference is recorded when the check is posted. |
| **RORO vehicle** | Expected, Received, Ready to Ship, Pre-Loaded, Loaded, Shipped, Hold | Every change is kept in history. Title status: Pending, Received, Missing. |
| **Cartage order** | Open, Assigned, In Transit, Delivered, Cancelled | Types: pickup, delivery, cross-dock, exchange. |
| **Dispatch route** | Draft, Dispatched, In Transit, Arrived, Completed | POD signature only when a signature pad is connected. |
| **Fleet vehicle / Driver** | Available, In Use, Maintenance / Available, On Trip, Off Duty | |
| **Ledger period** | Open → Closed | Entries dated in a closed month are refused. The system cannot reopen a month. |

---

## 6. Business rules worth knowing

### Weights and rating
- **Ocean revenue weight (W/M)** is the **greater of** gross tonnes and cubic metres. *(FR-SH-04)*
- **Air chargeable weight** is the **greater of** gross kg and volumetric weight. Volumetric weight per piece is L × W × H ÷ 6000. It is rounded up to the next 0.5 kg by default (TACT convention). *(FR-SH-05)*
- **Consolidation (MAWB):** pieces and gross weight are totalled from the HAWB rows. The MAWB chargeable weight is the greater of **total** gross and **total** volumetric weight, **not** the sum of the HAWB chargeable weights. Duplicate HAWB numbers are flagged. *(FR-SH-10 to 12)*

### Charges
- **Tariff choice:** the most specific tariff wins. Customer + lane comes first, then lane, then any. Expired or future tariffs are ignored. *(FR-RT-03)*
- **Minimum charge:** a sell amount below the tariff minimum is raised to the minimum. *(FR-BL-03)*
- **Manual lines** are never changed by recalculation. *(FR-BL-02)*
- **An accepted quote** replaces the tariff sell lines. *(FR-SH-07)*
- **VAT** is 12% on taxable lines. Each invoice is 12%, zero-rated or exempt. *(FR-SH-06)*
- **Currency:** USD is the default for international freight, with 20+ currencies. The ledger records in **PHP**. *(C-05)* **No exchange rate rule exists** (AC-03).

### Invoices and numbering
- **One live invoice per file.** *(FR-BL-04)*
- **Reference number** at draft: mode code + date + daily sequence.
- **Invoice number** at issue: mode code + year/month + monthly sequence. It is fixed once issued.
- **Void** a posted invoice to create a **reversal voucher** in the open period, and the next revision is drafted. No credit note exists yet; zero or negative invoices are refused.
- An issued reference number is **never reused**. *(DR-04)*

### Posting to the ledger
- **Billing-to-ledger mode** is a company setting:
  - **manual:** drafts only.
  - **review** (default): items are staged for one-click posting.
  - **auto:** posts when the period is open, vouchers balance and no "rate note" is open.
- Every posted journal **balances** (debits = credits). *(DR-03)*
- An **unmapped charge code is refused**, never guessed. *(FR-BR-03)*
- Today **all revenue posts to one sales account**. The split by service is Planned. *(FR-BL-10)*
- The ledger exists **only for this deployment's company**. *(FR-FS-09)*

---

## 7. Modules: what each one covers

| Module | Requirement IDs | What it covers | Status |
|---|---|---|---|
| Sign-in and access | FR-AU-01 to 12 | Username and password; access and refresh tokens; 1-minute lockout after 5 failures; proof-of-work challenge; password policy and history; idle timeout; 5 roles | Built |
| Operations overview | FR-OV-01 to 02 | Draggable widgets with live counts, to-do list, workspace per role | Built |
| Operation approval | FR-AP-01 to 07 | Draft → pending → approved / for correction; locks; reviewer recorded | Built. **Self-approval block Planned** |
| Freight files | FR-SH-01 to 12 | Ocean and air files, parties, containers, dimensions, weights, VAT, printed documents, consolidation | Built |
| Rates and master data | FR-RT-01 to 05 | Carriers, ports, airlines, warehouses, parties, billing codes, tariffs, quotes, commodities (HS code, dangerous goods) | Built. *Tariff data mostly empty* |
| Billing and invoices | FR-BL-01 to 10 | Rating engine, invoices, void and reversal, billing pipeline, posting modes | Built. **Credit note and revenue split Planned** |
| RORO vehicles | FR-VH-01 to 03 | Vehicle inventory, status, title, customs hold, VIN decode (US format only) | Built |
| Cartage | FR-PD-01 to 03 | Pickup and delivery orders, driver and equipment, link to file | Built |
| Fleet and dispatch | FR-FD-01 to 04 | Fleet and driver registries, routes, POD signature | Built. *POD hardware Partial* |
| Accounting bridge | FR-BR-01 to 07 | Stage → trial post → post; code mapping; check register; fixed voucher numbers | Built |
| General ledger | FR-FS-01 to 09 | Chart of accounts, vouchers, journals (CDV, JE, AJE, AR, AP), period close, reports, queries | Built |
| Tracking | FR-TR-01 to 05 | Tracking items, milestones, customer web accounts | Built. **Customer portal Planned** |
| Public lookup | FR-PT-01 to 03 | Look up by file, booking, waybill, master or house number; proof of work; rate limit; tracking fields only | Built |
| Live map | FR-MP-01 to 03 | Branches, ports, routes, ship and aircraft positions (limited area, max 1,500 markers) | Built. *Needs internet and feed token* |
| Administration | FR-AD-01 to 06 | Users, companies, audit trail, attachments (15 MB), support tickets, integration status, demo seed | Built. *Live connectors Planned* |

---

## 8. Non-functional requirements

| Area | Requirement | Status |
|---|---|---|
| **Security** | Hashed passwords; signed short-lived tokens; security headers and content security policy; rate limits and proof of work; **no cross-company data access**; secrets kept off the browser and out of the repository | Built |
| | **Penetration test and dependency audit before go-live** (NFR-SE-07) | **Planned (Must)** |
| **Audit** | Every change records user, company, time, action, entity and payload. Every posting keeps its journal reference. | Built |
| **Performance** | Benchmark runs on each pull request. On a demo copy: Overview ≤ 0.6 s, open booking ≤ 0.4 s, save ≤ 0.2 s, bridge queue of 200 files about 1.0 s. | Built, *measured on demo data only* |
| | Every list is paged (NFR-PF-02) | **Partial (Must)** |
| **Availability** | Health endpoint, plus a **backup and restore procedure** for both databases (NFR-AV-01) | **Partial (Must)**: backup missing |
| **Usability** | Usable at 390 px (phone) width; light and dark appearance; loading, empty and error states on lists | Partial |
| **Delivery** | Additive schema changes only, applied at start-up; merge only when checks pass; deploy only from `main`, one at a time | Built |
| **Data** | Company code set by the server; exact decimal money; balanced journals; numbers never reused; audited deletes | Built |
| **Not specified at all** | Expected volumes and number of users, uptime target, backup targets (data loss and restore time), record retention, time zone, password reset | *Gap* |

---

## 9. What is not done yet

### Planned items (SRS Appendix A)

| Requirement | Item | Priority | Waiting on |
|---|---|---|---|
| FR-AP-07 | Block self-approval | Should | Business decision (R-02) |
| FR-BL-09 | Credit note document | **Must** | Accounting decision. Use void and re-issue until then. |
| FR-BL-10 | Revenue split by service | Should | Accountants' mapping |
| FR-TR-04/05 | Customer portal | Should/Could | Not started |
| FR-AD-05, IFR-07 | Live device, government and carrier connectors | Could | Credentials |
| NFR-SE-07 | Penetration test and dependency audit | **Must** | Test window |
| NFR-AV-01 | Backup and restore procedure | **Must** | Hosting storage decision |
| DR-06 | Separate file store for attachments | Could | Hosting decision |

### Known limitations from the demo rehearsal (5 November 2026)

1. No credit note. Zero or negative invoices are refused.
2. All charges post to one sales account.
3. The legacy ledger cleanup has not been run on production.
4. Tariffs are mostly empty. Only one lane has a known rate.
5. Overview income uses estimated or actual dates, because the data has no booking date.
6. VIN decode works for US-format VINs only, and its "engine" label shows the engine layout.
7. Operators can edit each other's drafts (accepted by the business).
8. A consolidation invoice repeats the MAWB number as the house number.
9. The live map needs internet and a ship feed token.
10. Arrival notice email is preview only until SMTP is set up.
11. Files created through the API get a generic file number.
12. Not tested in the rehearsal: milestone entry screens, RORO inspection dialog, keyboard focus order, forced server errors.

### Top risks (SAD §13)

| ID | Risk | Rating |
|---|---|---|
| R-01 | Single-file databases limit concurrent writers, and recovery depends on file copies | **High** |
| R-02 | A manager or superadmin can submit and approve the same file | **High** |
| R-03 | Automatic billing depends on tariffs that are mostly not entered | **High** |
| R-04 / R-05 | No credit note; no revenue split | Medium |
| R-06 | Legacy ledger cleanup not applied to production | Medium |
| R-13 | Development credentials must be rotated before go-live | Medium |

---

## 10. Who confirms what

| Owner | Confirms | Requirement groups | Open questions |
|---|---|---|---|
| **Business owner** | Scope, priorities, roles, release gate | FR-AU-09 to 12, FR-AD, NFR-SE-05, IFR-07 | BO-01 to BO-11 |
| **Accounting lead** | Billing, tax, exchange rates, bridge, ledger, periods | FR-RT, FR-BL, FR-BR, FR-FS, NFR-AU | AC-01 to AC-18 |
| **Operations lead** | Freight, approval, cartage, dispatch, tracking | FR-AP, FR-OV, FR-SH, FR-VH, FR-PD, FR-FD, FR-TR, FR-PT, FR-MP | OP-01 to OP-12 |
| **Technical lead** | Feasibility, security, performance, deployment | FR-AU-01 to 08, IFR, NFR-SE, NFR-PF, NFR-AV, NFR-MT, DR | TL-01 to TL-10 |

### The biggest gaps to raise first
1. **Release gate:** 4 Must items are not built (BO-01).
2. **Self-approval** is allowed, and edits after approval skip re-approval (BO-02, OP-02).
3. **Consolidation and multi-party billing:** "one invoice per file" may be wrong (AC-01, AC-02).
4. **Exchange rate and tax rules** are missing for foreign-currency invoices (AC-03, AC-04, AC-05).
5. **Nothing after the invoice:** collections, supplier bill matching and profit per file (AC-08 to AC-10).
6. **No backup and restore** for a system that runs on two single-file databases (TL-01).

---

## 11. Glossary (as used in the source documents)

> This is a quick reference using the source documents' own wording. The **canonical terms**, the words to avoid, and how terms relate are kept in [CONTEXT.md](CONTEXT.md). Use those in tickets, test cases and screens.

| Term | Plain meaning |
|---|---|
| **Freight file / file** | The record of one shipment. Its file number links everything else. *(Also called "shipment" or "booking" in the documents. See OP-01.)* |
| **Operation status** | Approval state of a file: draft, pending, for correction, approved. |
| **For correction** | A file the approver returned with a note. The operator fixes it and resubmits. |
| **MAWB / HAWB** | Master air waybill (the carrier's, one per consolidation) and house air waybill (one per end customer). |
| **Consolidation** | Several HAWBs travelling under one MAWB. |
| **BL / HBL / MBL** | Bill of lading; house and master bill of lading (ocean). |
| **Chargeable weight** | Air: the greater of actual and volumetric weight. |
| **W/M (revenue weight)** | Ocean: the greater of weight (tonnes) and measurement (m³). |
| **TACT** | Air freight rounding convention; the default carrier rule. |
| **Tariff** | A rate for a charge code, optionally limited to a customer, lane and validity dates. |
| **Charge package** | A set of charge lines applied by mode, direction and incoterm. |
| **Billing line / cost line** | Sell (charged to the customer, AR) / buy (owed to the supplier, AP). |
| **Bridge item** | A billing or cost item waiting to be checked and posted to the ledger. |
| **Trial post** | Builds the journal and checks that it balances, without writing anything. |
| **Reversal voucher** | A ledger entry that undoes a posted invoice when it is voided. |
| **FS** | The general ledger module. |
| **CDV / JE / AJE** | Check disbursement voucher / journal entry / adjusting journal entry. |
| **RORO** | Roll-on/roll-off: shipping vehicles that drive onto the vessel. |
| **RORO vehicle vs fleet vehicle** | A customer's car being shipped vs the company's own truck. |
| **P/D, cartage** | Pickup and delivery trucking. |
| **POD** | Proof of delivery: a signature captured on a dispatch route. |
| **Milestone** | A timed status update on a tracking item. |
| **Proof of work** | A small puzzle the browser solves before sign-in or public lookup, to slow down bots. |
| **Company** | The business using the platform (the tenant). This is **not** the customer; customers are **parties**. |
| **Party** | A customer, shipper, consignee, agent, trucker or consolidator in the directory. |
| **HS code** | Harmonized System code for classifying commodities. |
| **DG** | Dangerous goods. |
| **VGM** | Verified gross mass of a container. |
| **Incoterm** | Trade term defining who pays which charges. |
| *Undefined in the source* | *"Rate note", "billing review", "live invoice", "encoder". See DOC-09.* |
