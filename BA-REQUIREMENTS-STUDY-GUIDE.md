# BA Requirements Study Guide

**For:** a QA engineer doing business-analyst work on the Platform for the first time: gathering and confirming requirements with stakeholders.
**Date:** 15 November 2026 · **Time needed:** about seven hours of study over a week, then one dry run.

Read this first. It tells you what to study, in what order, and how to run the conversations. Everything else in the pack is listed in [README.md](README.md).

---

## 1. Your job in one paragraph

You are **not** there to get the SRS and SAD signed. Engineering wrote both by reading the code, so they describe what was built. Your job is to find out what the business needs, show where the documents differ from that, and get each difference decided by the person who owns it. You already have the right instincts. As a tester you ask "what is the expected result?", "what happens at the edge?" and "how would I check this?". Those are exactly the questions a business analyst asks. The one shift is this: in testing, someone has already written the expected result and you **verify** it. Here, nobody has. You have to **draw it out** of people who know their work well but have never had to write it down, and then write it so precisely that it could be tested.

Three rules follow from that:

1. **Listen before you show.** Ask how the work is done today before you show what the system does.
2. **Never answer for the business.** A proposal is a proposal until the owner says yes.
3. **If it is not written in the log, it was not decided.**

## 2. Seven-day study plan

About an hour a day. The last column is the test: if you cannot do it, repeat the day.

| Day | Read | Do | You can now… |
|---|---|---|---|
| 1 | [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) sections 1 to 5 · [GLOSSARY.md](GLOSSARY.md) section 2 | Draw the eight-step process from memory. | Explain the system to a friend in two minutes, using the 12 key words. |
| 2 | Section 3 below (freight) · Glossary A to Z, freight terms | Work the three weight examples by hand. | Say why 30 kg of cargo can be charged as 67 kg. |
| 3 | [01-operations.md](requirements-breakdown/01-operations.md): FR-AP and FR-SH entries · [Stakeholder Summary](STAKEHOLDER-SUMMARY.md) steps 1 to 5 | Trace one file from Draft to Approved in the demo copy, including one Return. | List who can do what to a file in each Operation Status. |
| 4 | Section 4 below (accounting) · [02-accounting.md](requirements-breakdown/02-accounting.md): FR-BL entries | Work the rate, minimum and VAT examples by hand. | Explain Sell Line, Cost Line and profit on one job. |
| 5 | [02-accounting.md](requirements-breakdown/02-accounting.md): FR-BR and FR-FS entries · Stakeholder Summary steps 6 to 8 | In the demo copy: stage, trial post, post, then void an invoice. | Explain why a posted invoice is reversed and never edited. |
| 6 | [PROCESS-GAP-ANALYSIS.md](PROCESS-GAP-ANALYSIS.md) sections 2 to 4 · [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md) | For the ten top gaps, say the question you would ask, without reading it. | Name the four Must items that are not built and who decides each. |
| 7 | [workshops/README.md](workshops/README.md) · the script for your first session · sections 7 to 10 below | Read the script aloud to a colleague playing the owner. Time it. | Run a topic block without looking at the page for the "As-is" question. |

Then take the self-test in section 13.

## 3. Freight forwarding in 20 minutes

**What a forwarder sells.** A freight forwarder does not own ships or aircraft. It arranges for a customer's cargo to get from A to B: it books space with a **Carrier** (a shipping line or airline), prepares the documents, arranges trucking at each end, and bills the customer for the whole job. It makes money on the difference between what it charges the customer and what it pays the carrier and other suppliers.

**Direction.** *Export*: cargo leaves the country. *Import*: cargo arrives. *Domestic*: cargo moves within the country. What "domestic" means in this system is an open question (OP-13).

**Parties on a job.** The **Shipper** sends. The **Consignee** receives. The **Notify Party** is told on arrival. The **Bill-to Party** pays, and is not always the shipper or consignee. An overseas **Agent** handles the far end.

