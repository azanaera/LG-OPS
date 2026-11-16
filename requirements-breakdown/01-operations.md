# Requirements Breakdown 1: Operations

**Confirmed by:** Operations lead · **Covers:** FR-OV, FR-AP, FR-SH, FR-VH, FR-PD, FR-FD, FR-TR, FR-PT, FR-MP (42 requirements) · **Method:** [README.md](README.md)

> Every statement below describes what the system **currently does** according to SRS v0.1 and SAD v0.1. Every worked example is **to be confirmed by the Operations lead**. Nothing here is agreed until its "Confirmed" box is ticked and the answer is in [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md).

---

## Operations overview (FR-OV)

### FR-OV-01 Overview after sign-in
**Source (SRS, verbatim):** "The system shall show after sign-in a draggable overview with counts of files, vehicles on hold, open cartage, active dispatches and staged bridge items, a to-do list, and each count opening its module."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-OV-01.1 | After sign-in the Overview is the first page shown. | Any User | ☐ |
| FR-OV-01.2 | The Overview shows a count of Freight Files, RORO Vehicles on Hold, open Cartage Orders, active Dispatch Routes and Staged Bridge Items. | (system) | ☐ |
| FR-OV-01.3 | Each count is taken from the Company's live records. No sample numbers are shown. | (system) | ☐ |
| FR-OV-01.4 | Selecting a count opens the module it counts. | Any User | ☐ |
| FR-OV-01.5 | The User can drag the widgets to rearrange them. | Any User | ☐ |
| FR-OV-01.6 | The Overview shows a to-do list. | (system) | ☐ |

**Worked examples**
- *Given* 3 RORO Vehicles are on Hold, *when* an Operator signs in, *then* the "vehicles on hold" count shows 3, and selecting it opens the vehicle list.
- *Given* a Company with no records, *when* a User signs in, *then* every count shows 0, not a sample number.

**Not stated — ask:** what the to-do list contains for each Role, and whether it is how approvers learn a file is waiting (OP-16). Whether an Operator, who has no Ledger access, sees the Staged Bridge Item count. The SAD mentions twelve widgets; the SRS names five counts. The monthly income widget and which figure is official (AC-11). Whether a rearranged layout is remembered.

### FR-OV-02 Workspace for each Role
**Source (SRS, verbatim):** "The system shall show a workspace for each role."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-OV-02.1 | Each of the five Roles (Superadmin, Manager, Operator, Accountant, Viewer) sees a workspace made for that Role. | (system) | ☐ |

**Worked examples**
- *Given* an Accountant signs in, *then* the workspace shows billing, Accounting Bridge and Ledger work. *(Assumed from the Role table — confirm.)*
- *Given* an Operator signs in, *then* the workspace shows no Ledger functions. *(Assumed from the Role table — confirm.)*

**Not stated — ask:** the content of each workspace is not listed anywhere. Ask Engineering for the list per Role (TL-10), then confirm it with each owner.

---

## Operation approval (FR-AP)

### FR-AP-01 Create and edit a Freight File
**Source (SRS, verbatim):** "The system shall let operator, manager and superadmin users create files in draft and edit them while they are draft or for correction; other roles shall not create files."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-01.1 | A new Freight File is created with Operation Status Draft. | Operator, Manager, Superadmin | ☐ |
| FR-AP-01.2 | A Freight File in Draft or For Correction can be edited. | Operator, Manager, Superadmin | ☐ |
| FR-AP-01.3 | A create request is refused. | Accountant, Viewer | ☐ |

**Worked examples**
- *Given* an Operator, *when* they save a new file, *then* it exists as Draft under the Operator's Company.
- *Given* an Accountant, *when* they try to create a file, *then* the request is refused.

**Not stated — ask:** Operators can edit each other's Draft files; who accepted this (OP-05). Whether a Draft can be deleted, and by whom (BO-14).
**Engineering check:** route tests (viewer and accountant create attempts refused).

### FR-AP-02 Submit a Freight File for approval
**Source (SRS, verbatim):** "The system shall move a draft or returned file to pending on submit, after checking the required fields (shipper, consignee, bill-to, origin, destination, dates, cargo), and record the revision and the submitter."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-02.1 | A Freight File in Draft or For Correction can be submitted. | Operator, Manager, Superadmin | ☐ |
| FR-AP-02.2 | Submit is refused unless Shipper, Consignee, Bill-to Party, origin, destination, dates and cargo are filled. | (system) | ☐ |
| FR-AP-02.3 | On Submit the Operation Status becomes Pending. | (system) | ☐ |
| FR-AP-02.4 | On Submit the revision number increases by one, and the Submitter and time are recorded as an event. | (system) | ☐ |

**Worked examples**
- *Given* a Draft file with no Consignee, *when* the Operator submits, *then* it stays Draft. *(Whether the message names the missing field is not stated — ask.)*
- *Given* a For Correction file at revision 1 with all required fields filled, *when* the Operator submits, *then* it is Pending at revision 2.

