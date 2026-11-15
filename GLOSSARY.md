# Glossary: the words we use for the Platform

**For:** everyone — business owners, operations, accounting, developers and testers.
**Date:** 15 November 2026 · **Status:** proposed. No term is final until the owner of its area confirms it.

> The term names here are the same as in [CONTEXT.md](CONTEXT.md), which developers and testers use. If the two ever differ, CONTEXT.md is right and this file is corrected.

## 1. How to use this glossary

When we talk or write about the Platform, we use the word in the **Term** column and no other. That way an operator, an accountant and a developer all mean the same thing. If your office uses a different word, look in the **You may know it as** column, and tell us if the word here feels wrong.

A flag **⚑** means *we still need your answer on this one*. The code after it (for example ⚑ OP-01) is the number of the question in [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md).

## 2. The 12 words that matter most

```
1 Quote ──► 2 Booking ──► 3 APPROVAL ──► 4 Movement ──► 5 Tracking
                              │
                              ▼
                         6 Billing ──► 7 BRIDGE ──► 8 Ledger
```

| Word | In one line |
|---|---|
| **Freight File** | The record of one shipment job. Everything else about the shipment hangs off it. |
| **File Number** | Our own number for a Freight File. It links the booking, the invoice and the accounting entries. |
| **Operation Status** | Where a Freight File is in approval: **Draft** → **Pending** → **Approved**, or sent back as **For Correction**. |
| **Submit** | The operator sends a finished file to be checked. From then on nobody can change it. |
| **Return** | The approver sends a file back with a note saying what to fix. |
| **Sell Line** | One charge to the customer. |
| **Cost Line** | One cost we expect to pay a supplier for the same job. |
| **Invoice** | The bill made from a file's Sell Lines. |
| **Accounting Bridge** | The checkpoint between billing and the books. Nothing reaches the books except through it. |
| **Post** | To write an entry into the books. Once posted, it is never edited, only reversed. |
| **Ledger** | The company's books of account. |
| **Period** | One accounting month. Once closed, nothing more can be dated in it. |

## 3. A to Z

