# the Platform: Freight Operations and Accounting

The shared language of the Platform, the internal system a freight forwarder uses to take a shipment from quote and booking, through approval and movement, to billing and the general ledger. Developers, testers and stakeholders use these words, and only these words, in requirements, tickets, test cases, screens and conversation.

> **Status: proposed, 8 November 2026.** Built from SRS v0.1 and SAD v0.1. Terms marked **⚑** depend on an open question in [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) and may change when it is answered. Each term is confirmed by the owner who confirms its area (see [REQUIREMENTS-SUMMARY.md §10](REQUIREMENTS-SUMMARY.md)).

## Language

### Organisation and parties

**Company**:
The business that operates the Platform and owns its records. Every record belongs to exactly one Company.
_Avoid_: Tenant, client, customer, organisation

**Party**:
Any outside person or business in the directory that a Freight File can name, such as a Shipper, Consignee, Agent, Carrier or Trucker.
_Avoid_: Contact, account, entity

**Customer**:
A Party that buys services from the Company and can be billed.
_Avoid_: Client, account, company

**Bill-to Party** ⚑ (AC-02):
The Party an Invoice is addressed to and who owes its amount. It is not always the Shipper or Consignee.
_Avoid_: Billed party, payer, customer (when the Bill-to Party is meant specifically)

**Shipper**:
The Party sending the cargo.
_Avoid_: Sender, exporter, consignor

**Consignee**:
The Party the cargo is delivered to.
_Avoid_: Receiver, importer

**Notify Party**:
The Party to be told when the cargo arrives. They may differ from the Consignee.
_Avoid_: Notify, contact

**Agent**:
An overseas forwarder that handles the other end of a shipment on the Company's behalf.
_Avoid_: Partner, correspondent

**Carrier**:
The shipping line or airline that physically moves the cargo between ports or airports.
_Avoid_: Line, vendor, supplier (when the Carrier is meant)

**Trucker**:
An outside trucking Party hired for cartage. They are not the Company's own drivers.
_Avoid_: Hauler, subcontractor

**Consolidator**:
A Party that groups several shippers' cargo under one master air waybill.
_Avoid_: Co-loader, aggregator

**Branch** ⚑ (BO-04):
A physical office or terminal of the Company. It currently appears only on the map and is not a boundary for users or records.
_Avoid_: Office, site, location

### People and roles

**User**:
A Company staff member with a sign-in to the Platform.
_Avoid_: Account, member, login

**Role**:
The single set of permissions a User holds: Superadmin, Manager, Operator, Accountant or Viewer.
_Avoid_: Profile, group, user type

**Superadmin**:
The technical administrator Role. It can do everything, including changing other Superadmins.
_Avoid_: Admin, root, owner

**Manager**:
The Role that supervises operations and approves or returns Freight Files.
_Avoid_: Supervisor, approver (as a role name)

**Operator**:
The Role that creates, edits and submits Freight Files and handles movement records. It cannot approve.
_Avoid_: Encoder, clerk, dispatcher ⚑ (OP-04)

**Accountant**:
The Role that owns billing review, the Accounting Bridge and the Ledger. It sees Approved Freight Files only.
_Avoid_: Finance, bookkeeper

**Viewer**:
The read-only Role, for example for auditors.
_Avoid_: Read-only user, guest, auditor (as a role name)

**Submitter**:
The User who last submitted a Freight File for approval.
_Avoid_: Encoder, creator, author

**Approver**:
The User (Manager or Superadmin) who approved or returned a Freight File.
_Avoid_: Reviewer, checker, verifier

**Public Visitor**:
Anyone without a sign-in who uses the Public Lookup.
_Avoid_: Guest, anonymous user, customer

**Web Account** ⚑ (BO-05):
A Customer's record for a future customer portal, holding permission flags. It does not allow sign-in yet.
_Avoid_: Customer login, portal user, user

### Freight