**Not stated — ask:** which dates and which cargo fields are required, and whether they differ by Mode (OP-15). Whether the refusal names each missing field. How the Approver learns a file is Pending (OP-16).
**Engineering check:** check:opstatus.

### FR-AP-03 A Pending file is locked
**Source (SRS, verbatim):** "The system shall lock a pending file for every user, including its submitter, until it is approved or returned."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-03 | An edit to a Pending Freight File is refused for every Role, including the Submitter. | Any User | ☐ |

**Worked examples**
- *Given* a Pending file, *when* a Superadmin tries to change its weight, *then* the change is refused.
- *Given* the same file is returned, *when* the Operator edits it, *then* the edit is saved.

**Not stated — ask:** whether a Submitter can withdraw a file submitted by mistake. Whether attachments or Milestones can be added while it is Pending.

### FR-AP-04 Approve a Pending file
**Source (SRS, verbatim):** "The system shall let a manager or superadmin approve a pending file, moving it to approved and recording the reviewer."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-04.1 | A Pending Freight File can be approved; its Operation Status becomes Approved. | Manager, Superadmin | ☐ |
| FR-AP-04.2 | The Approver and the time are recorded as an event. | (system) | ☐ |
| FR-AP-04.3 | An approve request is refused. | Operator, Accountant, Viewer | ☐ |
| FR-AP-04.4 | Approval releases the file to billing (SAD §9.1). | (system) | ☐ |

**Worked examples**
- *Given* a Pending file, *when* a Manager approves it, *then* it is Approved and the history shows the Manager and the time.
- *Given* a Pending file, *when* an Operator tries to approve it, *then* the request is refused.
- *Given* a Draft file, *when* a Manager tries to approve it without a Submit, *then* the request is refused. *(Assumed from the status rules — confirm.)*

**Not stated — ask:** Self-approval ⚑ (BO-02). How quickly a decision is due and who covers for an absent Approver (OP-12).

### FR-AP-05 Return a Pending file
**Source (SRS, verbatim):** "The system shall let a manager or superadmin return a pending file with a required note and an optional image, moving it to for correction; a resubmit returns it to pending."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-05.1 | A Pending Freight File can be returned; its Operation Status becomes For Correction. | Manager, Superadmin | ☐ |
| FR-AP-05.2 | A Return without a Return Note is refused. | (system) | ☐ |
| FR-AP-05.3 | An image may be attached to the Return. | Manager, Superadmin | ☐ |
| FR-AP-05.4 | The Return Note and image are shown to the Operator on the file. | (system) | ☐ |
| FR-AP-05.5 | Submitting a For Correction file makes it Pending again. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a Pending file, *when* a Manager returns it with the note "Consignee address missing", *then* it is For Correction and the Operator sees the note.
- *Given* a Pending file, *when* a Manager returns it with an empty note, *then* the Return is refused and the file stays Pending.

**Not stated — ask:** how the Operator learns the file came back (OP-16). Whether any Operator, or only the Submitter, may correct it (OP-05).

### FR-AP-06 Approved files: locks and visibility
**Source (SRS, verbatim):** "The system shall lock an approved file for operators, let accountants see approved files only, and refuse any generic write to approval fields."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-06.1 | An edit to an Approved Freight File is refused. | Operator | ☐ |
| FR-AP-06.2 | Lists and searches return Approved Freight Files only. | Accountant | ☐ |
| FR-AP-06.3 | The approval fields change only through Submit, Approve and Return, never through an ordinary save. | (system) | ☐ |
| FR-AP-06.4 | A file whose Operation Status is empty or unknown is treated as Pending (SAD §8.4). | (system) | ☐ |

**Worked examples**
- *Given* files OE-0140 (Draft), OE-0141 (Pending) and OE-0142 (Approved), *when* an Accountant opens the file list, *then* only OE-0142 is shown. *(File numbers are illustrative.)*
- *Given* an Approved file, *when* an Operator tries to change the Consignee, *then* the change is refused.

**Not stated — ask:** a Manager or Superadmin can still edit an Approved file and the billing is re-rated with no second approval (OP-02). Whether an Accountant can edit an Approved file (AC-16, DOC-01). Files created before the approval step count as Approved (OP-18). There is no way to cancel an Approved file (OP-03).
**Engineering check:** check:opstatus.

### FR-AP-07 Block Self-approval
**Source (SRS, verbatim):** "The system shall prevent a user from approving a file that the same user submitted."
**Priority / Status:** Should / Planned · **Owner:** Operations lead (decision: Business owner) · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-07 | *(Cannot be refined until the rule is chosen: block, or require a second Approver.)* | Manager, Superadmin | ☐ |

**Worked examples** *(for the proposed rule only)*
- *Given* a Manager submitted a file, *when* the same Manager tries to approve it, *then* the approval is refused.
- *Given* a Manager submitted a file, *when* a different Manager approves it, *then* it is Approved.

**Not stated — ask:** the rule itself and what a one-person office does (BO-02). The priority is Should although the risk is rated High (DOC-02).

---

## Freight Files (FR-SH)

