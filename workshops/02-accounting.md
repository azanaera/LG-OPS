# Workshop 2: Accounting

| | |
|---|---|
| **Owner** | Accounting lead |
| **Also invite** | An accountant who bills · an accountant who posts and closes the month · one engineer |
| **Length** | 90 minutes: opening 5 · eight topics 75 · close 10 |
| **Pre-read** | [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) steps 6 to 8 (V-35 to V-56), sections 5 and 6 · [Glossary](../GLOSSARY.md) section 2 |
| **Ask them to bring** | A real invoice · an invoice that was corrected, and how · a consolidation's invoices · the current rate sheet · the chart of accounts · the month-end checklist |
| **You bring** | Demo copy open on: an approved file's charges, a draft invoice, the bridge queue, a closed month · [02-accounting breakdown](../requirements-breakdown/02-accounting.md) · carried items from Workshop 1 |
| **Decides here** | AC-01 to AC-14, AC-16, AC-17, AC-19 to AC-22 |
| **Raised here, decided by the Business owner** | AC-15, AC-18 · consulted on BO-11 |

## Carried in from Workshop 1

Write these in before the session:

- How consolidations are billed today (one invoice or one per house): ______
- Which services Operations says are charged (trucking, vehicle shipping, delivery runs): ______
- Operations' answer on re-approval after an edit (OP-02): ______

## Opening (5 min)

**Say:** "Thank you for making the time. The engineering team wrote down how the system bills and keeps the books by reading the software. Nobody has yet asked you whether those are your rules. That is what today is for."

**Say:** "For each part I will first ask how you do it today, then show you what the system does, with a worked example in numbers. Please check the numbers. Nothing you say today is a commitment. You will get my notes tomorrow to correct."

**Say:** "Some of what I will ask is about what happens after the invoice: payments, supplier bills, profit. The system does not cover those today. I need to know whether it should."

---

### Topic 1 — From approved file to charges (10 min) · V-35 to V-38 · AC-11, AC-20
**As-is — ask first:** "Take one invoice you issued last week. How did you arrive at each amount on it?"
**Listen for:** where rates come from today (a sheet, memory, a contract); who decides a special price; how minimums are applied; how often a charge is changed after the fact.
**Show:** the charges on an approved file in the demo copy.
**Say:** "Today, each time an approved file is saved, the system works out what we charge the customer and what we expect to pay suppliers, from the rate tables. The most specific rate wins: with a rate of 80 for this customer on this lane, 95 for the lane and 110 in general, the customer is charged 80."
**Say:** "If a calculated charge is 1,800 and the minimum is 2,500, the customer is charged 2,500. A charge typed in by a person is never changed by the system."
**Ask:**
1. "Are those three rules right: most specific rate, minimum charge, typed-in charges left alone?" → confirms V-36 to V-38
2. "If a file is changed after its invoice has been issued, the system marks the invoice for re-issue. Who should be told, and who re-issues it?" → AC-20
3. "The front page shows a monthly income figure based on shipment dates. The books count income by posting date. Which one does management use?" → AC-11
**If no view — offer:** the Proposed answer for AC-11. Say it is a proposal.
**Record:** each rule confirmed or corrected, with the numbers · as-is source of rates.
**Probe if time:** which date decides whether a rate is valid: booking, departure or billing.

### Topic 2 — Who is billed (12 min) · V-40, V-10 · AC-01, AC-02
**As-is — ask first:** "Show me the invoices for your last consolidation. Who was billed, and for what?"
**Listen for:** one invoice or many; who is the customer (the house shipper, the consignee, an agent); charges split between two payers; who pays at origin and who at destination.
**Show:** a consolidation's single invoice in the demo copy.
**Say:** "Today each file has one invoice, addressed to one party. A consolidation is one file, so it has one invoice, however many house customers it carries."
**Ask:**
1. "Is a consolidation billed as one invoice, or one per house customer?" → AC-01
2. "On a single job, are charges ever billed to two different parties, such as some to the shipper and some to the consignee or an overseas agent?" → AC-02
3. "On a consolidation invoice, what should be shown as the house number?" → confirms OP-11
**If no view — offer:** there is no proposal; this is their rule. Give the carried-in answer from Operations and ask if it is right.
**Record:** the billing rule for consolidations · whether split billing exists, with a real example.
**Probe if time:** each house customer charged on their own weight while the airline charges on the master's weight.