### Ocean

- Cargo travels in **Containers**. A customer may fill a whole container (FCL) or share one (LCL).
- The key document is the **bill of lading**: the carrier's receipt for the cargo and the contract to carry it.
- Loose ocean cargo is charged on **Revenue Weight**: the greater of the weight in tonnes and the volume in cubic metres. Carriers sell space, so bulky, light cargo pays for its volume.
  - 3.2 tonnes and 5.0 m³ → charged on **5.0**.
  - 8.0 tonnes and 5.0 m³ → charged on **8.0**.

### Air

- The key document is the **Air Waybill**.
- Air cargo is charged on **Chargeable Weight**: the greater of the actual weight and the **Volumetric Weight**. Aircraft run out of space before they run out of lifting power, so light, bulky cargo pays for its volume.
- Volumetric Weight of one piece = length × width × height (in cm) ÷ 6000, in kilograms.
  - 2 pieces of 100 × 50 × 40 cm, 30 kg in total: each piece is 200,000 ÷ 6000 = 33.33 kg, so 66.67 kg for both. Rounded up to the next half kilo: **67.0 kg**. That is more than 30 kg, so the customer pays for 67.0 kg.
- Rounding up to the next half kilo follows the airlines' standard rule book (TACT).

### Air consolidation — learn this one well

A forwarder collects cargo from many customers and ships it together under **one** contract with the airline.

- The **MAWB** (master air waybill) is the forwarder's contract with the airline for the whole lot.
- Each **HAWB** (house air waybill) is the forwarder's contract with one customer.
- The forwarder pays the airline on the master's Chargeable Weight, and charges each customer on their own house's Chargeable Weight.

| | Actual weight | Volumetric weight | Chargeable |
|---|---|---|---|
| House A (dense cargo) | 100 kg | 60 kg | 100 kg |
| House B (bulky cargo) | 40 kg | 90 kg | 90 kg |
| **Sum of the houses' chargeable weights** | | | **190 kg** |
| **Master: totals** | 140 kg | 150 kg | **150 kg** |

The forwarder charges its customers for 190 kg and pays the airline for 150 kg. Dense cargo and bulky cargo balance each other out. **That 40 kg difference is part of how a consolidator makes money.** This is why "the master is 150, not 190" is a business rule and not a bug, and why "how do we invoice a consolidation?" (AC-01) is the most important billing question in the project.

### RORO, cartage and dispatch

- **RORO** (roll-on/roll-off): vehicles are driven onto the vessel. In this system a **RORO Vehicle** is a customer's vehicle, which is cargo. A **Fleet Vehicle** is one of the company's own trucks. Never say just "vehicle".
- **Cartage**: pickup and delivery by truck, recorded as **Cartage Orders**.
- **Dispatch**: a planned run by one **Driver** in one Fleet Vehicle through several **Stops**, ending in a **Proof of Delivery**.

### Incoterms

An **Incoterm** is a three-letter trade term in the sale contract between the shipper and the consignee, such as FOB or CIF. It decides **who pays which part of the journey**. That is why one job can have charges for two different payers, and why "can one file bill two parties?" (AC-02) matters.

### The documents, and who gets them

| Document | What it is | Who receives it |
|---|---|---|
| Bill of lading / Air Waybill | The carrier's receipt and contract of carriage | Shipper, consignee |
| Manifest | The list of everything in a shipment or consolidation | Carrier, customs |
| Packing list | What is in each package | Consignee, customs |
| Commercial invoice | The seller's invoice for the goods (not the forwarder's invoice for its services) | Consignee, customs |
| Export declaration | The declaration to customs that goods are leaving | Customs |
| Arrival Notice | Tells the consignee the cargo has arrived | Consignee, notify party |

Do not confuse the **commercial invoice** (for the goods) with the forwarder's own **Invoice** (for the freight services). The system prints the first and issues the second.