### FR-SH-01 Create ocean and air files
**Source (SRS, verbatim):** "The system shall create ocean and air files for export, import and domestic direction, with a file number generated by the system."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-01.1 | A Freight File has one Mode: Ocean or Air. | Operator, Manager, Superadmin | ☐ |
| FR-SH-01.2 | A Freight File has one Direction: Export, Import or Domestic. | Operator, Manager, Superadmin | ☐ |
| FR-SH-01.3 | The system gives each new file a File Number that no other file has. | (system) | ☐ |
| FR-SH-01.4 | The File Number's prefix comes from the Mode and Direction (SAD §3.2). | (system) | ☐ |

**Worked examples**
- *Given* an Operator saves a new Ocean Export file, *then* it receives a File Number with the Ocean Export prefix, different from every other file.
- *Given* a file is created through the API and not the form, *then* it receives a generic number without the prefix. *(Known limitation 11.)*

**Not stated — ask:** what a Domestic file is (OP-13). The list of prefixes — ask Engineering for one real example per Mode and Direction (TL-10). Whether files will ever be imported (OP-08).

### FR-SH-02 Parties and routing
**Source (SRS, verbatim):** "The system shall record shipper, consignee, notify party, ports or airports, carrier, vessel or flight and voyage."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-02 | A Freight File records its Shipper, Consignee, Notify Party, ports or airports, Carrier, vessel or flight, and voyage. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a file saved with all of these filled, *when* it is reopened, *then* every value is unchanged.
- *Given* a file with no Notify Party, *when* it is saved as Draft, *then* it saves. *(Assumed: Notify Party is not in the required list — confirm.)*

**Not stated — ask:** which of these are required at Submit (OP-15). Whether the Booking Number ⚑ is the Carrier's reference (OP-01).

### FR-SH-03 Containers and Dimension Lines
**Source (SRS, verbatim):** "The system shall record containers (type, number, seal) and cargo dimension lines."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-03 | A Freight File records its Containers (type, number, seal) and its Dimension Lines, and keeps their order. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* three Dimension Lines entered in order A, B, C, *when* the file is saved and reopened, *then* they are shown as A, B, C.
- *Given* a container weight above its limit, *then* the form shows a warning (SAD §7.2).

**Not stated — ask:** whether the container number format is checked. Whether a warning stops the save. Whether verified gross mass is recorded (the SAD glossary defines it; no requirement uses it).

### FR-SH-04 Ocean Revenue Weight
**Source (SRS, verbatim):** "For ocean files the system shall compute revenue weight as the larger of gross tonnes and cubic metres."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-04 | On an Ocean file the Revenue Weight is the greater of the gross weight in tonnes and the volume in cubic metres. | (system) | ☐ |

**Worked examples**
- *Given* 3.2 tonnes and 5.0 cubic metres, *then* the Revenue Weight is **5.0**.
- *Given* 8.0 tonnes and 5.0 cubic metres, *then* the Revenue Weight is **8.0**.

**Not stated — ask:** rounding, and whether it applies to full-container cargo or only to loose cargo.
**Engineering check:** check:billing.

### FR-SH-05 Air Chargeable Weight
**Source (SRS, verbatim):** "For air files the system shall compute chargeable weight as the larger of gross kilograms and volumetric weight (length times width times height divided by 6000 per piece), rounded by the carrier rule."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-05.1 | The Volumetric Weight of one piece is length × width × height ÷ 6000. | (system) | ☐ |
| FR-SH-05.2 | On an Air file the Chargeable Weight is the greater of the gross weight in kilograms and the Volumetric Weight. | (system) | ☐ |
| FR-SH-05.3 | By default the result is rounded up to the next half kilogram (SAD §7.2). | (system) | ☐ |

**Worked examples**
- *Given* 2 pieces of 100 × 50 × 40 cm with a gross weight of 30 kg, *then* the Volumetric Weight is 2 × (200,000 ÷ 6000) = 66.67 kg, rounded up to 67.0 kg, and the Chargeable Weight is **67.0 kg**.
- *Given* the same 2 pieces with a gross weight of 80 kg, *then* the Chargeable Weight is **80.0 kg**.

**Not stated — ask:** the unit of the dimensions (centimetres assumed). Whether rounding is done per piece or on the total (TL-10). Which Carriers use a rule other than the default.
**Engineering check:** check:air-booking.

### FR-SH-06 VAT on taxable lines
**Source (SRS, verbatim):** "The system shall apply 12 percent VAT to taxable billing lines, and each invoice shall carry VAT treatment 12 percent, zero or exempt."
**Priority / Status:** Must / Built · **Owner:** Operations lead in the SRS; the rule belongs to the Accounting lead (DOC-10) · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-06.1 | VAT of 12 percent is added to each Sell Line whose Charge Code is taxable. | (system) | ☐ |
| FR-SH-06.2 | Each Invoice carries one VAT Treatment: 12 percent, zero-rated or exempt. | (system) | ☐ |

**Worked examples** — see [02-accounting.md](02-accounting.md), where this rule is confirmed with the billing requirements.

**Not stated — ask:** when each VAT Treatment applies and who chooses it (AC-04).
**Engineering check:** check:invoice.