**Freight File**:
The single record of one shipment job, from booking to billing. Every other record about the shipment points to it.
_Avoid_: Shipment, booking, job, file (alone, in formal documents), order

**File Number**:
The Company's own identifier for a Freight File, assigned by the system and never reused.
_Avoid_: Job number, reference, booking number

**Booking Number** ⚑ (OP-01):
The Carrier's reference for space booked on a vessel or flight.
_Avoid_: File number, booking ID, reservation number

**Mode**:
How cargo travels on a Freight File: Ocean or Air.
_Avoid_: Type, transport type, service

**Direction**:
Whether a Freight File is Export, Import or Domestic.
_Avoid_: Movement type, trade, bound

**Lane**:
An origin and destination pair that Tariffs are priced for.
_Avoid_: Route (route is reserved for Dispatch Route), trade lane, corridor

**Quote**:
A priced offer to a Customer before booking. It is Draft, Sent, Accepted, Rejected or Expired.
_Avoid_: Quotation, estimate, proposal, rate request

**Container**:
An ocean shipping box on a Freight File, identified by type, number and seal.
_Avoid_: Box, unit, equipment

**Dimension Line**:
One line of cargo measurements (pieces, length, width, height, weight) on a Freight File.
_Avoid_: Cargo line, package line, dims

**Commodity**:
A catalogued kind of goods, with an HS Code and a Dangerous Goods flag.
_Avoid_: Product, item, goods description

**HS Code**:
The Harmonized System code that classifies a Commodity.
_Avoid_: Tariff code (a Tariff is a rate here), customs code

**Dangerous Goods**:
A Commodity that needs special handling under transport rules.
_Avoid_: Hazmat, hazardous cargo, DG (in documents for non-specialists)

**Incoterm**:
The standard trade term that decides which Party pays which charges.
_Avoid_: Terms, shipping terms, delivery terms

**Revenue Weight**:
For Ocean, the greater of gross tonnes and cubic metres. It is the quantity ocean charges are rated on.
_Avoid_: W/M (outside specialist use), freight ton, billable weight

**Chargeable Weight**:
For Air, the greater of gross kilograms and volumetric weight. It is the quantity air charges are rated on.
_Avoid_: Billable weight, rated weight, revenue weight (that is Ocean)

**Volumetric Weight**:
The weight that air cargo is treated as having because of the space it takes.
_Avoid_: Dimensional weight, DIM weight, volume weight

### Air consolidation

**Consolidation**:
A Freight File in which several house air waybills travel under one master air waybill.
_Avoid_: Consol, group shipment, co-load

**MAWB**:
The master air waybill: the Carrier's contract for the whole Consolidation, one per Consolidation.
_Avoid_: Master, master bill, AWB (when the MAWB is meant)

**HAWB**:
A house air waybill: the Company's contract with one Shipper inside a Consolidation.
_Avoid_: House, house row, sub-AWB

**Air Waybill**:
The air transport document for a non-consolidated air Freight File.
_Avoid_: AWB (in non-specialist documents), airway bill

### Approval

**Operation Status**:
The approval state of a Freight File: Draft, Pending, For Correction or Approved.
_Avoid_: Status (alone), approval status, booking status, file status

**Draft**:
The Operation Status of a Freight File that has not yet been submitted. It can be edited.
_Avoid_: New, open, unsubmitted

**Pending**:
The Operation Status of a Freight File that is waiting for an approval decision. No one can edit it.
_Avoid_: Submitted, for approval, in review, locked

**For Correction**:
The Operation Status of a Freight File that the Approver sent back with a Return Note. It can be edited and resubmitted.
_Avoid_: Returned, rejected, sent back, declined

**Approved**:
The Operation Status that releases a Freight File to billing. Operators can no longer edit it.
_Avoid_: Confirmed, accepted, released, final

**Submit**:
To send a Draft or For Correction Freight File for an approval decision.
_Avoid_: Send for approval, request approval, finalise

**Return**:
To send a Pending Freight File back to For Correction with a Return Note.
_Avoid_: Reject, decline, send back

