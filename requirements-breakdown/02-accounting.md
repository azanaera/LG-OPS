# Requirements Breakdown 2: Accounting

**Confirmed by:** Accounting lead · **Covers:** FR-RT, FR-BL, FR-BR, FR-FS, NFR-AU (33 requirements) · **Method:** [README.md](README.md)

> Every statement below describes what the system **currently does** according to SRS v0.1 and SAD v0.1. Every worked example is **to be confirmed by the Accounting lead**. Nothing here is agreed until its "Confirmed" box is ticked and the answer is in [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md).
>
> All amounts in the examples are illustrative. Currency is left out where it does not matter to the rule.

---

## Rates, Tariffs, Quotes and Commodities (FR-RT)

### FR-RT-01 Directories
**Source (SRS, verbatim):** "The system shall maintain directories of carriers, ports and airports, airlines, cargo warehouses and parties (customers, shippers, consignees, agents, truckers, consolidators) with search."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-RT-01 | Carriers, ports and airports, airlines, cargo warehouses and Parties can each be created, searched and edited. | *(Role not named)* | ☐ |

**Worked examples**
- *Given* a new Customer is added to the Party directory, *when* an Operator searches by part of its name, *then* it is found and can be chosen on a Freight File.
- *Given* a Viewer, *when* they try to add a Party, *then* the request is refused.

**Not stated — ask:** which Roles may add and change each directory; a wrong Party or port flows straight into documents and Invoices. Whether the same Party can be entered twice. Whether a Party that is used on files can be deleted (BO-14).
**Engineering check:** check:masterdata.

### FR-RT-02 Charge Codes
**Source (SRS, verbatim):** "The system shall maintain billing codes with default rate, ledger account and VAT flag."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-RT-02 | Each Charge Code holds a default rate, the Ledger Account it posts to, and a flag saying whether it is subject to VAT. | *(Role not named)* | ☐ |

**Worked examples**
- *Given* a Charge Code "documentation fee" with a default rate of 1,500.00, mapped to a Ledger Account and flagged taxable, *when* it is used on a Sell Line, *then* VAT is added and the line can be posted.
- *Given* a Charge Code saved with no Ledger Account, *then* any Bridge Item using it is refused (see FR-BR-03).

**Not stated — ask:** who may create or change a Charge Code, and whether a change affects Invoices already issued. When the default rate is used and when a Tariff is. The SRS says "billing code"; the term here is Charge Code.

### FR-RT-03 Most specific Tariff wins
**Source (SRS, verbatim):** "The system shall apply the most specific tariff (customer and lane, then lane, then any) and ignore expired or future tariffs."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-RT-03.1 | When several Tariffs fit a Charge Code, Rating uses the one for this Customer and Lane; if none, the one for this Lane; if none, the general one. | (system) | ☐ |
| FR-RT-03.2 | A Tariff whose validity has ended, or has not yet started, is ignored. | (system) | ☐ |

**Worked examples**
- *Given* three valid Tariffs for freight — Customer and Lane 80.00, Lane only 95.00, general 110.00 — *then* **80.00** is used.
- *Given* the same three, but the Customer and Lane Tariff expired yesterday, *then* **95.00** is used.
- *Given* no Tariff fits at all, *then* the file shows "no tariff" and no amount is guessed (SRS A-01).

**Not stated — ask:** which date decides validity: booking, departure, or the day the file is rated. Who enters Tariffs, and by when; only one Lane has a rate today (AC-18, DOC-16).
**Engineering check:** check:billing specificity and validity cases.

### FR-RT-04 Quotes
**Source (SRS, verbatim):** "The system shall maintain quotes with status Draft, Sent, Accepted, Rejected or Expired, and convert an accepted quote into a file."
**Priority / Status:** Should / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-RT-04.1 | A Quote has one status: Draft, Sent, Accepted, Rejected or Expired. | Operator, Manager (SAD §3.2) | ☐ |
| FR-RT-04.2 | An Accepted Quote can be converted into a new Freight File. | Operator, Manager | ☐ |
| FR-RT-04.3 | A Quote that is not Accepted cannot be converted. | (system) | ☐ |

**Worked examples**
- *Given* an Accepted Quote, *when* it is converted, *then* a Draft Freight File is created carrying the Quote's lines.
- *Given* a Rejected Quote, *when* someone tries to convert it, *then* the request is refused.