| Term | Plain meaning | You may know it as | Example from our work | Status |
|---|---|---|---|---|
| **Accountant** | The role for accounting staff. Handles billing review, the Accounting Bridge and the Ledger, and sees Approved files only. | Finance, bookkeeper | The accountant posts this week's invoices. | Proposed |
| **Accounting Bridge** | The only path by which billing and costs reach the Ledger. Items wait there, are checked, then posted. | The bridge, integration, sync | "It's in the bridge, not posted yet." | Proposed |
| **Agent** | An overseas forwarder that handles the other end of a shipment for us. | Partner, correspondent | Our agent in Singapore releases the cargo. | Proposed |
| **Air Waybill** | The air transport document for an air file that is not a consolidation. | AWB, airway bill | One air waybill for one shipper's cargo. | Proposed |
| **Approved** | The Operation Status that releases a file to billing. Operators can no longer change it. | Confirmed, released, final | Only Approved files appear to accounting. | Proposed |
| **Approver** | The manager or superadmin who approved or returned a file. | Reviewer, checker | The history shows the approver and the time. | Proposed |
| **Arrival Notice** | The document telling the consignee that cargo has arrived. One per house air waybill in a consolidation. | AN, arrival advice | 5 houses, 5 arrival notices. | Proposed |
| **Bill-to Party** | The party the invoice is addressed to and who owes the money. Not always the shipper or consignee. | Payer, billed party | The consignee's parent company pays. | ⚑ AC-02 |
| **Billing-to-Ledger Mode** | The company setting for how invoices reach the books: Manual, Review or Auto. | Posting mode, automation mode | Review mode: a person posts each item. | Proposed |
| **Booking Number** | The carrier's reference for space booked on a vessel or flight. Not our File Number. | Booking ID, reservation number | The shipping line's booking reference. | ⚑ OP-01 |
| **Branch** | A physical office or terminal of the company. Today it only appears on the map. | Office, site | Our port-side office. | ⚑ BO-04 |
| **Bridge Item** | One invoice or cost amount waiting in the Accounting Bridge. It is Staged, Trial Verified or Posted. | Queue item, posting item | 5 items staged, 2 verified. | Proposed |
| **Cancelled** | A *proposed* status for a file whose shipment will not happen. It does not exist yet. | Void, deleted | Customer cancels before sailing. | ⚑ OP-03 |
| **Cargo Warehouse** | A place in the directory where cargo is held before or after it moves. | Depot, storage | Cargo waits at the airport warehouse. | Proposed |
| **Carrier** | The shipping line or airline that physically moves the cargo. | Line, vendor | The airline on the master air waybill. | Proposed |
| **Cartage Order** | An order to pick up, deliver, cross-dock or exchange cargo by truck. | P/D order, trucking job, delivery order | Deliver 3 pallets from the port to the customer. | Proposed |
| **Charge Code** | A defined kind of charge, such as freight, handling or documentation, with its rate, its account and whether it is taxed. | Billing code, fee code | "Documentation fee" is a charge code. | Proposed |
| **Charge Code Mapping** | The link from each Charge Code to the account it is recorded under. With no link, the item cannot be posted. | Account mapping | Freight → freight revenue account. | Proposed |
| **Charge Package** | A ready-made set of charges applied by mode, direction and trade term. | Bundle, template | Standard charges for an ocean import. | Proposed |
| **Chargeable Weight** | For air: the greater of the actual weight and the Volumetric Weight. Air charges are worked out on it. | Billable weight | 30 kg of light, bulky cargo charged as 67.0 kg. | Proposed |
| **Chart of Accounts** | The company's list of accounts, arranged as a tree. | COA, account list | Sales, receivables, payables. | Proposed |
| **Check Disbursement** | A recorded payment by check. It is Draft, Printed, Posted or Void. | Cheque, payment, CDV | A check to a trucking supplier. | ⚑ DOC-09 |
| **Commodity** | A catalogued kind of goods, with its HS Code and a Dangerous Goods flag. | Product, goods description | "Ceramic tiles". | Proposed |
| **Company** | The business that runs the Platform and owns its records. **Never** a customer. | Tenant, organisation | Us. | Proposed |
| **Consignee** | The party the cargo is delivered to. | Receiver, importer | The buyer who collects the cargo. | Proposed |
| **Consolidation** | An air file in which several house air waybills travel under one master air waybill. | Consol, co-load | 40 customers' cargo on one master. | Proposed |
| **Consolidator** | A party that groups several shippers' cargo under one master air waybill. | Co-loader | — | Proposed |
| **Container** | An ocean shipping box on a file, identified by type, number and seal. | Box, unit | One 40-foot container. | Proposed |
| **Cost Line** | A cost we expect to owe a supplier for a file. | Buy line, cost accrual, AP line | The shipping line's freight charge to us. | Proposed |
| **Credit Note** | A *planned* document that reduces an amount already invoiced. It does not exist yet. | Credit memo, refund | Customer was over-billed by 500.00. | ⚑ AC-06 |
| **Customer** | A party that buys our services and can be billed. | Client, account | — | Proposed |
| **Customs Hold** | A marker that customs has not cleared a RORO Vehicle. Separate from the Hold status. | Hold, customs block | — | ⚑ OP-17 |
| **Dangerous Goods** | Goods that need special handling under transport rules. | Hazmat, DG | Lithium batteries. | Proposed |
| **Dimension Line** | One line of cargo measurements: pieces, length, width, height, weight. | Dims, cargo line | 2 pieces, 100 × 50 × 40 cm. | Proposed |
| **Direction** | Whether a file is Export, Import or Domestic. | Movement type, trade | — | Proposed |
| **Dispatch Route** | A planned run by one driver in one company truck through a series of stops. | Trip, run | Three deliveries on one morning run. | Proposed |
| **Document Currency** | The currency an invoice or charge is written in, such as USD or PHP. | Invoice currency, FX | Invoice in USD; books in PHP. | ⚑ AC-03 |
| **Draft** | The Operation Status of a file not yet submitted. It can be changed. | New, open | The operator is still typing it up. | Proposed |
| **Driver** | A company person assigned to drive a company truck. | — | Not an outside trucker. | Proposed |
| **File Number** | Our own identifier for a Freight File. Given by the system and never reused. | Job number, reference | — | Proposed |
| **Fleet Vehicle** | A truck or other vehicle the company owns or runs. | Truck, unit, vehicle | Our 10-wheeler. | Proposed |
| **For Correction** | The Operation Status of a file the approver sent back with a note. It can be fixed and submitted again. | Returned, rejected, sent back | "Consignee address missing." | Proposed |
| **Freight File** | The single record of one shipment job, from booking to billing. | Shipment, booking, job, file | — | Proposed |
| **Generated Line** | A Sell Line or Cost Line worked out by the system from a Tariff. | Auto line, system line | Freight at 95.00 × 5.0. | Proposed |
| **HAWB** | A house air waybill: our contract with one shipper inside a consolidation. | House, house bill | One per end customer. | Proposed |
| **HS Code** | The international code that classifies a kind of goods. | Customs code, tariff code | — | Proposed |
| **Incoterm** | The standard trade term that decides which party pays which charges. | Shipping terms | FOB, CIF. | Proposed |
| **Invoice** | The bill for a file's Sell Lines. It is Draft, Issued, Posted or Void. | Bill, billing, sales invoice | — | Proposed |
| **Invoice Number** | The number an invoice gets when it is issued. It never changes or repeats. | SI number | — | Proposed |
| **Invoice Reference** | The temporary identifier an invoice has while it is a draft. | Draft number | — | Proposed |
| **Invoice Revision** | A numbered version of a file's invoice. A new one is drafted after each Void. | Version, re-issue | Revision 2 replaces a voided revision 1. | Proposed |
| **Issue** | To finalise a draft invoice so that it receives its Invoice Number. | Release, finalise | — | Proposed |
| **Journal** | A balanced set of debit and credit lines in the Ledger. | Entry, transaction | Debits 11,200.00 = credits 11,200.00. | Proposed |
| **Lane** | An origin and destination pair that Tariffs are priced for. | Trade lane, route | Manila to Singapore. | Proposed |
| **Ledger** | The company's general ledger: its accounts, Journals and Periods. | The books, GL, FS | — | Proposed |
| **Ledger Account** | One account in the Chart of Accounts. | GL account, code | "Sales". | Proposed |
| **Lien Release** | A marker that a lender's claim on a RORO Vehicle has been lifted. | Bank release | — | ⚑ OP-17 |
| **Live Invoice** | The one invoice per file that is not Void. | Current invoice, active invoice | — | ⚑ AC-01 |
| **Manager** | The role that supervises operations and approves or returns files. | Supervisor | — | Proposed |
| **Manual Line** | A Sell Line or Cost Line typed in by a person. The system never changes it. | Override, ad-hoc charge | A one-off storage charge of 500.00. | Proposed |
| **MAWB** | The master air waybill: the airline's contract for a whole consolidation. | Master, master bill | One per consolidation. | Proposed |
| **Milestone** | A dated status update on a shipment, with place and note. | Event, status update | "Arrived at port, 3 November." | Proposed |
| **Minimum Charge** | The lowest amount a Tariff allows. A smaller calculated amount is raised to it. | Floor, min rate | 1,800.00 raised to 2,500.00. | Proposed |
| **Miscellaneous Invoice** | A kind of Bridge Item that does not come from a Freight File. Its use is not yet defined. | — | — | ⚑ AC-19 |
| **Mode** | How cargo travels on a file: Ocean or Air. | Type, service | — | Proposed |
| **Month-end Close** | Closing the open accounting month. After it, nothing more can be dated in that month. | Period end, closing | Close October in early November. | Proposed |
| **Notify Party** | The party to be told when cargo arrives. May differ from the consignee. | Notify | The consignee's customs broker. | Proposed |
| **Operation Status** | The approval state of a Freight File: Draft, Pending, For Correction or Approved. | Status, approval status | — | Proposed |
| **Operator** | The role that creates, edits and submits Freight Files and handles movement records. It cannot approve. | Encoder, clerk | — | Proposed |
| **Party** | Any outside person or business a file can name: shipper, consignee, agent, carrier, trucker. | Contact, account | — | Proposed |
| **Pending** | The Operation Status of a file waiting for a decision. Nobody can change it. | Submitted, for approval, in review | — | Proposed |
| **Period** | One accounting month. It is Open or Closed. | Fiscal period, month | October 2026. | Proposed |
| **Post** | To write a balanced Journal into the Ledger. | Book, record | — | Proposed |
| **Proof of Delivery** | The signed record, with signer and time, that cargo was handed over. | POD, delivery receipt | — | Proposed |
| **Public Lookup** | The page where anyone can enter a reference and see a shipment's status, without signing in. | Public tracking, track and trace | — | Proposed |
| **Public Visitor** | Anyone without a sign-in who uses the Public Lookup. | Guest | A customer checking their cargo. | Proposed |
| **Quote** | A priced offer to a customer before booking. It is Draft, Sent, Accepted, Rejected or Expired. | Quotation, estimate | — | Proposed |
| **Rate Note** | Not defined in the source documents. An open one stops automatic posting. | — | — | ⚑ AC-14 |
| **Rating** | Working out a file's Sell Lines and Cost Lines from its Tariffs, Charge Packages or Accepted Quote. | Pricing, costing | — | Proposed |
| **Return** | To send a Pending file back to For Correction with a note. | Reject, send back | — | Proposed |
| **Return Note** | The explanation an approver must give when returning a file. | Rejection reason, remark | — | Proposed |
| **Revenue Weight** | For ocean: the greater of the weight in tonnes and the volume in cubic metres. Ocean charges are worked out on it. | W/M, freight ton | 3.2 tonnes and 5.0 m³ is charged on 5.0. | Proposed |
| **Reversal Voucher** | An accounting document that undoes a posted invoice when it is voided. | Reversing entry | — | Proposed |
| **Role** | The single set of permissions a user holds: Superadmin, Manager, Operator, Accountant or Viewer. | User type, profile | — | Proposed |
| **RORO Vehicle** | A customer's vehicle being shipped on a roll-on/roll-off vessel. It is cargo. | Car, unit, vehicle | A customer's SUV being exported. | Proposed |
| **Sell Line** | A charge to the Bill-to Party on a file. Sell Lines make up the invoice. | Billing line, revenue line | Freight 475.00. | Proposed |
| **Self-approval** | A user approving a file that the same user submitted. | Own approval | A manager books and approves the same file. | ⚑ BO-02 |
| **Shipper** | The party sending the cargo. | Sender, exporter | — | Proposed |
| **Signatory** | A person authorised to sign a disbursement voucher or check. | Signer, authoriser | — | Proposed |
| **Stage** | To place an item in the Accounting Bridge, once only. | Queue, send to accounting | — | Proposed |
| **Stop** | One place a Dispatch Route visits. | Drop, leg | — | Proposed |
| **Submit** | To send a Draft or For Correction file for an approval decision. | Send for approval | — | Proposed |
| **Submitter** | The user who last submitted a file for approval. | Encoder, creator | — | Proposed |
| **Superadmin** | The technical administrator role. It can do everything. | Admin, root | — | Proposed |
| **Tariff** | A rate for a Charge Code, which can be limited to a customer, a Lane and a validity period. | Rate card, price | Freight on a lane at 95.00. | Proposed |
| **Title Status** | Whether the ownership papers of a RORO Vehicle are Pending, Received or Missing. | Papers, document status | — | Proposed |
| **Tracking Item** | The record that carries Milestones for a file, a Cartage Order or a RORO Vehicle. | Tracker | — | Proposed |
| **Trial Post** | A rehearsal of posting: the entry is built and checked for balance, but nothing is written to the books. | Test post, dry run, preview | — | Proposed |
| **Trucker** | An outside trucking company hired for cartage. Not our own drivers. | Hauler, subcontractor | — | Proposed |
| **User** | A staff member with a sign-in to the Platform. | Account, login | — | Proposed |
| **VAT Treatment** | How VAT applies to an invoice: 12 percent, zero-rated or exempt. | Tax type | 10,000.00 + 12% = 11,200.00. | Proposed |
| **Viewer** | The read-only role, for example for auditors. | Read-only user, guest | — | Proposed |
| **Void** | To cancel a posted invoice. The books are reversed and a new revision is drafted. | Cancel, delete | — | Proposed |
| **Volumetric Weight** | The weight air cargo is treated as having because of the space it takes: length × width × height ÷ 6000 for each piece. | Dimensional weight, volume weight | 100 × 50 × 40 cm = 33.33 kg a piece. | Proposed |
| **Voucher** | The numbered accounting document behind a Journal. | Slip | Sales invoice, receipt, reversal. | Proposed |
| **Web Account** | A customer's record for a future customer website. It does not allow sign-in yet. | Customer login, portal user | — | ⚑ BO-05 |