## 4. Accounting in 20 minutes

**Receivable and payable.** What customers owe us is a *receivable* (AR). What we owe suppliers is a *payable* (AP).

**Sell, cost and profit.** On each job:

| | Example |
|---|---|
| **Sell Lines**: what we charge the customer | 10,000.00 |
| **Cost Lines**: what we expect to pay the carrier and other suppliers | 7,500.00 |
| **Profit on the job** | 2,500.00 |

The system produces both kinds of line but has no report that shows the profit (AC-10). Its Cost Lines are *estimates*. Suppliers' real bills are not recorded (AC-09).

**How a charge is worked out.**

- **Tariff**: a rate for a kind of charge. The most specific one wins: a rate for this customer on this lane (80.00) beats a rate for the lane (95.00), which beats a general rate (110.00).
- **Minimum Charge**: a calculated 1,800.00 with a minimum of 2,500.00 is charged at 2,500.00.
- **Manual Line**: a charge a person typed in. The system never recalculates it.

**VAT.** Value-added tax is 12 percent on taxable charges. 10,000.00 of taxable charges gives 1,200.00 of VAT and an invoice total of 11,200.00. An invoice can also be *zero-rated* (taxable at 0 percent) or *exempt* (outside VAT). When each applies is a tax rule the Accounting lead must give you (AC-04). Do not guess it.

**Invoice, receipt, credit note.**

- An **Invoice** asks for payment.
- A *receipt* acknowledges payment. The system has no way to record one (AC-08).
- A **Credit Note** reduces an invoice already issued. The system has none (AC-06). Today the whole invoice is **voided** and issued again.

**Debits and credits, once.** Every accounting entry (a **Journal**) has two sides that must be equal. When we invoice 11,200.00:

| Account | Debit | Credit |
|---|---|---|
| Receivable from the customer | 11,200.00 | |
| Sales | | 10,000.00 |
| VAT owed to the government | | 1,200.00 |
| **Total** | **11,200.00** | **11,200.00** |

If the two totals differ, something is wrong, and the system refuses the entry. That is all "the journal must balance" means. You do not need more bookkeeping than this to run the workshop.

**Posting.** To **Post** is to write a Journal into the **Ledger**, the company's books. In this system an amount goes **Staged → Trial Verified → Posted** through the **Accounting Bridge**. A **Trial Post** is a rehearsal: build the entry, check it balances, write nothing.

**Why accountants never edit a posted entry.** The books are a legal record. If entries could be changed, nobody could trust last month's figures. So a mistake is corrected by a second, opposite entry (a **Reversal Voucher**) and a new, correct one. Both stay visible forever. When an accountant says "we don't edit, we reverse", this is why.

**Closing a month.** At month-end the accountant closes the **Period**. After that, nothing can be dated in that month, so the reported figures cannot change. The system cannot reopen a closed month (AC-12).

**Segregation of duties.** A basic control in any business: the person who *authorises* something should not also be the one who *records* it. If one person can book a job, approve it and post it to the books, a mistake or a fraud has no second pair of eyes. In this system a manager can approve their own file (BO-02) and may also be able to post (AC-15). Expect auditors to care about both.

**Currency.** Invoices can be in US dollars; the books are in pesos. Turning one into the other needs an exchange rate, fixed at a known moment from a known source. The system has no such rule (AC-03).

## 5. How this system thinks

Three ideas explain almost every rule:

1. **One File Number links everything.** Containers, vehicles, trucking, tracking, the invoice and the accounting entries all point to one **Freight File**.
2. **Approval comes before billing.** A file is **Draft → Pending → Approved**, or sent back as **For Correction**. Nothing is billed until it is Approved. Accountants cannot even see a file before that.
3. **The bridge is the only way into the books.** Operations staff never write to the Ledger. An accountant decides when each amount is posted.