**Not stated — ask:** who marks a Quote Sent and Accepted, what proves the Customer accepted, and whether a Quote expires by date on its own (OP-14). Whether a Quote can be converted twice.

### FR-RT-05 Commodity catalogue
**Source (SRS, verbatim):** "The system shall maintain a commodity catalogue with HS code and a dangerous-goods flag, and let a free-text commodity be added to it from a booking."
**Priority / Status:** Should / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-RT-05.1 | Each Commodity in the catalogue has an HS Code and a Dangerous Goods flag. | *(Role not named)* | ☐ |
| FR-RT-05.2 | A Commodity typed as free text on a Freight File can be added to the catalogue from the file. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a Commodity flagged as Dangerous Goods, *when* it is chosen on a file, *then* the flag is shown.
- *Given* an Operator types "ceramic tiles" on a file and adds it to the catalogue, *then* it can be chosen on the next file.

**Not stated — ask:** whether a Commodity added from a file needs an HS Code before it is saved. Whether Dangerous Goods change the charges or only show a flag. This group is confirmed by the Accounting lead in the SRS, though Commodities are operational; agree who confirms.

---

## Billing and Invoices (FR-BL)

> **Cross-reference: FR-SH-06 (VAT).** The SRS lists the VAT rule under Freight Files, but it is a billing rule (DOC-10). Its entry is in [01-operations.md](01-operations.md); the Accounting lead confirms the examples below.
> - *Given* taxable Sell Lines totalling 10,000.00 on an Invoice with VAT Treatment 12 percent, *then* VAT is **1,200.00** and the Invoice total is **11,200.00**.
> - *Given* the same Invoice with VAT Treatment zero-rated, *then* VAT is **0.00** and the total is **10,000.00**.
> - **Ask:** when each VAT Treatment applies, who chooses it, and whether withholding tax is in scope (AC-04).

### FR-BL-01 Rating an Approved file
**Source (SRS, verbatim):** "When an approved file is saved, the system shall generate billing lines (sell) and cost lines (buy) from tariffs, charge packages or the accepted quote, each with its tariff reference."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-01.1 | Each time an Approved Freight File is saved, Rating runs. | (system) | ☐ |
| FR-BL-01.2 | Rating produces Sell Lines (charged to the Bill-to Party) and Cost Lines (expected to be owed to suppliers). | (system) | ☐ |
| FR-BL-01.3 | Lines come from Tariffs and Charge Packages. If an Accepted Quote is linked, its lines are the Sell Lines. | (system) | ☐ |
| FR-BL-01.4 | Each Generated Line records the Tariff it came from. | (system) | ☐ |
| FR-BL-01.5 | A file that is not Approved is not released to billing (SAD §7.8). | (system) | ☐ |

**Worked examples**
- *Given* an Approved Ocean file with a Revenue Weight of 5.0 and a freight Tariff of 95.00 per unit, *when* it is saved, *then* a Sell Line of 475.00 is generated and shows that Tariff.
- *Given* a Pending file, *when* anything is saved, *then* no billing is released.

**Not stated — ask:** Cost Lines are estimates; how actual supplier bills are recorded and matched (AC-09). Rating runs only on Ocean and Air files, so cartage, RORO and dispatch are not billed (AC-17). A save after the Invoice is issued re-rates the file and marks the Invoice for re-issue (AC-20).
**Engineering check:** check:billing.

### FR-BL-02 Manual Lines are never changed
**Source (SRS, verbatim):** "The system shall never change a manual billing line when generated lines are recalculated."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-02 | When Rating runs again, every Manual Line keeps its amount. A Manual Line with the same Charge Code as a Tariff line takes its place (SAD §7.7). | (system) | ☐ |

**Worked examples**
- *Given* a Manual Line of 500.00 for a Charge Code whose Tariff gives 450.00, *when* the file is re-rated, *then* the line is still **500.00** and no second line of 450.00 is added.
- *Given* a Generated Line of 450.00 and a Tariff that changes to 470.00, *when* the file is re-rated, *then* the Generated Line becomes 470.00.

**Not stated — ask:** which Roles may add a Manual Line, and whether one added after approval needs a second approval (OP-02). Whether a reason is recorded.