## 4. Trade and accounting abbreviations

Abbreviations are fine among specialists. In documents that non-specialists read, use the glossary term.

| Abbreviation | Stands for | Use this term |
|---|---|---|
| AP | Accounts payable: what we owe suppliers | Cost Line (on a file); payables (in the Ledger) |
| AR | Accounts receivable: what customers owe us | Sell Line, Invoice; receivables (in the Ledger) |
| AWB | Air waybill | Air Waybill |
| BL / HBL / MBL | Bill of lading / house / master (ocean) | Bill of lading |
| CDV | Check disbursement voucher — or cash disbursement voucher; the source documents use both ⚑ DOC-09 | Check Disbursement |
| JE / AJE | Journal entry / adjusting journal entry | Journal |
| DG | Dangerous goods | Dangerous Goods |
| FCL / LCL | Full container load / less than container load | — |
| FS | The name of the ledger module in the software | Ledger |
| HS | Harmonized System | HS Code |
| P/D | Pickup and delivery | Cartage Order |
| POD | Proof of delivery | Proof of Delivery |
| RORO | Roll-on/roll-off: vehicles driven onto the vessel | RORO Vehicle |
| TACT | The airlines' standard rule book; here, the rule for rounding weight up to the next half kilogram | Chargeable Weight |
| VAT | Value-added tax (12 percent) | VAT Treatment |
| VGM | Verified gross mass of a container | — |
| VIN | Vehicle identification number | — |
| W/M | Weight or measurement | Revenue Weight |
| PHP / USD | Philippine peso / US dollar | Document Currency |