And one habit: **every kind of record has its own list of statuses.** There are ten such lists (file, quote, invoice, bridge item, check, RORO vehicle, cartage order, dispatch route, fleet vehicle and driver, period). They are in [REQUIREMENTS-SUMMARY.md](REQUIREMENTS-SUMMARY.md) section 5. Never say just "status". Say which one.

For each status list, a tester's questions are a BA's questions:

- Which moves are allowed, and which are not?
- Who may make each move?
- What must be true before the move?
- What is recorded when it happens?
- Is there a way out when things go wrong (cancel, reopen, undo)?

The SRS answers these well for the Freight File's approval and poorly for almost everything else.

## 6. How to read a requirement critically

Use the six-point test from [requirements-breakdown/README.md](requirements-breakdown/README.md). A requirement is detailed enough only if it has: **one behaviour · a named Role · a trigger and starting condition · a result you can see · every value stated · every term defined.**

### Three worked examples from the SRS

**FR-AP-02** — *"The system shall move a draft or returned file to pending on submit, after checking the required fields (shipper, consignee, bill-to, origin, destination, dates, cargo), and record the revision and the submitter."*

| Test | Result |
|---|---|
| One behaviour | ✖ Four: allow submit, check fields, change status, record revision and submitter. |
| Named Role | ✖ Not here. (FR-AP-01 names them.) |
| Trigger and condition | ✔ On submit, from Draft or returned. |
| Visible result | ✔ Status becomes Pending. |
| Every value | ✖ Which "dates"? Which "cargo" fields? |
| Terms defined | ✖ "Returned" here, "for correction" elsewhere. |

What you do: split it into four child statements, and ask which dates and cargo fields (OP-15).

**FR-AU-08** — *"The browser shall end the session after a period of inactivity."*

Fails on **values**: how long is "a period"? You cannot write a test for it and an owner cannot agree to it. Ask for the number (TL-11).

**FR-AD-01** — *"The system shall let an authorised user create, edit and deactivate users and set roles and company access."*

Fails on **Role**: who is "authorised"? It also hides five behaviours. Ask which Roles (BO-14, DOC-14).

### Weak words to hunt for

When you see one of these, a decision is missing:

| Word | Ask |
|---|---|
| authorised, permitted, appropriate | Which Role, exactly? |
| a period, recent, timely, soon | How long? How many? |
| may, can, should be able to | Must it, or not? |
| support, handle, manage, maintain | Do what, exactly? Create, change, delete, view? |
| and, or | Is this two requirements? |
| etc., such as, including | What is the full list? |
| by the carrier rule, per policy, as configured | Which rule? What value in production? |
| required, valid, complete | By what test? |
| user, staff | Which Role? |
| only (as in "tracking fields only") | What is the list? |

### Things to check that the SRS does not say out loud

- **Status and priority can contradict.** Four requirements are *Must* and not built.
- **"Built" means it exists in the code.** It does not mean correct, wanted or tested at real volume.
- **The acceptance column is for engineers.** "check:billing passes" tells an owner nothing. Ask for an example in numbers (TL-10).
- **What is missing is invisible.** A document cannot fail a requirement it never wrote. Walk the process end to end and ask at each step: "then what?" That is how the gaps before step 1 and after step 8 were found.

## 7. Elicitation techniques, and when to use each

