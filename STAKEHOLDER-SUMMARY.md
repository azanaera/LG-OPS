# Business Process Summary for Validation

**The Platform: from quote to ledger**

**For:** Business owner · Accounting lead · Operations lead · Technical lead
**From:** QA (requirements confirmation) · **Date:** 15 November 2026 · **Version:** 0.1 for validation
**Reading time:** about 15 minutes · **Words you may not know:** see [GLOSSARY.md](GLOSSARY.md)

---

## 1. Why you are reading this

The engineering team has written down what the system does today. They wrote it by reading the software, not by asking the business. So it tells us what was built. It does not tell us whether that is how you work, or how you want to work.

**We need you to tell us.** Please read the description of your area and mark each numbered item:

| Mark | Meaning |
|:-:|---|
| ✔ | Correct. This is how it should work. |
| ✎ | Nearly. Write the change in the "Your correction" column. |
| ✖ | Wrong. This is not how we work. Tell us what is. |
| ? | Not mine to answer. Tell us who should. |

Three things to keep in mind:

- **You are checking a description, not accepting a system.** Marking ✔ does not commit you to anything until you sign in section 7.
- **"Today, the system…" means exactly that.** It is not a promise, a plan or a recommendation.
- **If something you do every day is missing, say so.** What is missing matters more than what is wrong.

Bring this document, marked up, to your workshop. We will go through it together.

---

## 2. The process on one page

```
1 Quote ──► 2 Booking ──► 3 APPROVAL ──► 4 Movement ──► 5 Tracking
                              │
                              ▼  billing starts only after approval
                         6 Billing ──► 7 BRIDGE ──► 8 Ledger and month-end
                                       the only way into the books
```

| Step | What happens | Who does it | Who confirms this step |
|---|---|---|---|
| 1. Quote | We price a job for a customer. | Operator or manager | Operations lead |
| 2. Booking | The job is typed up as a Freight File with its own File Number. | Operator | Operations lead |
| 3. Approval | A manager checks the file and approves it or sends it back. | Manager | Operations lead |
| 4. Movement | Vehicles, trucking and deliveries are recorded. | Operator | Operations lead |
| 5. Tracking | Status updates are recorded; customers can look them up. | Operator | Operations lead |
| 6. Billing | The system works out the charges and drafts the invoice. | System, then accountant | Accounting lead |
| 7. Bridge | The accountant checks each amount, then sends it to the books. | Accountant | Accounting lead |
| 8. Ledger | The books are kept, the month is closed, reports are produced. | Accountant | Accounting lead |

**The three ideas behind the design**

1. **One File Number links everything**: the booking, the trucks, the tracking, the invoice and the accounting entries.
2. **Approval comes before billing.** Nothing is billed until a manager has approved the file.
3. **The bridge is the only way into the books.** Operations staff never write to the accounts directly.

---

## 3. Who does what

*Confirmed by: Business owner.*

| Role | Who this is | In short |
|---|---|---|
| **Superadmin** | The technical administrator | Can do everything. |
| **Manager** | A branch or department manager | Runs operations, approves or returns files, and has the accounting functions too. |
| **Operator** | Staff who type up bookings, trucking and deliveries | Creates and submits files. Cannot approve. Cannot see the accounts. |
| **Accountant** | Accounting staff | Billing, the bridge and the books. Sees approved files only. |
| **Viewer** | Read-only staff and auditors | Can look. Cannot change anything. |
| **Public visitor** | Anyone with a reference number | Can look up a shipment's status. Has no sign-in. |

### What each role can do today

`✔` yes · `✖` no · `👁` look only · **`?` the documents do not say, or contradict each other — we need your decision**