### FR-SH-07 Link an Accepted Quote
**Source (SRS, verbatim):** "The system shall let an accepted quote be linked to a file so that its lines replace tariff sell lines."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-07.1 | A Quote with status Accepted can be linked to a Freight File. | Operator, Manager, Superadmin | ☐ |
| FR-SH-07.2 | A Quote that is not Accepted cannot be linked. *(Assumed — confirm.)* | (system) | ☐ |
| FR-SH-07.3 | When a Quote is linked, Rating uses the Quote's lines as the Sell Lines in place of Tariff Sell Lines. | (system) | ☐ |

**Worked examples**
- *Given* a file whose Tariff gives freight of 95.00 and a linked Accepted Quote with freight of 85.00, *then* the Sell Line is 85.00.
- *Given* a Quote with status Sent, *when* an Operator tries to link it, *then* the link is refused. *(Assumed — confirm.)*

**Not stated — ask:** who marks a Quote Accepted and what proves it (OP-14). Whether Cost Lines are still taken from Tariffs. Whether a Quote can be linked after approval.
**Engineering check:** check:billing.

### FR-SH-08 Form aids
**Source (SRS, verbatim):** "The form shall suggest ports and airports from the party country, default the currency to USD with 20 or more currencies, prefill commodities, and warn on duplicate booking and master numbers."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-08.1 | The form suggests ports and airports in the Party's country. | (system) | ☐ |
| FR-SH-08.2 | The currency defaults to USD and can be changed to any of 20 or more currencies. | Operator, Manager, Superadmin | ☐ |
| FR-SH-08.3 | The form fills in Commodity details from the catalogue. | (system) | ☐ |
| FR-SH-08.4 | The form warns when the Booking Number or master number is already used on another file. | (system) | ☐ |

**Worked examples**
- *Given* master number 123-45678901 is already on another file, *when* an Operator types it on a new file, *then* a warning is shown. *(Number is illustrative.)*
- *Given* a new file, *then* the currency shows USD until the Operator changes it.

**Not stated — ask:** whether a duplicate only warns or blocks the save. Which Party's country drives the suggestion. Whether a Domestic file should default to PHP.
**Engineering check:** check:air-forms, check:validation.

### FR-SH-09 Printed documents
**Source (SRS, verbatim):** "The system shall print bill of lading or air waybill, packing list, commercial invoice, manifest, export declaration and arrival notice from the file, with branded layouts."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-09.1 | Each of these can be printed from a Freight File: bill of lading (Ocean) or Air Waybill (Air), packing list, commercial invoice, manifest, export declaration, Arrival Notice. | Operator, Manager, Superadmin | ☐ |
| FR-SH-09.2 | Each document takes its content from the file and uses the Company's branded layout. | (system) | ☐ |

**Worked examples**
- *Given* an Ocean file, *when* the Operator prints the bill of lading, *then* the Shipper, Consignee, ports and Containers match the file.
- *Given* an Air file, *then* a bill of lading is not offered. *(Assumed — confirm.)*

**Not stated — ask:** which documents must follow a legal or Carrier format, and whether the Company issues its own house bills (OP-07). The SAD also lists a house bill of lading (DOC-07). Whether a Draft or Pending file can be printed. Arrival Notice email (OP-09).

### FR-SH-10 Consolidation: many HAWBs under one MAWB
**Source (SRS, verbatim):** "The system shall let one master air waybill (MAWB) carry many house air waybills (HAWB), entered as rows on one screen (for example 5 or 40 rows)."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-10 | On a Consolidation, HAWBs are entered as rows on one screen under the MAWB. Each row holds the HAWB number, Shipper, Consignee, Notify Party, pieces, gross weight, dimensions and Chargeable Weight (SAD §7.3). | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a MAWB with 5 HAWB rows, *when* it is saved and reopened, *then* all 5 rows are unchanged.
- *Given* a MAWB with 40 HAWB rows, *then* it saves in the same way.

**Not stated — ask:** the largest number of rows the business needs. Whether a HAWB row can be added after approval (OP-02).
**Engineering check:** check:air-booking.

### FR-SH-11 Consolidation roll-up
**Source (SRS, verbatim):** "The system shall roll up pieces and gross weight of HAWB rows to the MAWB, and set the MAWB chargeable weight to the greater of total gross and total volumetric weight."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-11.1 | The MAWB's pieces and gross weight are the totals of its HAWB rows. | (system) | ☐ |
| FR-SH-11.2 | The MAWB Chargeable Weight is the greater of the total gross weight and the total Volumetric Weight. It is not the sum of the HAWB Chargeable Weights (SAD §7.3). | (system) | ☐ |

**Worked examples**
- *Given* HAWB A (gross 100 kg, volumetric 60 kg) and HAWB B (gross 40 kg, volumetric 90 kg), *then* the MAWB gross weight is 140 kg, the total Volumetric Weight is 150 kg, and the MAWB Chargeable Weight is **150 kg**.
- *In the same case* the HAWB Chargeable Weights are 100 kg and 90 kg. Their sum, 190 kg, is **not** used for the MAWB.