| Technique | Use it when | Example on this project |
|---|---|---|
| **Process walk-through** | You need the real sequence of steps. | "Take the last file you billed. Start from the phone call. What happened next?" |
| **Document analysis** | People struggle to describe a rule but have the paper. | Ask for a real invoice, a consolidation manifest, the rate sheet, a signed proof of delivery, the month-end checklist. Compare each with what the system prints. |
| **Observation** | What people say and what they do may differ. | Sit beside an operator for 30 minutes while they book files. Note every time they leave the screen for a spreadsheet, a phone or a colleague. |
| **Worked example with numbers** | You need a calculation rule confirmed. | "Two pieces, 100 by 50 by 40, 30 kilos. We make that 67 chargeable. Do you?" |
| **Scenario and edge-case questions** | The normal case is agreed and you need the exceptions. | "The customer cancels after approval. The approver is on leave. A house is added after the master is approved." |
| **The five whys** | An answer sounds like habit, not need. | "Why must the manager approve?" "To catch mistakes." "Which mistakes?" "Wrong consignee, wrong weight." Now you know what approval must check. |
| **Show and ask (demo)** | The owner cannot picture the system. | Show a Pending file being returned. Ask: "Is this what happens at your desk?" |
| **Playback** | You think you understood. | "So: any change to the weight after approval sends the file back to the manager. Have I got that right?" |
| **Interview the practitioner, decide with the owner** | The owner is senior and distant from the daily work. | An operator tells you how it is done. The Operations lead decides how it should be. |

Use at least three of these in every session. Walk-through first, numbers next, playback last.

## 8. Asking good questions

**Rules of thumb**

1. **Open before closed.** Start with "how", "what happens when", "walk me through". Use yes-or-no questions only to confirm.
2. **One thing at a time.** A question with "and" in it gets half an answer.
3. **Ask about the last real case**, not the general rule. People describe the rule as it should be and the last case as it was.
4. **Ask what happens, not what the system should do.** Owners know their work. They do not know software.
5. **Do not put the answer in the question.** "You'd want that blocked, wouldn't you?" gets a yes that means nothing.
6. **Ask "what else?" and "then what?"** until the answer is "nothing".
7. **Ask for the exception.** "Is that always true? When was it last not true?"
8. **Wait.** Count to five before you speak again.

**Ten rewrites, from the question log**

| Question | Weak | Better |
|---|---|---|
| AC-01 | "Should consolidations have one invoice per house?" | "Show me the invoices for your last consolidation. Who got one?" |
| OP-03 | "Do you need a Cancelled status?" | "Tell me about the last job that was cancelled after it was booked. What did you do with it?" |
| BO-02 | "Should we block self-approval?" | "In your smallest office, who checks a manager's own bookings?" |
| OP-02 | "Should edits trigger re-approval?" | "A manager changes the weight after approving. Today nobody else sees it. Is that all right?" |
| AC-03 | "Which FX rate should the system use?" | "When you bill in dollars, which rate do you put in the books, and where do you look it up?" |
| OP-12 | "What's the approval SLA?" | "How long did your last ten files wait for approval? What happens when the manager is out?" |
| BO-07 | "Is the public lookup secure enough?" | *(show the page)* "Is there anything here a competitor should not see?" |
| AC-12 | "Do you need to reopen periods?" | "Has a closed month ever had to be changed? What did you do?" |
| OP-15 | "Which fields are mandatory?" | "What must you know about a job before you would let it go to the manager?" |
| BO-10 | "What are your non-functional requirements for performance?" | "How many jobs do you book in a busy month? How many people are booking at once?" |

**Words to avoid with stakeholders.** Do not say: requirement ID, endpoint, API, token, schema, database, role-based access, state machine, non-functional. Say: rule, page, sign-in, who can do what, the steps a file goes through, how fast and how safe.

## 9. Handling the room