| Action | Superadmin | Manager | Operator | Accountant | Viewer |
|---|:-:|:-:|:-:|:-:|:-:|
| Create or change a file that is not yet submitted | ✔ | ✔ | ✔ | ✖ | ✖ |
| Submit a file for approval | ✔ | ✔ | ✔ | ✖ | ✖ |
| Change a file that is waiting for approval | ✖ | ✖ | ✖ | ✖ | ✖ |
| Approve a file or send it back | ✔ | ✔ | ✖ | ✖ | ✖ |
| Approve a file they submitted themselves | ✔ | ✔ | — | — | — |
| Change a file after it is approved | ✔ | ✔ | ✖ | **?** | ✖ |
| See files that are not yet approved | ✔ | ✔ | ✔ | ✖ | 👁 |
| Send amounts to the books | ✔ | **?** | ✖ | ✔ | ✖ |
| Record accounting entries and close the month | ✔ | ✔ | ✖ | ✔ | ✖ |
| Read the accounts and reports | ✔ | ✔ | ✖ | ✔ | **?** |
| Add, change or switch off users | ✔ | **?** | ✖ | ✖ | ✖ |
| Delete records | **?** | **?** | **?** | **?** | ✖ |
| Read the record of who changed what | **?** | **?** | **?** | **?** | **?** |

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-57 | There are five roles, and each user has exactly one. | | | OP-04 |
| V-58 | The table above is right wherever it shows ✔, ✖ or 👁. | | | |
| V-59 | A user sees only the records of their own company. | | | BO-03 |
| V-60 | A user who forgets their password cannot reset it themselves. They send a help request from the sign-in page and wait for an administrator. | | | BO-06 |
| V-61 | Five wrong passwords in a row lock sign-in for one minute. A user who is idle for a while is signed out. | | | TL-11 |

---

## 4. Step-by-step validation

### Step 1: Quote

*Confirmed by: Operations lead.*

Today, the system lets an operator or manager prepare a quote for a customer. A quote starts as a draft, is marked as sent, and ends as accepted, rejected or expired. Once a quote is accepted, it can be turned into a Freight File, and its prices are then used on the invoice in place of the standard rates.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-01 | A quote is Draft, Sent, Accepted, Rejected or Expired. | | | OP-14 |
| V-02 | Only an accepted quote can be turned into a Freight File. | | | OP-14 |
| V-03 | When an accepted quote is linked to a file, the quote's prices replace the standard rates. Example: the standard rate gives 95.00, the quote says 85.00, the customer is charged 85.00. | | | |
| V-04 | The system does not record how the customer accepted, or who marked the quote as accepted. | | | OP-14 |

### Step 2: Booking, cargo and documents

*Confirmed by: Operations lead.*

Today, an operator types up each job as a Freight File. A file is either ocean or air, and export, import or domestic. The system gives it a File Number that is never used again. The file holds the shipper, consignee, notify party, ports or airports, carrier, vessel or flight, containers and cargo measurements. The system works out the weight that charges are based on, and prints the shipping documents from the file.

For air consolidations, one master air waybill carries many house air waybills. They are typed as rows on one screen, each with its own shipper and consignee.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-05 | Every job is a Freight File. A file is ocean or air, and export, import or domestic. | | | OP-13 |
| V-06 | The system gives each file its own File Number. The first part of the number shows whether it is ocean or air, and export, import or domestic. | | | OP-01 |
| V-07 | We call this record a **Freight File**. "Booking number" means only the carrier's reference. | | | OP-01 |
| V-08 | Ocean cargo is charged on the greater of its weight in tonnes and its volume in cubic metres. Example: 3.2 tonnes and 5.0 cubic metres is charged on 5.0. | | | |
| V-09 | Air cargo is charged on the greater of its actual weight and its volume weight (length × width × height ÷ 6000 for each piece), rounded up to the next half kilo. Example: 2 pieces of 100 × 50 × 40 cm weighing 30 kg in total are charged as 67.0 kg. | | | TL-10 |
| V-10 | In a consolidation, the master's chargeable weight is the greater of the total actual weight and the total volume weight. Example: house A is 100 kg actual, 60 kg volume; house B is 40 kg actual, 90 kg volume. The master is charged on 150 kg, not 190 kg. | | | AC-01 |
| V-11 | The form warns when a booking number or master number is already on another file, and when the same house number is typed twice. | | | |
| V-12 | These documents print from the file: bill of lading or air waybill, packing list, commercial invoice, manifest, export declaration, arrival notice. A consolidation prints one arrival notice for each house. | | | OP-07 |
| V-13 | Any operator can change another operator's file while it is still a draft. | | | OP-05 |

### Step 3: Approval

*Confirmed by: Operations lead. Decisions on the control itself: Business owner.*