**Not stated — ask:** whether each house Customer is charged on their own HAWB Chargeable Weight while the Carrier charges the Company on the MAWB weight (AC-01).
**Engineering check:** check:air-booking roll-up cases.

### FR-SH-12 Consolidation documents
**Source (SRS, verbatim):** "The system shall produce the consolidation manifest, MAWB, HAWB and an arrival notice per HAWB from the rows; duplicate HAWB numbers shall be flagged."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-SH-12.1 | The consolidation manifest, the MAWB and each HAWB can be printed from the rows. | Operator, Manager, Superadmin | ☐ |
| FR-SH-12.2 | One Arrival Notice is produced for each HAWB. | (system) | ☐ |
| FR-SH-12.3 | A HAWB number used twice is flagged. | (system) | ☐ |

**Worked examples**
- *Given* a MAWB with 5 HAWB rows, *then* 5 Arrival Notices can be printed, each naming its own Consignee.
- *Given* two rows with HAWB number H-1001, *then* the duplicate is flagged. *(Number is illustrative.)*

**Not stated — ask:** the Invoice for a Consolidation repeats the MAWB number as the house number; what it should show depends on how a Consolidation is billed (AC-01, OP-11). Whether a flagged duplicate blocks the save.
**Engineering check:** check:air-forms.

---

## RORO Vehicles (FR-VH)

### FR-VH-01 Record a RORO Vehicle
**Source (SRS, verbatim):** "The system shall record each vehicle with identification number, year, make, model, colour, shipper, consignee, ports, booking number, location and condition."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-VH-01 | A RORO Vehicle records its identification number, year, make, model, colour, Shipper, Consignee, ports, Booking Number, location and condition. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a RORO Vehicle saved with all fields, *when* it is reopened, *then* every value is unchanged.
- *Given* a Viewer, *when* they try to save a RORO Vehicle, *then* the request is refused.

**Not stated — ask:** whether a RORO Vehicle must belong to a Freight File, and how its shipping is billed (AC-17). What "booking number" means here (OP-01). Whether the same identification number can be entered twice.

### FR-VH-02 RORO Vehicle status and history
**Source (SRS, verbatim):** "The system shall move a vehicle through Expected, Received, Ready to Ship, Pre-Loaded, Loaded, Shipped or Hold, recording each change in history."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-VH-02.1 | A RORO Vehicle has one status: Expected, Received, Ready to Ship, Pre-Loaded, Loaded, Shipped or Hold. | Operator, Manager, Superadmin | ☐ |
| FR-VH-02.2 | Every status change is kept in the vehicle's history. | (system) | ☐ |

**Worked examples**
- *Given* a vehicle moved Expected → Received → Hold, *then* its history shows both changes in order.
- *Given* a vehicle on Hold, *when* an Operator sets it to Loaded — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** which moves are allowed, for example whether a vehicle can go back a step. Who may place and release a Hold, and whether the history records who and when (OP-17).

### FR-VH-03 Title, holds and number decode
**Source (SRS, verbatim):** "The system shall record title status (Pending, Received, Missing), customs hold and lien release flags, and may decode a US-format VIN through a public service."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-VH-03.1 | A RORO Vehicle has a title status: Pending, Received or Missing. | Operator, Manager, Superadmin | ☐ |
| FR-VH-03.2 | A RORO Vehicle has a customs hold flag and a lien release flag, and the list can be filtered by them. | Operator, Manager, Superadmin | ☐ |
| FR-VH-03.3 | A US-format vehicle identification number can be decoded to fill in vehicle details. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* 2 vehicles with the customs hold flag set, *when* the list is filtered by customs hold, *then* those 2 are shown.
- *Given* a number that is not in US format, *when* decode is used, *then* nothing is filled in and the Operator types the details. *(Known limitation 6.)*

**Not stated — ask:** how the customs hold flag, the lien release flag and the Hold status relate, and whether any of them stops a vehicle being set to Loaded or Shipped (OP-17). "May decode" is not a testable requirement.

---

## Cartage (FR-PD)

### FR-PD-01 Create a Cartage Order
**Source (SRS, verbatim):** "The system shall create cartage orders of type Pickup, Delivery, cross-dock or exchange, with an order number, addresses, schedule and cargo items."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-PD-01 | A Cartage Order has a type (pickup, delivery, cross-dock or exchange), an order number that no other order has, addresses, a schedule and cargo items. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* an Operator saves a new delivery order, *then* it receives its own order number.
- *Given* an Accountant, *when* they try to create a Cartage Order, *then* the request is refused. *(Assumed from the Role table — confirm.)*

**Not stated — ask:** what an "exchange" order is in the business's words. Whether cartage for a Customer with no Freight File can be billed (AC-17, OP-13).