### FR-BL-03 Minimum Charge
**Source (SRS, verbatim):** "The system shall raise a sell amount to the tariff minimum when the calculated amount is lower."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-03 | When a calculated sell amount is below the Tariff's Minimum Charge, the Sell Line is set to the Minimum Charge. | (system) | ☐ |

**Worked examples**
- *Given* a calculated amount of 1,800.00 and a Minimum Charge of 2,500.00, *then* the Sell Line is **2,500.00**.
- *Given* a calculated amount of 3,000.00 and the same minimum, *then* the Sell Line is **3,000.00**.

**Not stated — ask:** whether a minimum also applies to Cost Lines. Whether the Invoice shows that a minimum was applied.
**Engineering check:** check:billing minimum case.

### FR-BL-04 Invoice draft, one per file
**Source (SRS, verbatim):** "The system shall create an invoice draft per file with a reference (mode code, date, daily sequence) and a revision number; one live invoice per file."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-04.1 | A Draft Invoice is created for a Freight File once it is rated. | (system) | ☐ |
| FR-BL-04.2 | The Draft carries an Invoice Reference in the form `<mode code>-<date>-<daily sequence>` and a revision number. | (system) | ☐ |
| FR-BL-04.3 | A Freight File has at most one Live Invoice ⚑, that is, one Invoice that is not Void. | (system) | ☐ |

**Worked examples**
- *Given* an Approved file with no Invoice, *when* it is rated, *then* one Draft Invoice exists with its own Invoice Reference at revision 1.
- *Given* a file that already has a Draft Invoice, *when* it is rated again, *then* there is still one Invoice, not two.

**Not stated — ask:** a Consolidation with 40 house Customers cannot be invoiced one per Customer (AC-01). One file cannot bill two Parties, such as prepaid and collect charges (AC-02). Ask Engineering for one real Invoice Reference (TL-10). Which time zone sets the date and the daily sequence (TL-09).
**Engineering check:** check:invoice.

### FR-BL-05 Issue an Invoice
**Source (SRS, verbatim):** "The system shall issue an invoice with an invoice number (mode code, year and month, monthly sequence), fixed once issued, and show the FS journal preview before posting."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-05.1 | Issuing a Draft Invoice gives it an Invoice Number in the form `<mode code>-<year and month>-<monthly sequence>`. | *(Role not named)* | ☐ |
| FR-BL-05.2 | Once given, the Invoice Number never changes and is never used again. | (system) | ☐ |
| FR-BL-05.3 | Before posting, the Invoice shows a preview of the Journal it will create, and the preview matches what is posted. | (system) | ☐ |

**Worked examples**
- *Given* two Invoices issued in the same month for the same Mode, *then* their Invoice Numbers differ only in the sequence, and the second is one higher than the first.
- *Given* an Issued Invoice, *when* anyone tries to change its Invoice Number, *then* it cannot be changed.

**Not stated — ask:** which Roles may issue. Whether the numbering and the printed format meet the tax authority's rules for an official invoice (AC-05). The exchange rate used when the Invoice is in USD and the Ledger is in PHP (AC-03). Ask Engineering for one real Invoice Number (TL-10).
**Engineering check:** check:invoice.

### FR-BL-06 Void a Posted Invoice
**Source (SRS, verbatim):** "The system shall void a posted invoice by creating a reversal voucher in the open period, and draft the next revision from the file; posted data shall not be edited."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-06.1 | Voiding a Posted Invoice creates a Reversal Voucher, dated in the Open Period, that mirrors the posted Vouchers. | Accountant (SAD §9.3) | ☐ |
| FR-BL-06.2 | The Invoice becomes Void. | (system) | ☐ |
| FR-BL-06.3 | The next Invoice Revision is drafted from the Freight File. | (system) | ☐ |
| FR-BL-06.4 | A Posted Invoice and its Journal cannot be edited. | (system) | ☐ |

**Worked examples**
- *Given* a Posted Invoice of 11,200.00 at revision 1, *when* the Accountant voids it, *then* a Reversal Voucher for 11,200.00 exists in the Open Period, the Invoice is Void, and a Draft at revision 2 exists.
- *Given* a Posted Invoice, *when* anyone tries to change an amount on it, *then* the change is refused.