Today, when an operator finishes a file, they submit it. The system first checks that the shipper, consignee, bill-to party, origin, destination, dates and cargo are filled in. From that moment the file is **Pending** and nobody at all can change it. A manager then either **approves** it, or **returns** it with a note saying what to fix. A returned file goes back to the operator as **For Correction**; they fix it and submit again. Once approved, the file is released for billing and operators can no longer change it.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-14 | A file cannot be submitted until the shipper, consignee, bill-to party, origin, destination, dates and cargo are filled in. | | | OP-15 |
| V-15 | While a file is waiting for approval, nobody can change it, not even the person who submitted it. | | | |
| V-16 | Only a manager or superadmin can approve a file or send it back. | | | OP-12 |
| V-17 | A file cannot be sent back without a note. A picture can be added to the note. | | | |
| V-18 | A manager can approve a file that the same manager submitted. | | | BO-02 |
| V-19 | After approval, a manager can still change the file, including its weights and charges. The charges are worked out again. Nobody is asked to approve it a second time. | | | OP-02 |
| V-20 | There is no way to cancel a file. A job that is cancelled stays as it was. | | | OP-03 |
| V-21 | The system does not tell a manager that a file is waiting, or an operator that a file has come back. They see it when they look at the overview page. | | | OP-16 |

### Step 4: Movement (vehicles, trucking, deliveries)

*Confirmed by: Operations lead.*

Today, the system keeps three kinds of movement record. **RORO vehicles** are customers' vehicles shipped on roll-on/roll-off vessels. **Cartage orders** are pickups and deliveries by truck. **Dispatch routes** are planned runs by one driver in one company truck through several stops. The system also keeps a list of the company's own trucks and drivers.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-22 | Each RORO vehicle is recorded with its identification number, year, make, model, colour, shipper, consignee, ports, booking number, location and condition. | | | |
| V-23 | A RORO vehicle is Expected, Received, Ready to Ship, Pre-Loaded, Loaded, Shipped or on Hold. Every change is kept in its history. | | | OP-17 |
| V-24 | A RORO vehicle also has a title status (Pending, Received, Missing), a customs hold marker and a lien release marker. Nothing says who sets them or whether they stop the vehicle being shipped. | | | OP-17 |
| V-25 | A cartage order is a pickup, a delivery, a cross-dock or an exchange. It is Open, Assigned, In Transit, Delivered or Cancelled, and can be linked to a Freight File. | | | |
| V-26 | A driver and "equipment" are assigned to each cartage order. | | | OP-04 |
| V-27 | A dispatch route has one driver, one truck and several stops. It is Draft, Dispatched, In Transit, Arrived or Completed. | | | OP-04 |
| V-28 | A delivery signature can only be captured on a signature pad. No signature pad is connected, so no proof of delivery is captured in the system today. | | | OP-10 |
| V-29 | Trucking, vehicle shipping and delivery runs are recorded but cannot be billed from the system. Only ocean and air files are billed. | | | AC-17 |

### Step 5: Tracking and the public lookup

*Confirmed by: Operations lead. Decision on what the public sees: Business owner.*

Today, staff type in status updates ("milestones") by hand, each with a place, a note, a date and a time. Anyone, without signing in, can enter a file number, booking number, waybill number, master number or house number on a public page and see the status and the milestones.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-30 | Every status update is typed in by staff. Nothing arrives automatically from carriers. | | | OP-06 |
| V-31 | Anyone who knows or guesses a reference number can see that shipment's status. No sign-in is needed. | | | BO-07 |
| V-32 | The public page shows "tracking information only" and no amounts. The exact list of what it shows is not written down. | | | BO-07 |
| V-33 | Customers cannot sign in to see their own files, documents or invoices. | | | BO-05 |
| V-34 | An arrival notice can be previewed but not emailed from the system. | | | OP-09 |

### Step 6: Billing and invoices

*Confirmed by: Accounting lead.*