| Situation | What to do |
|---|---|
| **"That's not how we work."** | The best thing you can hear. Put the script down. "Then please show me how you do work." Write every step. |
| **"Just make it like the old way."** | "Walk me through the old way for one real job." The old way is requirements nobody wrote down. |
| **The owner designs screens.** "Put a red button here…" | "I'll note that you need to see overdue files at that point. The team will work out how." Record the need, not the button. |
| **The engineer defends the build.** | "Thanks, that's useful for later. First let's hear how the business needs it." Brief the engineer beforehand: listen, do not explain. |
| **Two owners disagree.** | Do not settle it and do not pick a side. Write each position in one sentence. Take both to the Business owner ([register](STAKEHOLDER-REGISTER.md), rule 2). |
| **"I'll get back to you."** | "Of course. Who should I ask, and by when?" Into the parking lot, with a name and a date. |
| **"Yes, fine" to everything.** | They are not engaged, or they want to leave. Ask for a real example. If it continues, stop and rebook with a practitioner in the room. |
| **Silence.** | Wait five seconds. Then ask it another way, with an example. |
| **A senior person answers for everyone.** | "Can I check that with the person who does it daily?" Then ask the practitioner directly. |
| **They ask what you recommend.** | Give the Proposed answer from the log, say it is only a proposal, and say what it would cost them. Then ask if it fits. |
| **They ask something you do not know.** | "I don't know. I'll find out and tell you by Thursday." Then do. Never guess about their business or about the system. |
| **Scope keeps growing.** | "That sounds important. I'll record it as a new request so it is not lost. For today, let's finish what is in front of us." |
| **Time runs out.** | Stop. Read back what was decided. Carry the rest. A rushed decision gets reversed. |

Your own conduct: be neutral, be curious, never show that an answer is "wrong". You are not there to defend the system or to criticise it.

## 10. Recording and closing the loop

**During the session** the note-taker fills in [SESSION-NOTES-TEMPLATE.md](SESSION-NOTES-TEMPLATE.md). You say each decision back in one sentence before it is written.

**A good decision record** has four parts:

> **OP-02 — Answered, 24 November 2026, Operations lead.** A change to weight, volume, pieces or any charge on an Approved file returns it to Pending. Changes to notes and attachments do not.

Who decided. When. One sentence a tester could turn into a test. What is excluded.

**Within one working day**, in this order:

1. [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md): status, decision, who, date.
2. [CONTEXT.md](CONTEXT.md) and [GLOSSARY.md](GLOSSARY.md), if a term changed. Remove the ⚑.
3. The matching entries in [requirements-breakdown/](requirements-breakdown/README.md): tick "Confirmed" or rewrite the statement.
4. [PROCESS-GAP-ANALYSIS.md](PROCESS-GAP-ANALYSIS.md): fill in "How the business does it today".
5. Send the notes to the owner for correction.

**Statuses in the log**

| Status | Meaning |
|---|---|
| Open | Not yet answered. |
| Answered | The owner decided. Not yet in the SRS. |
| Closed | Written into SRS or SAD v0.2. |
| Deferred | The owner accepted it for a later release, in writing, with a reason. |

**From decision to test.** Each confirmed child statement in the breakdown becomes at least one test case, and each worked example is a ready-made test: the *Given* is your set-up, the *When* is your step, the *Then* is your expected result. This is where your BA work pays you back as a tester.

**Then run** `bash tools/check-docs.sh`. It tells you if a question went missing or a link broke.

## 11. Traps specific to this project

1. **The documents were written from the code.** Read every "the system shall" as "the system currently does". Nobody has agreed any of it.
2. **"Built" is not "right".** 110 of 125 requirements are Built. That says nothing about whether the business wants them.
3. **Four Must items are not built** — credit note, security test, backup and restore, paging — so by the SRS's own rule the system cannot be released. Only the Business owner can change that.
4. **The acceptance column is engineering checks.** No owner can confirm "check:bridge passes". Bring numbers.
5. **Performance was measured on demo data.** "0.4 seconds" means nothing until you know the real volumes (BO-10).
6. **The same word means several things.** File, shipment, booking. Vehicle. Status. Hold. Posted. Use the Glossary's term every time, even when the owner does not.
7. **Terms with ⚑ are not settled.** Do not teach them as fact.
8. **The two documents disagree with each other** in at least 18 places (the DOC list). If an owner quotes one, check the other.
9. **The process has no beginning and no end.** Nothing covers loading existing data before day one (BO-12), or payments and supplier bills after the invoice (AC-08, AC-09). Owners will assume these exist.
10. **Trucking, RORO and dispatch cannot be billed** (AC-17). Operations will assume they can.
11. **Proposed answers are yours, not theirs.** 93 questions each have a column called "Proposed". It is easy to start believing them. Do not read them out as the plan.
12. **You may be told it is already live.** The SAD mentions a "live site" (Q2). If staff are using it with real shipments, some "requirements" questions are really incident questions. Find out first.
13. **The four owners have no names yet** (Q1). Until they do, nobody can decide anything.

