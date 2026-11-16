# Workshop 1: Operations

| | |
|---|---|
| **Owner** | Operations lead |
| **Also invite** | An operator who books ocean files · an operator who handles air consolidations · a manager who approves · a dispatcher or trucking coordinator · one engineer |
| **Length** | 90 minutes: opening 5 · eight topics 75 · close 10 |
| **Pre-read** | [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) steps 1 to 5 (V-01 to V-34) · [Glossary](../GLOSSARY.md) section 2 |
| **Ask them to bring** | Their last three files · one real consolidation (manifest, house waybills) · a file that was sent back · a delivery sheet with a signed proof of delivery |
| **You bring** | Demo copy open on: new booking, a Pending file, a consolidation, the vehicle list, the public lookup · [01-operations breakdown](../requirements-breakdown/01-operations.md) · [facilitation rules](README.md) |
| **Decides here** | OP-01 to OP-18, except OP-11 |
| **Consulted here, decided elsewhere** | AC-01, OP-11, AC-17 (Accounting) · BO-02, BO-04, BO-07 (Business owner) |

## Opening (5 min)

**Say:** "Thank you for making the time. The engineering team wrote down what the system does by reading the software. Nobody has yet asked you whether that matches how you work. That is what today is for."

**Say:** "For each part of the process I will first ask how you do it today. Then I will show you what the system does, and ask whether it fits. Nothing you say today is a commitment. You will get my notes tomorrow to correct, and you only sign once you are happy."

**Say:** "If something you do every day is missing from what I show you, please stop me. That is the most useful thing you can tell me."

**Check:** did they read and mark up the pre-read? If not, allow two minutes on the one-page process picture.

---

### Topic 1 — Words we use (5 min) · V-07 · OP-01
**As-is — ask first:** "When you pick up the phone about a job, what do you call it? A file, a shipment, a booking? And what is its number called?"
**Listen for:** the word they actually use. Whether "booking number" means their own number or the carrier's. What they call a customer's vehicle and a company truck.
**Show:** [Glossary](../GLOSSARY.md) section 2 and section 5.
**Say:** "In the documents, the same record is called a file, a shipment and a booking. We would like to settle on one word."
**Ask:**
1. "Which word do your staff use?" → OP-01
2. "The word vehicle is used for a customer's car being shipped and for our own trucks. What do you call each?" → OP-01
**If no view — offer:** the Proposed answer for OP-01. Say it is a proposal.
**Record:** the confirmed terms · any local word to add to the Glossary's "You may know it as" column.
**Probe if time:** words used on printed documents that customers see.

### Topic 2 — From quote to booking (10 min) · V-01 to V-07 · OP-13, OP-14, OP-15, OP-08
**As-is — ask first:** "Take the last job you booked. How did it start? Was there a quote? How did you know the customer had said yes?"
**Listen for:** whether quotes are formal at all. How acceptance is shown (email, signature, phone). What information they have at booking and what arrives later.
**Show:** the new booking form in the demo copy; Stakeholder Summary steps 1 and 2.
**Say:** "Today the system keeps quotes as draft, sent, accepted, rejected or expired. An accepted quote can become a file, and then its prices are used on the invoice in place of the standard rates."
**Say:** "A file is either ocean or air, and export, import or domestic. The system gives it a number of its own that is never used again."
**Ask:**
1. "Who should mark a quote as accepted, and what should be kept as proof?" → OP-14
2. "Does a quote run out on a date, or does someone close it?" → OP-14
3. "What is a domestic job for you? Is a trucking-only job a file?" → OP-13
4. "Before a file goes for approval, which details must be filled in? Which dates? Is it different for air, ocean and consolidations?" → OP-15
5. "Do files ever arrive from another system or a spreadsheet, not typed in?" → OP-08
**If no view — offer:** the Proposed answers for OP-15 and OP-08.
**Record:** the required fields per kind of file, as a list · as-is facts about quotes.
**Probe if time:** jobs booked before all details are known; bookings changed by the carrier.