Today, each time an approved file is saved, the system works out two sets of lines. **Sell lines** are what we charge the customer. **Cost lines** are what we expect to pay suppliers. It takes the prices from the rate tables ("tariffs"), choosing the most specific one, and drafts one invoice for the file. An accountant issues the invoice, which fixes its invoice number. A posted invoice is never edited. To correct one, the accountant voids it, the books are reversed, and a new version of the invoice is drafted.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-35 | Charges are worked out only for approved files, and again every time an approved file is saved. | | | AC-20 |
| V-36 | The most specific rate wins. Example: a rate for this customer on this lane is 80.00, a rate for the lane is 95.00, a general rate is 110.00. The customer is charged 80.00. Rates that have expired or not yet started are ignored. | | | |
| V-37 | If a calculated charge is below the minimum, the minimum is charged. Example: calculated 1,800.00, minimum 2,500.00, charged 2,500.00. | | | |
| V-38 | A charge typed in by a person is never changed when the system works the charges out again. | | | |
| V-39 | VAT of 12 percent is added to taxable charges. Example: taxable charges of 10,000.00 give VAT of 1,200.00 and a total of 11,200.00. Each invoice is marked 12 percent, zero-rated or exempt. Nothing says how that is chosen. | | | AC-04 |
| V-40 | Each file has one invoice, addressed to one bill-to party. | | | AC-01, AC-02 |
| V-41 | An invoice gets a temporary reference as a draft, and its invoice number when issued. The number is fixed and never used again. | | | AC-05 |
| V-42 | Invoices can be in US dollars or other currencies, and the books are kept in pesos. No rule says which exchange rate is used or when it is fixed. | | | AC-03 |
| V-43 | An invoice with a total of zero or less is refused. There is no credit note. | | | AC-06 |
| V-44 | Rate tables are mostly empty today. Only one lane has a known rate. Where there is no rate, the file shows "no tariff" and no charge is produced. | | | AC-18 |

### Step 7: The accounting bridge

*Confirmed by: Accounting lead. Decision on who may post: Business owner.*

Today, invoice amounts and cost amounts do not go straight into the books. They wait in the bridge as **Staged**. The accountant first runs a **trial post**: the system builds the accounting entry and checks that it balances, without writing anything. If it balances, the item is **Trial Verified**. The accountant then **posts** it, and only then is it in the books.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-45 | Each amount is placed in the bridge once. It cannot be placed twice. | | | |
| V-46 | An amount is checked with a trial post before it can be posted. The trial changes nothing in the books. | | | |
| V-47 | If a kind of charge has no account assigned, the item is refused and the reason is shown. The system never guesses an account. | | | |
| V-48 | The company chooses one of three ways of working. **Manual**: invoices stay as drafts. **Review** (the setting today): amounts wait for an accountant to post them. **Auto**: amounts are posted with no person checking. | | | AC-13 |
| V-49 | All income is recorded under one sales account, whatever the service. | | | AC-07 |
| V-50 | Managers have the accounting functions as well as approval. The documents do not say who may post. | | | AC-15 |

### Step 8: The ledger and month-end

*Confirmed by: Accounting lead.*

Today, the system keeps the company's books: the chart of accounts, vouchers, journals and a check register. Every entry must balance before it is saved. At month-end the accountant closes the month; the system creates the closing entries and locks the month. Reports are produced from the posted entries.

| V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref |
|---|---|:-:|---|---|
| V-51 | An entry whose debits and credits are not equal cannot be saved. | | | |
| V-52 | Once a month is closed, no entry can be dated in it. Example: October 2026 is closed; an entry dated 31 October is refused, and the system names 1 November as the first open date. | | | |
| V-53 | The system cannot reopen a closed month. If it must be reopened, that is done outside the system. | | | AC-12 |
| V-54 | The reports are: trial balance, income statement, balance sheet, cash flow, check voucher report and subsidiary schedule. | | | AC-10 |
| V-55 | Checks are recorded as Draft, Printed, Posted or Void. Payments made in other ways have no register. | | | AC-22 |
| V-56 | The books exist for one company only. | | | BO-03 |

---

## 5. What the system does not do today

Please mark each one: is this acceptable on the day we start using the system for real?