**Not stated — ask:** whether a reason is required. Whether an Issued Invoice that is not yet Posted can be voided or changed. What the Customer receives when an Invoice is voided: there is no Credit Note ⚑ (AC-06). Whether a voided Invoice Number and its replacement meet the tax rules (AC-05).
**Engineering check:** check:flow void case.

### FR-BL-07 Billing pipeline
**Source (SRS, verbatim):** "The system shall show a billing pipeline listing files by billing stage, and a file view of billing flow."
**Priority / Status:** Should / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-07.1 | A billing pipeline lists Freight Files grouped by billing stage; the counts match the file list. | Accountant *(assumed)* | ☐ |
| FR-BL-07.2 | Each Freight File has a view showing where it is in the billing flow. | Accountant *(assumed)* | ☐ |

**Worked examples**
- *Given* 12 Approved files, 4 of them with Issued Invoices, *then* the pipeline shows 4 at the issued stage and the stage counts add up to 12.
- *Given* a Pending file, *then* it is not in the Accountant's pipeline.

**Not stated — ask:** the list of billing stages is not given anywhere. "Billing review" is used but not defined (DOC-09). Which Roles see the pipeline.

### FR-BL-08 Billing-to-Ledger Mode
**Source (SRS, verbatim):** "The system shall support a company billing-to-ledger mode: manual (drafts only), review (default; staged for one-click posting), or auto (posts when the period is open, vouchers balance and no rate note is open)."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-08.1 | The Company has one Billing-to-Ledger Mode: Manual, Review or Auto. Review is the default. | *(Role not named)* | ☐ |
| FR-BL-08.2 | Manual: Invoices stay as Drafts; nothing is staged. | (system) | ☐ |
| FR-BL-08.3 | Review: Bridge Items are Staged, ready for an Accountant to post. | (system) | ☐ |
| FR-BL-08.4 | Auto: items are posted with no person checking, when the Period is Open, the Vouchers balance and no Rate Note ⚑ is open. | (system) | ☐ |

**Worked examples**
- *Given* Review mode, *when* an Approved file is rated, *then* its Bridge Items are Staged and nothing is in the Ledger.
- *Given* Auto mode and a Closed Period, *then* nothing is posted.

**Not stated — ask:** which mode at go-live, and who may change it (AC-13). What a "rate note" is; it is not defined anywhere (AC-14).
**Engineering check:** check:flow runs each mode.

### FR-BL-09 Credit Note
**Source (SRS, verbatim):** "The system shall issue a credit note document for an invoice with a zero or negative total."
**Priority / Status:** Must / Planned · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-09 | *(Not built. Today an Invoice with a zero or negative total is refused, and the correction is Void and re-issue.)* | Accountant | ☐ |