### Topic 3 — Approving a file (15 min) · V-14 to V-21 · OP-02, OP-05, OP-12, OP-16, OP-18
**As-is — ask first:** "Walk me through what happens today between a booking being typed up and it being billed. Who checks it, and what do they look at?"
**Listen for:** who really checks; what they check; how they find out a file is waiting; how long it takes; what happens when the checker is away; whether the checker ever books files too.
**Show:** a Pending file in the demo copy; then return it with a note.
**Say:** "Today, once an operator submits a file, nobody can change it until a manager approves it or sends it back with a note. Once approved, it is released for billing and operators can no longer change it."
**Say:** "After approval, a manager can still change the file. The charges are worked out again, and nobody is asked to approve it a second time."
**Ask:**
1. "If a manager changes the weight or a charge after approving, should someone check it again?" → OP-02
2. "How quickly does a file need a decision? Who covers when the approver is away?" → OP-12
3. "How should a manager find out a file is waiting, and an operator that one came back?" → OP-16
4. "Operators can change each other's drafts. Is that how you want it? Who agreed to it?" → OP-05
5. "Files that existed before this approval step count as approved. Should anyone look at them before they are billed?" → OP-18
6. "In your smallest office, is there someone other than the person who booked the file who could approve it?" → consult for BO-02
**If no view — offer:** the Proposed answers for OP-02, OP-16 and OP-18. Say they are proposals.
**Record:** each decision in one sentence · the as-is approval steps · the one-person-office facts for the Business owner.
**Probe if time:** rush shipments; a file approved by mistake; a file sent back three times.

### Topic 4 — Consolidations and documents (10 min) · V-08 to V-12 · OP-07, OP-09, OP-11
**As-is — ask first:** "Show me your last consolidation. How many houses? Who received which document, and who was billed?"
**Listen for:** how many houses is normal and the most they have had; whether each house customer gets their own invoice; which documents are legally theirs to issue; how arrival notices are sent.
**Show:** a consolidation in the demo copy; print a manifest and one arrival notice.
**Say:** "Today one master air waybill carries many house air waybills, typed as rows on one screen. The system adds up pieces and weight, and prints the manifest, the master, each house and one arrival notice per house."
**Say:** "For the master, the chargeable weight is the greater of the total actual weight and the total volume weight. With one house at 100 kilos actual and 60 volume, and another at 40 actual and 90 volume, the master is charged on 150 kilos, not 190."
**Ask:**
1. "Do you issue your own house bills as the carrier of record? Which printed documents must follow a set legal or carrier format?" → OP-07
2. "Do arrival notices need to be emailed from the system on day one?" → OP-09
3. "On a consolidation invoice, what would you expect to see as the house number?" → consult for OP-11 (Accounting decides it with AC-01)
4. "Today, is a consolidation billed as one invoice or one per house customer?" → as-is only, consult for AC-01
**If no view — offer:** nothing for OP-07 (it is a fact); OP-11 follows the Accounting lead's decision.
**Record:** the list of documents with a required format · as-is billing of consolidations, for session 2.
**Probe if time:** a house added after the master is approved; duplicate house numbers.

### Topic 5 — RORO vehicles (8 min) · V-22 to V-24 · OP-17
**As-is — ask first:** "When a customer's vehicle arrives for shipping, what do you record, and what can stop it from being loaded?"
**Listen for:** the real reasons a vehicle is held; who can release it; what papers are needed; whether vehicles are mostly US-registered.
**Show:** the vehicle list in the demo copy, filtered by hold.
**Say:** "Today each vehicle moves through expected, received, ready to ship, pre-loaded, loaded and shipped, or it is put on hold. Separately there is a title status, a customs hold marker and a lien release marker. Nothing says who sets these or whether they stop a vehicle being shipped."
**Ask:**
1. "Who may put a vehicle on hold, and who may release it?" → OP-17
2. "Should a customs hold or a missing title stop the vehicle being marked as loaded?" → OP-17
3. "The automatic lookup of vehicle details only works for US-format numbers. Is that acceptable?" → OP-17
**If no view — offer:** there is no proposal; this needs their rule.
**Record:** the hold rules in their words.
**Probe if time:** damage found at intake; a vehicle that misses its vessel.