| # | Not done today | What staff do instead | Acceptable at go-live? Yes / No / Until when | Ref |
|---|---|---|---|---|
| N-01 | No credit note. | Void the invoice and issue a new one. | | AC-06 |
| N-02 | No routine backup of the data, and no practised way to restore it. | Nothing. | | TL-01 |
| N-03 | No independent security test has been done. | The team's own checks only. | | TL-03 |
| N-04 | Some long lists load everything at once and may be slow. | — | | TL-06 |
| N-05 | A manager can approve their own file. | — | | BO-02 |
| N-06 | Income is not split by service in the books. | One sales account. | | AC-07 |
| N-07 | Customers cannot sign in. | They use the public lookup or call the office. | | BO-05 |
| N-08 | No barcode scanners, signature pads, label printers, government filing or carrier connections. | Manual entry and paper. | | BO-08 |
| N-09 | Arrival notices cannot be emailed. | Print or save, then send by hand. | | OP-09 |
| N-10 | Rate tables are mostly empty. | Type each charge by hand. | | AC-18 |
| N-11 | Customer payments, receipts and statements of account are not recorded. | Outside the system. | | AC-08 |
| N-12 | Suppliers' actual bills are not recorded or compared with expected costs. | Outside the system. | | AC-09 |
| N-13 | No report of profit per file, customer or lane. | — | | AC-10 |
| N-14 | A shipment cannot be cancelled. | — | | OP-03 |
| N-15 | The vehicle number lookup works for US-format numbers only. | Type the details. | | OP-17 |
| N-16 | The live map shows no ships without an internet connection and a paid data feed. | — | | BO-08 |
| N-17 | A file loaded from another system, not typed into the form, gets a plain number without the usual first part. | Use the form. | | OP-08 |
| N-18 | Speed was measured on demonstration data only, not at our real volumes. | — | | BO-10 |
| N-19 | No plan yet for loading our existing customers, open jobs, rates and opening balances. | — | | BO-12 |

---

## 6. Decisions only you can make

These are the ten gaps that matter most. No option is marked as recommended. Please think about them before your workshop.

| # | Decision | Options | Who decides | Ref |
|---|---|---|---|---|
| D-1 | The engineering document says four items are "required for release" and they are not finished: credit note, security test, backup, and paging of long lists. | (a) All four must be done before go-live. (b) Some are postponed, in writing, with a date. (c) Go-live moves. | Business owner | BO-01 |
| D-2 | May a manager approve a file they submitted themselves? | (a) No, never. (b) No, but a named second person may approve in a one-person office. (c) Yes. | Business owner | BO-02 |
| D-3 | When an approved file is changed, should it be approved again? | (a) Yes, for any change. (b) Yes, for changes that affect the charges. (c) No. | Operations lead | OP-02 |
| D-4 | How is a consolidation invoiced? | (a) One invoice for the whole master. (b) One invoice for each house customer. (c) Both, depending on the job. | Accounting lead | AC-01 |
| D-5 | Which exchange rate is used when an invoice is not in pesos, and when is it fixed? | (a) At booking. (b) When the invoice is issued. (c) When it is posted. And: from which source, and who may change it? | Accounting lead | AC-03 |
| D-6 | Until a credit note exists, is "void and issue again" acceptable? | (a) Yes. (b) Yes, until a stated date. (c) No. | Accounting lead | AC-06 |
| D-7 | Who may send amounts to the books? | (a) Accountants only. (b) Accountants and managers. (c) Accountants, but never the person who approved the file. | Business owner | AC-15 |
| D-8 | How much data could we afford to lose, and how long could we be without the system? | Give a figure for each, for example "one day's work" and "four hours". | Business owner, Technical lead | TL-01 |
| D-9 | What existing data must be in the system on day one, and who prepares it? | Customers / open jobs / rates / opening balances — say which, and name a person. | Business owner | BO-12 |
| D-10 | Are customer payments and receipts to be recorded in this system? | (a) Yes, at go-live. (b) Yes, later. (c) No, they stay elsewhere. | Accounting lead | AC-08 |

---

## 7. Sign-off

> **Signing confirms the description, not that the system is accepted.** It says: "the items I marked ✔ describe how the business should work, and my corrections are recorded." Acceptance of the working system is a separate, later step.

| Area | Name | Items confirmed (✔) | Items changed (✎ ✖) | Signature | Date |
|---|---|---|---|---|---|
| Operations — steps 1 to 5 (V-01 to V-34) | | | | | |
| Accounting — steps 6 to 8 (V-35 to V-56) | | | | | |
| Business — roles, controls, go-live (V-57 to V-61, D-1, D-2, D-7 to D-9) | | | | | |
| Technical — section 5 items N-02 to N-04, N-18 | | | | | |