### Topic 3 — Currency and tax (12 min) · V-39, V-41, V-42 · AC-03, AC-04, AC-05
**As-is — ask first:** "When you bill in dollars, which exchange rate do you use for the books, and where do you get it?"
**Listen for:** the rate source; the moment it is fixed; who may change it; what happens to the difference when the customer pays; how VAT treatment is decided; what the tax office requires of an invoice.
**Show:** a draft invoice and its accounting preview in the demo copy.
**Say:** "Today invoices can be in dollars or other currencies, and the books are kept in pesos. There is no rule in the system for which exchange rate is used or when it is fixed."
**Say:** "VAT of 12 percent is added to taxable charges: 10,000 of taxable charges gives 1,200 of VAT and a total of 11,200. Each invoice is marked 12 percent, zero-rated or exempt, but nothing says how that is chosen."
**Say:** "An invoice gets its invoice number when it is issued. The number has a part for the kind of shipment, the year and month, and a running number for the month. It is never changed or used again."
**Ask:**
1. "Which rate, from which source, fixed at which moment? Who may override it?" → AC-03
2. "When the customer pays later at a different rate, how is the difference recorded?" → AC-03
3. "When is an invoice 12 percent, zero-rated or exempt, and who chooses? Do you deal with withholding tax?" → AC-04
4. "Is this the official invoice for tax purposes? What does the tax office require for the number series, for voided numbers and for the printed layout?" → AC-05
**If no view — offer:** the Proposed answer for AC-03. For AC-04 and AC-05 there is no proposal; these are facts they hold.
**Record:** the exchange rate rule · the VAT rules · the tax-office requirements, as a list.
**Probe if time:** month boundaries: an invoice issued at 11 pm on the last day (leads to the time zone question, TL-09).

### Topic 4 — Correcting an invoice (8 min) · V-43 · AC-06
**As-is — ask first:** "Tell me about the last invoice you had to correct after sending it. What did you do, and what did the customer receive?"
**Listen for:** credit notes in use today; how often; whether a full cancel-and-reissue is acceptable to customers and auditors.
**Show:** void an invoice in the demo copy; show the reversal and the new draft.
**Say:** "Today a posted invoice is never edited. To correct it, the accountant voids it. The books are reversed in the open month and a new version of the invoice is drafted. There is no credit note, and an invoice totalling zero or less is refused."
**Ask:**
1. "Until a credit note exists, is void and issue again acceptable? For how long?" → AC-06
2. "When do you need a credit note, and what must it show?" → AC-06
**If no view — offer:** there is no proposal; ask what their auditors expect.
**Record:** acceptable or not, and until when · what a credit note must contain.
**Probe if time:** correcting an invoice from a month that is already closed.