**Worked examples** *(today's behaviour)*
- *Given* Sell Lines that total −500.00, *when* the Invoice is issued, *then* it is refused.
- *Given* a Customer was over-billed by 500.00 on a Posted Invoice, *then* the Accountant voids it and issues the next revision for the right amount.

**Not stated — ask:** whether Void and re-issue is acceptable at go-live; this is a **Must** that is not built (AC-06, BO-01). What a Credit Note must contain and when one is required.

### FR-BL-10 Revenue split by service
**Source (SRS, verbatim):** "The system shall post charges to revenue accounts by service (freight, handling, documentation) rather than to one sales account."
**Priority / Status:** Should / Planned · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BL-10 | *(Not built. Today every charge posts to one sales account.)* | (system) | ☐ |

**Worked examples** *(today's behaviour)*
- *Given* an Invoice with freight 8,000.00 and documentation 2,000.00, *then* 10,000.00 is posted to the one sales account.
- *After the split:* 8,000.00 to freight revenue and 2,000.00 to documentation revenue. *(Needs the mapping.)*

**Not stated — ask:** the mapping from each Charge Code to its revenue account (AC-07).

---

## Accounting Bridge (FR-BR)

### FR-BR-01 Stage items once
**Source (SRS, verbatim):** "The system shall stage AR invoice items and AP cost items from billing as Staged, once each."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-01.1 | Invoice amounts (receivable) and cost amounts (payable) from billing become Bridge Items with status Staged. | (system) | ☐ |
| FR-BR-01.2 | Each amount is staged once. Staging it again does not create a second Bridge Item. | (system) | ☐ |

**Worked examples**
- *Given* an Invoice is staged, *when* staging runs a second time, *then* there is still **one** Bridge Item for it.
- *Given* a file that is not Approved, *then* nothing of it is staged.

**Not stated — ask:** the SAD lists a third item type, "miscellaneous invoice", with no requirement (AC-19). Whether cost items are staged at the estimate or wait for the supplier's bill (AC-09).

### FR-BR-02 Bridge queue
**Source (SRS, verbatim):** "The system shall show staged items in an operations queue with a stage funnel and a drawer for detail."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-02 | The Accounting Bridge shows its Bridge Items in a queue with each item's status, a count per status, and a detail panel for one item. | Accountant (SAD §9.2) | ☐ |

**Worked examples**
- *Given* 5 Staged and 2 Trial Verified items, *then* the queue shows 7 items and the counts show 5 and 2.
- *Given* an Operator, *when* they try to open the queue, *then* access is refused: Operators have no Ledger access.

**Not stated — ask:** whether Managers and Viewers can see the queue (AC-15, DOC-13).

### FR-BR-03 Charge Code Mapping
**Source (SRS, verbatim):** "The system shall map each charge code to a ledger account and refuse an item whose code is unmapped, giving the reason."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-03.1 | Each Charge Code is linked to one Ledger Account. | *(Role not named)* | ☐ |
| FR-BR-03.2 | A Bridge Item whose Charge Code has no Ledger Account is refused, and the reason is shown. The system never guesses an account. | (system) | ☐ |

**Worked examples**
- *Given* a Bridge Item for a Charge Code with no Ledger Account, *when* the Accountant trial-posts it, *then* it is refused with a message naming the unmapped Charge Code.
- *Given* the mapping is then added, *when* the Accountant tries again, *then* it goes through.

**Not stated — ask:** who maintains the mapping. Whether the chart holds every account the Charge Codes need (SRS A-02).
**Engineering check:** check:bridge.

### FR-BR-04 Trial Post
**Source (SRS, verbatim):** "The system shall run a trial post that builds the journal and checks debits equal credits without writing, then set Trial Verified."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-04.1 | A Trial Post builds the Journal for a Staged Bridge Item and checks that total debits equal total credits. | Accountant (SAD §9.2); other Roles not stated | ☐ |
| FR-BR-04.2 | A Trial Post writes nothing to the Ledger. | (system) | ☐ |
| FR-BR-04.3 | When the Journal balances, the Bridge Item becomes Trial Verified. | (system) | ☐ |

**Worked examples**
- *Given* a Staged item whose Journal has debits of 11,200.00 and credits of 11,200.00, *when* it is trial-posted, *then* it is Trial Verified and the Ledger is unchanged.
- *Given* an item whose Journal would have debits of 11,200.00 and credits of 10,000.00, *then* it is refused and stays Staged.

**Not stated — ask:** which Roles may Trial Post. Managers have "all ledger functions" and also approve files (AC-15).
**Engineering check:** check:bridge.

### FR-BR-05 Post
**Source (SRS, verbatim):** "The system shall post a trial-verified item as a balanced journal, set Posted and record the journal reference."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-05.1 | A Trial Verified Bridge Item can be posted; a balanced Journal is written to the Ledger. | Accountant (SAD §9.2); other Roles not stated | ☐ |
| FR-BR-05.2 | The Bridge Item becomes Posted and keeps the Journal's reference. | (system) | ☐ |
| FR-BR-05.3 | A Staged item that has not been Trial Verified cannot be posted. | (system) | ☐ |
| FR-BR-05.4 | Posting into a Closed Period is refused (SAD §9.2). | (system) | ☐ |

**Worked examples**
- *Given* a Trial Verified item, *when* the Accountant posts it, *then* the Journal is in the register for the Open Period and the item shows its Journal reference.
- *Given* a Staged item, *when* someone tries to post it directly, *then* the request is refused.

**Not stated — ask:** which Roles may Post, and whether the person who approved the file may post it (AC-15). The posting date and time zone (TL-09).
**Engineering check:** check:bridge.

### FR-BR-06 Check Disbursement register
**Source (SRS, verbatim):** "The system shall keep a check disbursement register with Draft, Printed, Posted and Void, and record the journal reference of a posted check."
**Priority / Status:** Should / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-06.1 | A Check Disbursement ⚑ has one status: Draft, Printed, Posted or Void. Each change is recorded. | Accountant *(assumed)* | ☐ |
| FR-BR-06.2 | A Posted Check Disbursement keeps its Journal reference. | (system) | ☐ |

**Worked examples**
- *Given* a Draft check, *when* it is printed and then posted, *then* it is Posted and shows its Journal reference.
- *Given* a Printed check that was spoiled, *when* it is set to Void — is the check number kept as void? *(Not stated. Ask.)*

**Not stated — ask:** what checks are used for, and where payments by bank transfer or cash are recorded (AC-22). Who signs, and whether there is an approval before printing. Whether voiding a Posted check creates a reversal.

### FR-BR-07 Fixed Voucher numbers
**Source (SRS, verbatim):** "The system shall fix voucher numbers per invoice (sales invoice, receipt, reversal) and check them against the ledger before every write."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-BR-07.1 | Each Invoice has fixed Voucher numbers for its sales invoice, its receipt and its reversal. | (system) | ☐ |
| FR-BR-07.2 | Before writing a Voucher, the system checks the Ledger; running the same step twice does not create a second Voucher. | (system) | ☐ |

**Worked examples**
- *Given* an Invoice already posted, *when* posting is run again, *then* no second sales Voucher is written.
- *Given* an Invoice that is voided, *then* its Reversal Voucher uses the reversal number fixed for that Invoice.

**Not stated — ask:** a "receipt" Voucher number is fixed, but nothing says how a Customer's payment is recorded (AC-08).

---

## Ledger (FR-FS)

### FR-FS-01 Chart of Accounts
**Source (SRS, verbatim):** "The system shall maintain the chart of accounts as a tree of account, sub-account and subsidiary, with group codes and subsidiary groups."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-01 | The Chart of Accounts is a tree with three levels (account, sub-account, subsidiary), with group codes and subsidiary groups. Each level can be viewed and saved. | Accountant *(assumed)* | ☐ |

**Worked examples**
- *Given* a new subsidiary is added under a sub-account, *when* the tree is reopened, *then* it is shown under that sub-account.
- *Given* a Ledger Account that has posted Journals, *when* someone tries to delete it — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** who may change the chart (BO-14). Whether the chart in the system matches the Company's real chart (SRS A-02).

### FR-FS-02 Disbursement Vouchers
**Source (SRS, verbatim):** "The system shall record cash disbursement vouchers with bank, supplier and signatory data."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-02 | A disbursement Voucher records the bank, the supplier and the signatories, and can be saved and printed. | Accountant *(assumed)* | ☐ |

**Worked examples**
- *Given* a Voucher saved with a bank, a supplier and two signatories, *when* it is printed, *then* all three appear.
- *Given* a Voucher dated in a Closed Period, *then* it is refused (see FR-FS-04).

**Not stated — ask:** this says "cash disbursement voucher", but the SRS acronym table says CDV means "check disbursement voucher". Which is meant, and how this differs from the Check Disbursement register in FR-BR-06 (DOC-09, AC-22).

### FR-FS-03 Journal entries
**Source (SRS, verbatim):** "The system shall record journal entries of types CDV, JE, AJE, AR and AP, each balanced before saving."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-03.1 | A Journal has one type: CDV (disbursement), JE (journal entry), AJE (adjusting entry), AR (receivable) or AP (payable). | Accountant *(assumed)* | ☐ |
| FR-FS-03.2 | A Journal whose debits do not equal its credits cannot be saved. | (system) | ☐ |

**Worked examples**
- *Given* a JE with debits of 5,000.00 and credits of 5,000.00, *then* it saves.
- *Given* a JE with debits of 5,000.00 and credits of 4,999.99, *then* it is refused.

**Not stated — ask:** whether an Accountant can type an AR or AP Journal directly; that would bypass the rule that the Accounting Bridge is the only route into the Ledger (SRS C-04). Whether a manual Journal needs a second person to approve it (AC-15).

### FR-FS-04 Closed Periods refuse entries
**Source (SRS, verbatim):** "The system shall refuse a new or re-dated entry in a closed period and name the first open date."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-04 | A new Journal dated in a Closed Period, or an existing Journal re-dated into one, is refused, and the message names the first open date. | (system) | ☐ |

**Worked examples**
- *Given* the Period for October 2026 is Closed, *when* an Accountant saves a Journal dated 31 October 2026, *then* it is refused and the message names **1 November 2026**.
- *Given* the same, *when* the Journal is dated 1 November 2026, *then* it saves.

**Not stated — ask:** the system cannot reopen a Closed Period; reopening is done "outside the system", which leaves no audit record (AC-12). Which time zone decides the date (TL-09).

### FR-FS-05 Posting and the register
**Source (SRS, verbatim):** "The system shall post entries to the ledger and show posted entries in the register for the open period."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-05.1 | A saved Journal can be posted to the Ledger. | Accountant *(assumed)* | ☐ |
| FR-FS-05.2 | The register shows the posted Journals of the Open Period. Closed Periods are reached through the query browser (FR-FS-08). | (system) | ☐ |

**Worked examples**
- *Given* a Journal posted on 5 November 2026 with November Open, *then* it is in the register.
- *Given* a Journal posted in October, now Closed, *then* it is not in the register and is found through the query browser.

**Not stated — ask:** whether saving and posting are two steps done by two people. Whether a posted manual Journal can be reversed, and how.

### FR-FS-06 Month-end Close
**Source (SRS, verbatim):** "The system shall run month-end close for the open period, create closing entries and mark the period closed."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-06.1 | Month-end Close can be run for the Open Period. | Accountant (SAD §9.6) | ☐ |
| FR-FS-06.2 | It creates the closing entries. | (system) | ☐ |
| FR-FS-06.3 | It marks the Period Closed. | (system) | ☐ |

**Worked examples**
- *Given* October 2026 is the Open Period, *when* the Accountant runs Month-end Close, *then* closing entries exist and October is Closed.
- *Given* October still has Staged Bridge Items that are not posted, *when* Month-end Close is run — allowed, warned or refused? *(Not stated. Ask.)*

**Not stated — ask:** what must be finished before a close is allowed. Whether a second person approves the close. The fiscal year, and whether there is a year-end close (AC-21). Reopening (AC-12).

### FR-FS-07 Reports
**Source (SRS, verbatim):** "The system shall produce the trial balance, income statement, balance sheet, cash flow, check voucher report and subsidiary schedule."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-07 | The Ledger produces six reports: trial balance, income statement, balance sheet, cash flow, check voucher report and subsidiary schedule. Their totals agree with the posted Journals. | Accountant *(assumed)* | ☐ |

**Worked examples**
- *Given* the posted Journals of a Period, *then* the trial balance has equal debit and credit totals.
- *Given* sales posted in the Period total 250,000.00, *then* the income statement shows sales of 250,000.00.

**Not stated — ask:** the date ranges and layouts the Accounting lead needs, and whether reports can be exported. Reports that are missing: receivables aging and statements of account (AC-08), profit per file (AC-10). Which "income" figure is official: this one or the Overview's (AC-11).
**Engineering check:** company chart check, qa:accounting.

### FR-FS-08 Query browser
**Source (SRS, verbatim):** "The system shall provide a query browser for ledger transactions, including closed periods."
**Priority / Status:** Should / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-08 | Ledger transactions can be searched, including those in Closed Periods. | Accountant *(assumed)* | ☐ |

**Worked examples**
- *Given* a Journal posted in a Closed Period, *when* it is searched by its reference, *then* it is found.
- *Given* an Operator, *when* they try to open the query browser, *then* access is refused.

**Not stated — ask:** whether a Viewer, such as an auditor, can use it (DOC-13).

### FR-FS-09 One Company's Ledger
**Source (SRS, verbatim):** "The system shall define the chart and posting accounts for the company of this deployment only, and shall provide no ledger data to companies without a chart."
**Priority / Status:** Must / Built · **Owner:** Accounting lead (decision: Business owner) · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FS-09.1 | The Chart of Accounts and the accounts that billing posts to exist for this deployment's Company only. | (system) | ☐ |
| FR-FS-09.2 | A Company without a chart receives no Ledger data. | (system) | ☐ |

**Worked examples**
- *Given* a second Company is set up without a chart, *when* its User opens the Ledger, *then* no accounts or Journals are shown.
- *Given* that second Company issues an Invoice — where does it post? *(Nowhere today. Ask.)*

**Not stated — ask:** whether more than one Company will ever use the Platform (BO-03, DOC-05).

---

## Auditability (NFR-AU)

### NFR-AU-01 Content of an audit record
**Source (SRS, verbatim):** "Each audit record shall hold user, company, time, action, entity identifier and payload."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Detailed enough

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Fields present on each audit record | User, Company, time, action, record identifier, content of the change | Make one change; open its audit record | Any record | "Sample change shows all five fields" — but the requirement lists **six** |

**Not stated — ask:** which Roles may read the audit trail (BO-14). How long audit records are kept (BO-11). Whether the record shows the value before the change as well as after.

### NFR-AU-02 Every posting is traceable
**Source (SRS, verbatim):** "Each ledger posting shall keep the journal reference, and the bridge audit report shall list every posted reference."
**Priority / Status:** Must / Built · **Owner:** Accounting lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| NFR-AU-02.1 | Every posting to the Ledger keeps its Journal reference. | (system) | ☐ |
| NFR-AU-02.2 | The bridge audit report lists the reference of every Posted Bridge Item. | (system) | ☐ |

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Posted Bridge Items missing from the audit report | 0 | Compare the count of Posted items with the report | A full Period | Posted item listed in the report (one sample) |

**Not stated — ask:** whether an auditor can go from an Invoice to its Journal and back in the system.

---

## Candidate requirements

These are **not** requirements. Each is a possible new requirement raised by a gap, waiting for the owner's decision on the linked question.

| ID | Candidate requirement | Why | Question | Gap |
|---|---|---|---|---|
| CR-20 | The exchange rate for an Invoice is fixed at Issue from one chosen source, stored on the Invoice, and can be overridden only by an Accountant. | No rule exists; the rate comes from the browser today. | AC-03, TL-08 | GAP-35 |
| CR-21 | Rules state when an Invoice is 12 percent, zero-rated or exempt, who chooses, and whether withholding tax applies. | Only the 12 percent rate is stated. | AC-04 | GAP-36 |
| CR-22 | The Invoice meets the tax authority's rules for number series, voided numbers and printed format. | Not checked. | AC-05 | GAP-37 |
| CR-23 | A Consolidation can be invoiced per HAWB to each house Customer. | One Invoice per file cannot bill many Customers. | AC-01 | GAP-33 |
| CR-24 | One Freight File can bill more than one Bill-to Party. | Prepaid and collect, origin and destination charges. | AC-02 | GAP-34 |
| CR-25 | Customer payments, receipts, receivables aging and statements of account are recorded. | Nothing exists after the Invoice. | AC-08 | GAP-53 |
| CR-26 | Actual supplier bills are recorded and matched to Cost Lines; differences are adjusted. | Cost Lines are estimates only. | AC-09 | GAP-54 |
| CR-27 | A profit report (sell less cost) by file, Customer and Lane. | Core management report; not specified. | AC-10 | GAP-55 |
| CR-28 | Cartage Orders, RORO Vehicle shipping and Dispatch Routes can be charged to a Customer. | Billing runs on Ocean and Air files only. | AC-17 | GAP-26 |
| CR-29 | Only an Accountant may Trial Post and Post; a User who approved a file may not post it. | One person could approve, bill and post. | AC-15 | GAP-45 |
| CR-30 | Reopening a Closed Period is an audited function with approval, or a written procedure. | Done outside the system today. | AC-12 | GAP-49 |
| CR-31 | The miscellaneous invoice is defined: its use, who may raise one, and its approval. | In the SAD with no requirement. | AC-19 | GAP-47 |
| CR-32 | When an Issued Invoice is marked for re-issue, a named Role is told and re-issues it within an agreed time. | The Customer may hold a wrong Invoice. | AC-20 | GAP-39 |
| CR-33 | The fiscal year is stated, with any year-end close steps. | Only month-end is specified. | AC-21 | GAP-50 |
| CR-34 | Payments other than checks are recorded. | Only a check register exists. | AC-22 | GAP-48 |
| CR-35 | The Overview's income figure is labelled "estimated"; the Ledger figure is official. | Two "income" figures. | AC-11 | GAP-40 |