### FR-PD-02 Assign Driver and equipment
**Source (SRS, verbatim):** "The system shall assign a driver and equipment to a cartage order."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-PD-02.1 | A Driver can be assigned to a Cartage Order; the assignment shows on the order and on the Driver. | Operator, Manager, Superadmin | ☐ |
| FR-PD-02.2 | Equipment can be assigned to a Cartage Order. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* an Open order, *when* a Driver is assigned, *then* the order shows the Driver and the Driver's record shows the order.
- *Given* a Driver who is Off Duty, *when* they are assigned — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** what "equipment" means: a Fleet Vehicle or something else (OP-04). Whether an outside Trucker can be assigned. Whether assigning changes the order to Assigned and the Driver to On Trip. Whether a dispatcher needs different rights from an Operator (OP-04).

### FR-PD-03 Cartage Order status and link
**Source (SRS, verbatim):** "The system shall move a cartage order through Open, Assigned, In Transit, Delivered or Cancelled, and link it to a freight file."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-PD-03.1 | A Cartage Order has one status: Open, Assigned, In Transit, Delivered or Cancelled. | Operator, Manager, Superadmin | ☐ |
| FR-PD-03.2 | A Cartage Order can be linked to a Freight File, and the link shows on both. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* an order linked to a Freight File, *then* the file shows the order and its status.
- *Given* a Delivered order, *when* an Operator sets it to Cancelled — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** which status moves are allowed. Whether cancelling needs a reason. How a Cartage Order is charged to the Customer (AC-17).

---

## Fleet, Drivers and dispatch (FR-FD)

### FR-FD-01 Fleet registry
**Source (SRS, verbatim):** "The system shall maintain a fleet registry with status Available, In Use or Maintenance."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FD-01 | Each Fleet Vehicle is kept in a registry with a status of Available, In Use or Maintenance, and the list can be filtered by status. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* 2 of 6 Fleet Vehicles are in Maintenance, *when* the list is filtered by Maintenance, *then* those 2 are shown.
- *Given* a Fleet Vehicle in Maintenance, *when* it is put on a Dispatch Route — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** whether the status changes by itself when a Dispatch Route starts and ends, or is set by hand.

### FR-FD-02 Driver registry
**Source (SRS, verbatim):** "The system shall maintain a driver registry with status Available, On Trip or Off Duty."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FD-02 | Each Driver is kept in a registry with a status of Available, On Trip or Off Duty, and the list can be filtered by status. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* 3 Drivers are On Trip, *when* the list is filtered by On Trip, *then* those 3 are shown.
- *Given* a Driver who is On Trip, *when* they are put on a second Dispatch Route — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** whether the status changes by itself. Whether licence details and expiry are needed.

### FR-FD-03 Dispatch Routes
**Source (SRS, verbatim):** "The system shall create dispatch routes with driver, vehicle, stops and cargo reference, and move each through Draft, Dispatched, In Transit, Arrived and Completed."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FD-03.1 | A Dispatch Route has one Driver, one Fleet Vehicle, one or more Stops and a cargo reference. | Operator, Manager, Superadmin | ☐ |
| FR-FD-03.2 | A Dispatch Route moves through Draft, Dispatched, In Transit, Arrived and Completed. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a new route with a Driver, a Fleet Vehicle and 3 Stops, *then* it is saved as Draft and can be moved through each stage to Completed.
- *Given* a route with no Driver, *when* it is set to Dispatched — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** what the cargo reference points to (a Freight File, a Cartage Order, or free text). Whether a stage can be skipped or reversed. Whether a route can be cancelled; there is no Cancelled stage. Whether "Draft" here causes confusion with the Draft Operation Status.

### FR-FD-04 Proof of Delivery signature
**Source (SRS, verbatim):** "The system shall capture a proof-of-delivery signature with signer and time, only when the signature device connector is connected."
**Priority / Status:** Should / Partial · **Owner:** Operations lead · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-FD-04.1 | When a signature pad is connected, a Proof of Delivery signature can be captured with the signer's name and the time. | Operator, Manager, Superadmin | ☐ |
| FR-FD-04.2 | When no signature pad is connected, signature capture is switched off. | (system) | ☐ |

**Worked examples**
- *Given* no signature pad is connected (the case today), *then* the capture control is switched off.
- *Given* a connected pad — cannot be tested: no connector exists.

**Not stated — ask:** whether a paper proof, or a photo of it attached to the route, is acceptable until pads are connected (OP-10). Whether a proof is needed per Stop or per route.

---

## Tracking and Customer accounts (FR-TR)

### FR-TR-01 Tracking Items
**Source (SRS, verbatim):** "The system shall create a tracking item linked to a freight file, a cartage order or a vehicle, with a reference number."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-TR-01 | A Tracking Item has a reference number and is linked to one Freight File, Cartage Order or RORO Vehicle; the link shows on that record. | Operator, Manager, Superadmin | ☐ |

**Worked examples**
- *Given* a Tracking Item created for a Freight File, *then* the file shows the link.
- *Given* a Viewer, *when* they try to create a Tracking Item, *then* the request is refused.

**Not stated — ask:** whether a Tracking Item is created automatically with each file or by hand. Whether tracking starts before the file is Approved.