**Return Note**:
The required explanation an Approver gives when returning a Freight File.
_Avoid_: Rejection reason, comment, remark

**Self-approval** ⚑ (BO-02):
A User approving a Freight File that the same User submitted.
_Avoid_: Auto-approval, own approval

**Cancelled** ⚑ (OP-03):
A proposed Operation Status for a Freight File whose shipment will not happen. It does not exist yet.
_Avoid_: Void (void is for Invoices), deleted, killed

### Movement

**RORO Vehicle**:
A Customer's vehicle being shipped on a roll-on/roll-off vessel. It is cargo, not equipment.
_Avoid_: Vehicle (alone), car, unit, auto

**Fleet Vehicle**:
A truck or other vehicle owned or run by the Company and used for cartage and dispatch.
_Avoid_: Vehicle (alone), truck, equipment ⚑, unit

**Driver**:
A Company person assigned to drive a Fleet Vehicle.
_Avoid_: Chauffeur, trucker (a Trucker is an outside Party)

**Cartage Order**:
An order to pick up, deliver, cross-dock or exchange cargo by truck. It is Open, Assigned, In Transit, Delivered or Cancelled.
_Avoid_: P/D order, PD order, pickup order, delivery order, trucking job

**Dispatch Route**:
A planned run by one Driver in one Fleet Vehicle through a series of Stops. It is Draft, Dispatched, In Transit, Arrived or Completed.
_Avoid_: Trip, run, dispatch (as a noun), route (alone)

**Stop**:
One place a Dispatch Route visits.
_Avoid_: Drop, waypoint, leg

**Proof of Delivery**:
The signed record (signer and time) that cargo was handed over at a Stop.
_Avoid_: POD (in non-specialist documents), delivery receipt, e-signature

### Rates and charges

**Charge Code**:
A defined kind of charge (for example freight, handling or documentation), with its default rate, Ledger Account and VAT flag.
_Avoid_: Billing code, charge type, fee code, service code

**Tariff**:
A rate for a Charge Code, optionally limited to a Customer, a Lane and validity dates.
_Avoid_: Rate card, price, rate (alone), HS tariff

**Charge Package**:
A ready-made set of charge lines applied by Mode, Direction and Incoterm.
_Avoid_: Bundle, template, package

**Minimum Charge**:
The lowest sell amount a Tariff allows. A smaller calculated amount is raised to it.
_Avoid_: Floor, min rate, base charge

**Rating**:
Working out a Freight File's Sell Lines and Cost Lines from its Tariffs, Charge Packages or Accepted Quote.
_Avoid_: Pricing, costing, calculation, billing (billing is the wider process)

**Sell Line**:
A charge to the Bill-to Party on a Freight File. Sell Lines make up the Invoice.
_Avoid_: Billing line, revenue line, AR line, charge line

**Cost Line**:
An expected cost owed to a supplier for a Freight File.
_Avoid_: Buy line, cost accrual, AP line, expense line

**Manual Line**:
A Sell Line or Cost Line entered by a person. Rating never changes it.
_Avoid_: Override, custom line, ad-hoc charge

**Generated Line**:
A Sell Line or Cost Line produced by Rating, carrying the Tariff it came from.
_Avoid_: Auto line, engine line, system line

**Rate Note** ⚑ (AC-14):
Undefined in the source. An open Rate Note stops automatic posting.
_Avoid_: (until defined)

### Invoicing

**Invoice**:
The bill for a Freight File's Sell Lines to the Bill-to Party. It is Draft, Issued, Posted or Void.
_Avoid_: Bill, billing (as a noun), statement, sales invoice

**Live Invoice** ⚑ (AC-01):
The one Invoice per Freight File that is not Void.
_Avoid_: Current invoice, active invoice, open invoice

**Invoice Reference**:
The identifier an Invoice gets as a Draft (Mode code, date, daily sequence).
_Avoid_: Draft number, temporary number, invoice number