## 12. Per-session cheat sheets

### Internal triage

| | |
|---|---|
| **Leave with** | 1 Four owners named. 2 Every question routed. 3 Engineering's facts written down. 4 Workshop dates. 5 Worked examples promised (TL-10). |
| **Be fluent in** | Must / Should / Could · Built / Partial / Planned · the difference between a fact and a decision |
| **Most likely to derail** | Engineers explaining why each gap "isn't really a gap". Log it; move on. |

### Workshop 1: Operations

| | |
|---|---|
| **Leave with** | 1 The confirmed word for the core record. 2 The fields required before submit. 3 The rule for edits after approval. 4 The cancellation rule. 5 How consolidations are billed *today* (a fact, for Accounting). |
| **Be fluent in** | Operation Status · MAWB and HAWB · Chargeable Weight |
| **Most likely to derail** | A long tour of everything wrong with the old way of working. Note it as as-is facts and steer back with "and for the next step?" |

### Workshop 2: Accounting

| | |
|---|---|
| **Leave with** | 1 One invoice per consolidation, or one per house. 2 The exchange rate rule. 3 The VAT rules. 4 Whether void-and-reissue is acceptable. 5 What is in scope after the invoice. |
| **Be fluent in** | Sell Line and Cost Line · Trial Post and Post · Period and Month-end Close |
| **Most likely to derail** | Tax detail. You are not the tax expert and must not become one in the room. Write down what they tell you, ask "what must the invoice show?", and move on. |

### Workshop 3: Business owner

| | |
|---|---|
| **Leave with** | 1 A decision on each of the four unfinished Must items. 2 The Self-approval rule. 3 Who may post. 4 Volumes, and the two backup limits. 5 Named people for data loading, rates, training and acceptance. |
| **Be fluent in** | Role · segregation of duties · go-live readiness |
| **Most likely to derail** | The date. If go-live is fixed, every answer becomes "whatever is fastest". Separate the two: "What do you need?" first, "What can wait?" second. |

### Workshop 4: Technical

| | |
|---|---|
| **Leave with** | 1 A backup routine, a date and a name. 2 A date for a practised restore. 3 A date for the security test. 4 The list of unpaged lists. 5 A date for SRS and SAD v0.2. |
| **Be fluent in** | Backup and restore · load test · what the business decided in sessions 1 to 3 |
| **Most likely to derail** | Solution design. You need names and dates, not architecture. "How long, and who?" |

## 13. Self-test

Answer without looking. The key is at the end of this section.

### Questions

1. Name the eight steps of the process in order.
2. What are the four Operation Statuses, and who can edit a file in each?
3. A manager returns a file with no note. What happens?
4. Ocean cargo: 3.2 tonnes, 5.0 m³. What is the Revenue Weight?
5. Air cargo: 2 pieces of 100 × 50 × 40 cm, 30 kg in total. What is the Chargeable Weight? Show the working.
6. A MAWB has two HAWBs: 100 kg actual / 60 kg volumetric, and 40 kg actual / 90 kg volumetric. What is the MAWB's Chargeable Weight, and why is it not 190 kg?
7. Three valid Tariffs apply: customer and lane 80.00, lane 95.00, general 110.00. Which is used? Which is used if the first expired yesterday?
8. Calculated charge 1,800.00, Minimum Charge 2,500.00. What is the Sell Line?
9. Taxable charges of 10,000.00. What are the VAT and the invoice total?
10. What is the difference between a Sell Line and a Cost Line?
11. Name the three statuses of a Bridge Item, in order. What does a Trial Post write to the Ledger?
12. Name the three Billing-to-Ledger Modes. What is the risk of the third?
13. Why is a posted Invoice voided and not edited?
14. October 2026 is closed. An accountant enters a Journal dated 31 October 2026. What happens?
15. Why can an Accountant not see a Pending file?
16. Which four Must requirements are not built?
17. Give two things the system does not cover *after* the invoice is posted.
18. What is wrong with this requirement: "The browser shall end the session after a period of inactivity"?
19. Two owners give you different answers to the same question. What do you do?
20. An owner says "yes, that's fine" to a proposed answer without discussion. What do you do before recording it?