### FR-TR-02 Milestones
**Source (SRS, verbatim):** "The system shall let staff record milestones with status, location, note and date and time, shown in time order."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-TR-02.1 | A Milestone with a status, location, note, date and time can be added to a Tracking Item. | Operator, Manager, Superadmin *(the SRS says "staff")* | ☐ |
| FR-TR-02.2 | Milestones are shown in time order. | (system) | ☐ |

**Worked examples**
- *Given* Milestones entered for 3 November, then 1 November, then 2 November, *then* they are shown as 1, 2, 3 November.
- *Given* a Milestone dated in the future — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** who enters Milestones and how soon after the event (OP-06). The list of Milestone statuses. Whether a wrong Milestone can be corrected or removed, since the public can see it. The Milestone entry screens were not tested in the rehearsal (TL-07).
**Engineering check:** check:tracking.

### FR-TR-03 Customer Web Accounts
**Source (SRS, verbatim):** "The system shall manage customer web accounts with username, email and permission flags for tracking, POD download, document upload and invoice view."
**Priority / Status:** Should / Built · **Owner:** Operations lead (decision: Business owner) · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-TR-03 | A Web Account ⚑ record holds a username, an email and four permission flags: tracking, Proof of Delivery download, document upload and Invoice view. | *(Role not named)* | ☐ |

**Worked examples**
- *Given* a Web Account saved with the tracking flag on, *when* it is reopened, *then* the flag is still on.
- *Given* that Web Account, *when* the Customer tries to sign in, *then* they cannot: no Customer sign-in exists.

**Not stated — ask:** the flags do nothing until a portal exists; keep or hide them (BO-05). Which Role manages Web Accounts.

### FR-TR-04 Customer portal sign-in
**Source (SRS, verbatim):** "The system shall let a customer sign in to a portal and see only the customer's own files."
**Priority / Status:** Should / Planned · **Owner:** Operations lead (decision: Business owner) · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-TR-04 | *(Not built. Cannot be refined until the Business owner decides whether a portal is needed, and when.)* | Customer | ☐ |

**Worked examples** *(for discussion only)*
- *Given* Customer A signs in, *then* they see Customer A's files.
- *Given* Customer A signs in, *then* they cannot see Customer B's files.

**Not stated — ask:** needed at go-live or later (BO-05). What makes a file "the customer's own": being its Shipper, Consignee or Bill-to Party.

### FR-TR-05 Customer portal content
**Source (SRS, verbatim):** "The customer portal shall show the customer's documents, arrival notices and invoices."
**Priority / Status:** Could / Planned · **Owner:** Operations lead (decision: Business owner) · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-TR-05 | *(Not built. Depends on FR-TR-04.)* | Customer | ☐ |

**Worked examples** *(for discussion only)*
- *Given* a signed-in Customer, *then* they can open the Arrival Notices for their own files.
- *Given* a signed-in Customer, *then* an Invoice addressed to another Party is not shown.

**Not stated — ask:** BO-05.

---

## Public Lookup (FR-PT)

### FR-PT-01 Look up by reference
**Source (SRS, verbatim):** "The public lookup shall show status and milestones for a file number, booking number, air or ocean waybill, master number or house number, including house rows of a consolidation, without a sign-in."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-PT-01.1 | The Public Lookup needs no sign-in. | Public Visitor | ☐ |
| FR-PT-01.2 | It finds a shipment by File Number, Booking Number, air or ocean waybill number, master number or house number. | Public Visitor | ☐ |
| FR-PT-01.3 | A HAWB number finds its row inside a Consolidation. | Public Visitor | ☐ |
| FR-PT-01.4 | It shows the status and the Milestones. | (system) | ☐ |

**Worked examples**
- *Given* HAWB H-1001 inside a Consolidation, *when* a Public Visitor enters H-1001, *then* they see its status and Milestones.
- *Given* a number that matches nothing, *then* the Public Visitor is told nothing was found and no data is shown.

**Not stated — ask:** whether entering a MAWB number shows every house under it, and so one Customer sees another's cargo (BO-07). Whether Draft and Pending files can be looked up.
**Engineering check:** check:public-tracking.

### FR-PT-02 Tracking fields only
**Source (SRS, verbatim):** "The public response shall contain tracking fields only and no internal financial fields."
**Priority / Status:** Must / Built · **Owner:** Operations lead (decision: Business owner) · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-PT-02 | The Public Lookup shows no amounts, rates, Sell Lines, Cost Lines or Invoice details. *(The fields it does show are not listed.)* | (system) | ☐ |

**Worked examples**
- *Given* any lookup, *then* no amount or rate is shown.
- *Given* any lookup, are the Shipper's and Consignee's names shown? *(Not stated. Ask.)*

**Not stated — ask:** the exact list of fields shown. Whether it is acceptable that anyone who guesses a File Number sees its status (BO-07).

### FR-PT-03 Bot protection on the Public Lookup
**Source (SRS, verbatim):** "Each public lookup shall require a solved single-use proof-of-work token and shall be rate limited."
**Priority / Status:** Must / Built · **Owner:** Operations lead (detail: Technical lead) · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-PT-03.1 | Before each lookup the visitor's browser must solve a small puzzle. Each solution can be used once. | (system) | ☐ |
| FR-PT-03.2 | The number of lookups from one source in a period is limited. | (system) | ☐ |