### Topic 6 — Trucking and deliveries (10 min) · V-25 to V-29 · OP-04, OP-10
**As-is — ask first:** "Take yesterday's deliveries. Who planned them, who drove, and how do you know each one was delivered?"
**Listen for:** whether the dispatcher is a separate job; whether outside truckers are used; what "equipment" means to them; how proof of delivery is kept today; how trucking is charged.
**Show:** a cartage order and a dispatch route in the demo copy.
**Say:** "Today the system records pickup and delivery orders, and delivery runs with one driver, one truck and several stops. A delivery signature can only be captured on a signature pad, and no pad is connected, so no proof of delivery is captured in the system."
**Ask:**
1. "Is dispatcher a separate job from the staff who book files? Do they need to do anything those staff must not, or the other way round?" → OP-04
2. "Until signature pads exist, what would you accept as proof of delivery?" → OP-10
3. "Which of these services do you charge customers for: trucking, vehicle shipping, delivery runs?" → as-is, consult for AC-17
4. "Do your offices work separately? Should staff in one office see or approve another office's files?" → consult for BO-04
**If no view — offer:** the Proposed answers for OP-04 and OP-10.
**Record:** decisions · the list of chargeable services for session 2 · office structure for session 3.
**Probe if time:** a delivery refused at the door; a driver swapped mid-route.

### Topic 7 — Tracking and the public lookup (8 min) · V-30 to V-34 · OP-06
**As-is — ask first:** "When a customer calls to ask where their cargo is, what do you do?"
**Listen for:** where the answer comes from today; how fresh it is; what customers are and are not told.
**Show:** the public lookup in the demo copy; look up a house number.
**Say:** "Today staff type in every status update by hand. Anyone who enters a file, booking, waybill, master or house number on the public page sees the status and the updates, without signing in."
**Ask:**
1. "Who should enter status updates, and how soon after the event?" → OP-06
2. "Do you need updates to arrive from carriers automatically?" → OP-06
3. "Looking at this public page, is there anything a customer or a competitor should not see?" → consult for BO-07
**If no view — offer:** there is no proposal for OP-06; ask what is realistic for their staff.
**Record:** who enters updates and by when · concerns about the public page for session 3.
**Probe if time:** a wrong update that a customer has already seen.

### Topic 8 — Cancellations and things that go wrong (9 min) · V-20 · OP-03
**As-is — ask first:** "Tell me about the last job that was cancelled after it was booked. What did you do with the paperwork and the charges?"
**Listen for:** how often it happens; at what stage; whether cancellation charges apply; who decides.
**Show:** Stakeholder Summary step 3, the item on cancelling.
**Say:** "Today there is no way to cancel a file. A file is a draft, waiting, sent back or approved. A cancelled job that was already approved stays approved and can still be billed."
**Ask:**
1. "How should a cancelled job be marked, and who may do it?" → OP-03
2. "Does a cancelled job ever still need an invoice, for example a cancellation fee?" → OP-03
**If no view — offer:** the Proposed answer for OP-03.
**Record:** the cancellation rule · any other exception they raise, as a new question.
**Probe if time:** a shipment split in two; cargo rolled to the next vessel; a customer changed after booking.

---

## Close (10 min)

1. **Read back** every decision from the note-taker's list, one sentence each. Ask: "Is that right?"
2. **Parking lot:** read each item, agree who answers it and by when.
3. **Carried to other sessions:** tell them what you will take to Accounting (how consolidations are billed today; which services are charged) and to the Business owner (one-person offices; the public page; branches).
4. **Next step — say:** "You will have my notes tomorrow. Please correct anything by the date on them. After all four sessions there is a half-hour play-back where everyone hears the decisions together."
5. **Thank the practitioners.** Ask whether you may come back to them with follow-up questions.

## Questions covered

| Topic | Decided here | Consulted here |
|---|---|---|
| 1 | OP-01 | |
| 2 | OP-13, OP-14, OP-15, OP-08 | |
| 3 | OP-02, OP-05, OP-12, OP-16, OP-18 | BO-02 |
| 4 | OP-07, OP-09 | AC-01, OP-11 |
| 5 | OP-17 | |
| 6 | OP-04, OP-10 | AC-17, BO-04 |
| 7 | OP-06 | BO-07 |
| 8 | OP-03 | |