### Answer key

1. Quote, Booking, Approval, Movement, Tracking, Billing, Bridge, Ledger and month-end.
2. Draft and For Correction: Operator, Manager, Superadmin. Pending: nobody. Approved: Manager and Superadmin (not Operators; Accountants unclear, AC-16).
3. The Return is refused. The file stays Pending.
4. 5.0 (the greater of 3.2 and 5.0).
5. Each piece: 100 × 50 × 40 = 200,000 ÷ 6000 = 33.33 kg. Two pieces: 66.67 kg. Rounded up to the next half kilo: 67.0 kg. Greater than 30 kg, so **67.0 kg**.
6. **150 kg.** Total actual 140, total volumetric 150; the greater is 150. The sum of the houses' own chargeable weights (100 + 90) is 190, but the airline charges on the totals, not on each house.
7. 80.00. If it has expired: 95.00.
8. 2,500.00.
9. VAT 1,200.00; total 11,200.00.
10. A Sell Line is a charge to the customer. A Cost Line is a cost we expect to owe a supplier. The difference is the profit.
11. Staged, Trial Verified, Posted. A Trial Post writes nothing.
12. Manual, Review, Auto. Auto posts to the books with no person checking.
13. The books are a legal record. Errors are corrected by a visible reversal and a new entry, so past figures can be trusted.
14. It is refused, and the message names 1 November 2026 as the first open date.
15. Approval comes before billing. Accountants see Approved files only, so nothing unchecked can be billed.
16. Credit note; penetration test and dependency audit; backup and restore; paging on every list.
17. Any two of: customer payments and receipts; receivables aging and statements; suppliers' actual bills and matching; profit per file.
18. No value. "A period" cannot be tested or agreed. Also "the browser" is not a Role, and nothing says whether the user is warned.
19. Write each position in one sentence, do not choose, and take both to the Business owner, who decides. Log the decision with both positions.
20. Ask for a real example ("when did that last happen?") to check they understood, then say the decision back in one sentence and get a clear yes.

**Scoring:** 17 or more, you are ready. 13 to 16, re-read the sections you missed. Below 13, repeat days 2 to 5.

## 14. Further reading

Titles only; find the current edition.

- *A Guide to the Business Analysis Body of Knowledge (BABOK Guide)*, International Institute of Business Analysis — the chapters on elicitation and on requirements analysis.
- *Software Requirements*, Karl Wiegers and Joy Beatty — writing and reviewing requirements; a good checklist of ambiguous words.
- *Specification by Example*, Gojko Adzic — using worked examples as shared requirements and tests.
- *Incoterms 2020*, International Chamber of Commerce — the trade terms.
- *The Air Cargo Tariff and Rules (TACT)*, IATA — the air freight rules, including chargeable weight.
- The local tax authority's regulations on invoicing and receipts — ask the Accounting lead which ones apply.
- Inside this pack: [GLOSSARY.md](GLOSSARY.md) for words, [PROCESS-GAP-ANALYSIS.md](PROCESS-GAP-ANALYSIS.md) for what is missing, [workshops/README.md](workshops/README.md) for how to run the room.