**Worked examples**
- *Given* a lookup sent without a solved puzzle, *then* it is refused.
- *Given* the same solution sent twice, *then* the second lookup is refused.

**Not stated — ask:** the limit (how many lookups in how long) and what the visitor sees when they reach it. The delay a real Customer notices on a phone.
**Engineering check:** check:public-tracking.

---

## Live map (FR-MP)

### FR-MP-01 Branches, terminals and ports on the map
**Source (SRS, verbatim):** "The system shall show branches, terminals and ports on an interactive map of the Philippines."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-MP-01 | The map shows a marker for each Branch ⚑, terminal and port in the directory that has coordinates. | Any User | ☐ |

**Worked examples**
- *Given* a port in the directory with coordinates, *then* it has a marker on the map.
- *Given* a port with no coordinates, *then* it has no marker and the map still loads.

**Not stated — ask:** a Branch exists only on the map; whether it should also limit Users, files or approvals (BO-04). Whether ports outside the Philippines are needed.

### FR-MP-02 Active Dispatch Routes on the map
**Source (SRS, verbatim):** "The system shall show active dispatch routes on the map from live dispatch data."
**Priority / Status:** Should / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-MP-02 | The map draws each active Dispatch Route from the Company's dispatch records. | Any User | ☐ |

**Worked examples**
- *Given* a Dispatch Route that is In Transit, *then* it is drawn on the map.
- *Given* a Dispatch Route that is Completed, *then* it is not drawn. *(Assumed — confirm.)*

**Not stated — ask:** which stages count as "active" (Dispatched, In Transit, Arrived?). Whether the truck's live position is shown, or only the planned route.

### FR-MP-03 Ship and aircraft positions
**Source (SRS, verbatim):** "Ship and aircraft queries shall be limited to a box of 20 degrees per side or a 250 nautical mile radius, return at most 1,500 markers, and report feed state (including not configured) instead of sample data."
**Priority / Status:** Should / Built · **Owner:** Operations lead (detail: Technical lead) · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-MP-03.1 | A ship or aircraft search covers at most a box of 20 degrees per side, or a radius of 250 nautical miles. | (system) | ☐ |
| FR-MP-03.2 | A search returns at most 1,500 markers. | (system) | ☐ |
| FR-MP-03.3 | When a feed is off or not set up, the map says so and shows no sample data. | (system) | ☐ |

**Worked examples**
- *Given* an area holding 2,000 ships, *then* at most 1,500 markers are returned.
- *Given* a search box of 25 degrees per side — refused, or cut down to 20? *(Not stated. Ask.)*
- *Given* no aircraft feed is set up, *then* the map reports "not configured" and shows no aircraft.

**Not stated — ask:** whether ship and aircraft positions are needed at go-live at all (BO-08). They need internet and a feed token (known limitation 9).
**Engineering check:** check:tracking limit cases.

---

## Candidate requirements

These are **not** requirements. Each is a possible new requirement raised by a gap, waiting for the owner's decision on the linked question.

| ID | Candidate requirement | Why | Question | Gap |
|---|---|---|---|---|
| CR-01 | A Manager can cancel a Freight File with a reason; a Cancelled ⚑ file is not billed. | A cancelled shipment stays Approved and billable today. | OP-03 | GAP-17 |
| CR-02 | An edit to a billable field on an Approved file returns it to Pending. | Billing is re-rated today with no second check. | OP-02 | GAP-16 |
| CR-03 | Approvers are told when a file is Pending; Submitters are told when a file is returned. | No notification exists. | OP-16 | GAP-19 |
| CR-04 | A file is approved or returned within an agreed time, and a named deputy can approve when the Approver is away. | Billing waits on approval. | OP-12 | GAP-18 |
| CR-05 | The fields required at Submit are listed for each Mode and for a Consolidation. | "Dates" and "cargo" cannot be tested. | OP-15 | GAP-08 |
| CR-06 | The house bill of lading is added to the printed documents. | The SAD lists it; the SRS does not. | DOC-07, OP-07 | GAP-13 |
| CR-07 | The Public Lookup shows only a stated list of fields. | "Tracking fields only" is not defined. | BO-07 | GAP-29 |
| CR-08 | A photo of a paper Proof of Delivery can be attached to a Dispatch Route or Stop. | Signature pads are not connected. | OP-10 | GAP-23 |
| CR-09 | Rules state who may place and release a Hold on a RORO Vehicle and which markers stop shipment. | Three hold markers with no rules. | OP-17 | GAP-24 |
| CR-10 | A Quote records who marked it Accepted and when, and expires on its validity date. | An Accepted Quote changes what the Customer is billed. | OP-14 | GAP-07 |
| CR-11 | Milestones are entered by a named Role within an agreed time of the event. | The Public Lookup is only as current as staff make it. | OP-06 | GAP-28 |
| CR-12 | A Domestic Freight File is defined, including whether trucking-only work is a file. | Only files can be billed. | OP-13 | GAP-09 |