## 5. Words that mean different things to different people

| The word | Who uses it how | What we will say |
|---|---|---|
| "Shipment", "booking", "file" | All three were used for the same record. | **Freight File**. "Booking Number" is only the carrier's reference ⚑ OP-01. |
| "Vehicle" | A customer's car being shipped; a company truck; the truck on a delivery run. | **RORO Vehicle** for cargo. **Fleet Vehicle** for our trucks. |
| "Billing code", "charge code" | The same thing under two names. | **Charge Code**. |
| "Billing line" | Sometimes only charges to the customer; sometimes costs too. | **Sell Line** and **Cost Line**. |
| "Posted" | Used for invoices, bridge items, journals and checks. | **Post** always means writing to the Ledger. |
| "Company", "customer" | "Company" was sometimes used for a customer. | **Company** is us. A customer is a **Party**. |
| "Encoder" | Sometimes the operator role; sometimes anyone who types up files. | **Operator** for the role. |
| "Reviewer", "approver" | The same person under two names. | **Approver**. |
| "Returned", "for correction", "rejected" | The same status under three names. | **For Correction** for the status; **Return** for the action. |
| "Hold" | A vehicle status; a customs marker; a lien marker. | Say which: Hold status, **Customs Hold**, **Lien Release** ⚑ OP-17. |
| "Status" | Ten different lists. | Always name it: Operation Status, invoice status, and so on. |
| "Income" | The Overview's monthly figure and the Ledger's are worked out differently ⚑ AC-11. | Say which one. |

## 6. Words for the technical team only

You do not need these. They are here in case you hear them in a meeting.

| You may hear | What it means for you |
|---|---|
| Proof of work | A small puzzle your browser solves by itself before sign-in or a public lookup. It slows down automated attacks. You may notice a short pause. |
| Token, session | The pass your browser holds after you sign in, so you are not asked for your password on every click. |
| Role-based access | What you can do depends on your role. |
| Audit trail | The system's record of who changed what, and when. |
| Staging | Putting an item in the Accounting Bridge to wait for an accountant. |
| Deployment, release | Putting a new version of the system into use. |
| Backup and restore | A safe copy of the data, and the practised way of getting it back. |
| Penetration test | An independent expert tries to break in, to find weaknesses before someone else does. |