**Invoice Number**:
The identifier an Invoice gets when Issued (Mode code, year and month, monthly sequence). It never changes or repeats.
_Avoid_: Invoice reference, OR number, SI number

**Issue**:
To finalise a Draft Invoice so that it receives its Invoice Number.
_Avoid_: Release, finalise, send, approve

**Void**:
To cancel a Posted Invoice by creating a Reversal Voucher, after which the next Invoice Revision is drafted.
_Avoid_: Cancel, delete, reverse (reverse is what the Ledger does), credit

**Invoice Revision**:
A numbered version of a Freight File's Invoice. A new one is drafted after each Void.
_Avoid_: Version, re-issue, amendment

**Credit Note** ⚑ (AC-06):
A planned document that reduces an amount already invoiced. It does not exist yet.
_Avoid_: Credit memo, refund, negative invoice

**VAT Treatment**:
How VAT applies to an Invoice: 12 percent, zero-rated or exempt.
_Avoid_: Tax type, VAT code, tax status

**Document Currency** ⚑ (AC-03):
The currency an Invoice or charge is written in, such as USD or PHP.
_Avoid_: Invoice currency, foreign currency, FX

**Billing-to-Ledger Mode**:
The Company setting that decides how Invoices reach the Ledger: Manual, Review or Auto.
_Avoid_: Automation mode, posting mode, billing mode

### Accounting bridge and ledger

**Accounting Bridge**:
The only path by which billing and costs reach the Ledger. Items are staged, checked and then posted.
_Avoid_: Bridge (alone, in formal documents), integration, interface, sync

**Bridge Item**:
One Invoice or cost amount waiting in the Accounting Bridge. It is Staged, Trial Verified or Posted.
_Avoid_: Queue item, staging row, posting item, entry

**Stage**:
To place a Bridge Item in the Accounting Bridge, once only.
_Avoid_: Queue, send to accounting, export

**Trial Post**:
To build a Bridge Item's Journal and check that it balances, without writing it to the Ledger.
_Avoid_: Test post, dry run, preview, validate

**Post**:
To write a balanced Journal to the Ledger. "Posted" on an Invoice or Bridge Item means its Journal has been posted.
_Avoid_: Book, record, commit, save (for Ledger writes)

**Ledger**:
The Company's general ledger of Accounts, Journals and Periods.
_Avoid_: FS, GL, books, accounting module

**Chart of Accounts**:
The Company's tree of Ledger Accounts (account, sub-account, subsidiary).
_Avoid_: COA, account list

**Ledger Account**:
One node in the Chart of Accounts that Journals post to.
_Avoid_: GL account, account (alone, because a User sign-in is not an account), code

**Charge Code Mapping**:
The link from each Charge Code to the Ledger Account it posts to. An unmapped Charge Code cannot be posted.
_Avoid_: Account mapping, GL mapping

**Journal**:
A balanced set of debit and credit lines in the Ledger. Its types are CDV, JE, AJE, AR and AP.
_Avoid_: Entry, transaction, journal voucher

**Voucher**:
The numbered accounting document behind a Journal, such as a sales invoice, receipt or Reversal Voucher.
_Avoid_: Slip, document, ticket

**Reversal Voucher**:
A Voucher that undoes a Posted Invoice's Vouchers when the Invoice is Voided.
_Avoid_: Reversing entry, contra, credit note

**Check Disbursement** ⚑ (DOC-09):
A recorded payment by check, with its own status (Draft, Printed, Posted, Void).
_Avoid_: Cheque, payment, CDV (see Flagged ambiguities)

**Period**:
One accounting month of the Ledger. It is Open or Closed.
_Avoid_: Fiscal period, month (alone), accounting period

**Month-end Close**:
The act of closing the Open Period and creating its closing entries. A Closed Period accepts no new or re-dated Journals.
_Avoid_: Period end, closing, lock month

### Tracking