### Topic 5 — The bridge, and who posts (10 min) · V-45 to V-50 · AC-07, AC-13, AC-14, AC-15, AC-16, AC-19
**As-is — ask first:** "Today, how does a finished invoice get into the books, and who checks it before it does?"
**Listen for:** who enters, who checks; whether one person does both; how income is split across accounts today.
**Show:** the bridge queue in the demo copy; run a trial post, then post.
**Say:** "Today amounts wait in the bridge. The accountant runs a trial that builds the entry and checks it balances, without touching the books. Then the accountant posts it. If a kind of charge has no account assigned, the item is refused. The system never guesses."
**Say:** "The company can choose to keep everything as drafts, to have amounts wait for an accountant, or to have them posted with no person checking. Today it is set to wait for an accountant."
**Ask:**
1. "Which of those three ways do you want on day one, and who may change it?" → AC-13
2. "Who should be allowed to post? Managers also approve files. Should the person who approved a file be able to post it?" → AC-15 (the Business owner decides; record the Accounting lead's view)
3. "Should accountants be able to change a freight file, or only read it?" → AC-16
4. "All income goes to one sales account today. Which accounts should freight, handling, documentation and the rest go to?" → AC-07
5. "The system has an item called a miscellaneous invoice that does not come from a freight file. What would you use it for?" → AC-19
6. "Automatic posting stops when a 'rate note' is open. Here is what engineering says that means: ______. Does that make sense to you?" → AC-14
**If no view — offer:** the Proposed answers for AC-13, AC-15 and AC-16. Say they are proposals.
**Record:** the mode · the Accounting lead's view on who posts · the account mapping, or who will supply it and when.
**Probe if time:** who may record a journal directly, outside the bridge.

### Topic 6 — The books, the month and the year (8 min) · V-51 to V-56 · AC-12, AC-21, AC-22
**As-is — ask first:** "Walk me through your last month-end. What had to be finished before you closed, and has a closed month ever had to be reopened?"
**Listen for:** the real checklist; who signs off; how reopening is done; the fiscal year; how payments are made.
**Show:** a closed month in the demo copy; try to date an entry in it.
**Say:** "Today, once a month is closed, nothing can be dated in it. With October closed, an entry dated 31 October is refused, and the system names 1 November as the first open date. The system cannot reopen a month."
**Say:** "Checks are recorded as draft, printed, posted or void. Payments made in other ways have no register."
**Ask:**
1. "If a closed month must be reopened, who authorises it and how should it be recorded?" → AC-12
2. "What is your fiscal year? Is there a year-end close beyond the monthly one?" → AC-21
3. "What do you pay by check? How do you pay otherwise, and should those payments be recorded here?" → AC-22
4. "How long must accounting and shipping records be kept by law?" → consult for BO-11
**If no view — offer:** the Proposed answer for AC-12.
**Record:** the reopening rule · fiscal year · payment types · the legal retention period for session 3.
**Probe if time:** which reports they actually use each month, and which are missing.

### Topic 7 — After the invoice (8 min) · AC-08, AC-09, AC-10, AC-17
**As-is — ask first:** "Once an invoice is sent, how do you know it has been paid? And when a supplier's bill arrives, what do you compare it with?"
**Listen for:** where receipts are recorded today; how overdue accounts are chased; how supplier bills are checked; whether profit per job is tracked.
**Show:** [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) section 5, items N-11 to N-13.
**Say:** "Today the system stops at the posted invoice. It does not record customer payments or receipts, it does not record suppliers' actual bills, and it has no report of profit per job."
**Say:** "Trucking, vehicle shipping and delivery runs are recorded, but only ocean and air files are billed."
**Ask:**
1. "Should customer payments, receipts and overdue lists be in this system? On day one or later?" → AC-08
2. "How should suppliers' actual bills be recorded and compared with the expected cost?" → AC-09
3. "Do you need profit per job, per customer or per lane?" → AC-10
4. "Operations says these services are charged: ______. How should each be billed?" → AC-17
**If no view — offer:** the Proposed answer for AC-10. The others need their decision.
**Record:** in scope for go-live, later, or never, for each · where the work is done meanwhile.
**Probe if time:** statements of account; deposits and advance payments.

### Topic 8 — Rates and set-up (7 min) · V-44 · AC-18
**As-is — ask first:** "Where do your rates live today, and who keeps them up to date?"
**Listen for:** the number of lanes and customers with special rates; how often rates change; who owns the sheet.
**Show:** the rate table in the demo copy, mostly empty.
**Say:** "Today the rate tables are mostly empty. Only one lane has a known rate. Where there is no rate, the file shows 'no tariff' and no charge is produced, so every charge would be typed by hand."
**Ask:**
1. "Who should enter the rates, and by when?" → AC-18 (the Business owner names the person; record the Accounting lead's view)
2. "Roughly how many rates are there to enter?" → AC-18
**If no view — offer:** the Proposed answer for AC-18.
**Record:** the size of the job · a suggested owner and date, for session 3.
**Probe if time:** whether the chart of accounts in the system matches theirs.

---

## Close (10 min)

1. **Read back** every decision, one sentence each. Ask: "Is that right?"
2. **Parking lot:** agree who answers each item and by when.
3. **Carried to the Business owner:** who may post (AC-15), who enters rates (AC-18), the retention period (BO-11), the posting mode (AC-13).
4. **Carried to the Technical lead:** the exchange rate rule (AC-03) and the time zone (TL-09).
5. **Next step — say:** "You will have my notes tomorrow. Please correct anything by the date on them. Some of your answers I will confirm with Operations, where the two areas meet."

## Questions covered

| Topic | Decided here | Raised or consulted here |
|---|---|---|
| 1 | AC-11, AC-20 | |
| 2 | AC-01, AC-02 | OP-11 |
| 3 | AC-03, AC-04, AC-05 | TL-09 |
| 4 | AC-06 | |
| 5 | AC-07, AC-13, AC-14, AC-16, AC-19 | AC-15 |
| 6 | AC-12, AC-21, AC-22 | BO-11 |
| 7 | AC-08, AC-09, AC-10, AC-17 | |
| 8 | | AC-18 |