**Tracking Item**:
The record that carries Milestones for a Freight File, Cartage Order or RORO Vehicle.
_Avoid_: Tracker, tracking record, shipment status

**Milestone**:
A dated status update on a Tracking Item, with location and note.
_Avoid_: Event, status update, checkpoint, tracking event

**Public Lookup**:
The page where a Public Visitor enters a reference and sees tracking status, without signing in.
_Avoid_: Public tracking, track and trace, customer tracking, portal

**Arrival Notice**:
The document telling the Consignee that cargo has arrived, one per HAWB in a Consolidation.
_Avoid_: AN, arrival advice, notice of arrival

## Relationships

- A **Company** owns every **Freight File**, **Party**, **Invoice** and the **Ledger**.
- A **Freight File** has one **Mode** and one **Direction**. It names a **Shipper**, a **Consignee** and a **Bill-to Party**.
- An **Accepted** **Quote** can become one **Freight File**, or be linked to one.
- A **Consolidation** is a **Freight File** with one **MAWB** and many **HAWBs**. Each **HAWB** has its own **Shipper** and **Consignee**.
- A **Freight File** must be **Approved** before **Rating** produces billable **Sell Lines** and **Cost Lines**.
- A **Freight File** has at most one **Live Invoice** ⚑ (AC-01). Each **Void** produces a new **Invoice Revision**.
- An **Invoice** reaches the **Ledger** only as **Bridge Items** that are **Staged**, **Trial Posted** and **Posted** through the **Accounting Bridge**.
- Each **Charge Code** maps to one **Ledger Account** through the **Charge Code Mapping**.
- A **Cartage Order**, a **RORO Vehicle** and a **Tracking Item** may each point to a **Freight File**.
- A **Dispatch Route** has one **Driver**, one **Fleet Vehicle** and many **Stops**.

## Example dialogue

> **Operator:** "I've submitted file OE-0142. It's Pending now, so I can't touch it."
> **Manager:** "I've returned it For Correction. The Return Note says the Consignee is missing."
> **Operator:** "Fixed and resubmitted. Once it's Approved, Rating will produce the Sell Lines."
> **Accountant:** "Its Bridge Items are Staged. I'll Trial Post them first, then Post. The freight Charge Code is unmapped, so that item will be refused until the Charge Code Mapping is set."

## Flagged ambiguities

- **"Shipment" / "booking" / "file"** were all used for the same record. Resolved to **Freight File**. "Booking Number" is now only the Carrier's reference ⚑ (OP-01).
- **"Vehicle"** meant three things: a customer's car being shipped, a Company truck, and the vehicle on a Dispatch Route. Resolved to **RORO Vehicle** and **Fleet Vehicle**. "Equipment" on a Cartage Order may mean a Fleet Vehicle or something else ⚑ (OP-04).
- **"Billing code" vs "charge code"** were used for the same concept. Resolved to **Charge Code**.
- **"Billing line"** sometimes meant sell lines only and sometimes all lines. Resolved to **Sell Line** and **Cost Line**.
- **"Posted"** applies to Invoices, Bridge Items, Journals and Check Disbursements. Resolved: **Post** means writing to the Ledger, and the status means "its Journal has been posted".
- **"Company" vs "customer"**: Company is the Platform's operator and is never a customer. Customers are **Parties**.
- **CDV**: the SRS acronym table says "check disbursement voucher", but FR-FS-02 says "cash disbursement voucher". Which one is meant? ⚑ (DOC-09)
- **"Encoder"** is used in the SAD for both the Operator role and, in SAD §3.3, for operator, manager and superadmin together. Resolved: use **Operator** for the Role. Anyone who creates Freight Files is described by their Role.
- **"Reviewer" vs "approver"**: the SAD says the system records the "reviewer". Resolved to **Approver**.
- **"Rate note"**, **"billing review"** and **"live invoice"** are used but not defined ⚑ (AC-14, DOC-09).
- **"Status"** is used for ten different lists. Always name it: Operation Status, Invoice status, Cartage Order status, and so on.
