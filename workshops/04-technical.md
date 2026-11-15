# Workshop 4: Technical

| | |
|---|---|
| **Owner** | Technical lead |
| **Also invite** | The engineers who wrote the SRS and SAD · whoever manages the hosting |
| **Length** | 90 minutes: opening 5 · six topics 75 · close 10 |
| **Pre-read** | The decisions from Workshops 1 to 3 in [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md) · [03 breakdown, Part B](../requirements-breakdown/03-business-and-technical.md) · [gap analysis](../PROCESS-GAP-ANALYSIS.md) cross-cutting section |
| **Ask them to bring** | Load test notes · the list of lists that are not paged · the list of credentials to rotate · hosting backup options and cost · quotes or dates for a security test |
| **You bring** | The Business owner's decisions on the four unfinished items, the volumes, and the two backup limits · the list of new requirements the business asked for |
| **Decides here** | TL-01 to TL-12 · status of DOC-01 to DOC-18 |

This session is different from the first three. The Technical lead knows the system; you know what the business decided. The aim is a **name and a date** against each item, and an honest statement of what is and is not proven.

## Carried in from Workshops 1 to 3

Write these in before the session:

- Go-live date and the decision on each of the four unfinished items (BO-01): ______
- Volumes: jobs a month, staff at once, growth (BO-10): ______
- Most work that may be lost; longest time without the system (from BO, for TL-01): ______
- Exchange rate rule (AC-03): ______
- Password and idle time-out expectations (for TL-11): ______
- New requirements the business asked for (candidate requirements now agreed): ______

## Opening (5 min)

**Say:** "Thank you for making the time. The three business owners have now told me how they work and what they need. I want to go through what that means for the build: what is already there, what is not proven yet, and who will do what by when."

**Say:** "Where the business asked for something that is hard or expensive, please say so plainly. I would rather take that back to them now than find out later."

---

### Topic 1 — Backup, restore and capacity (20 min) · TL-01, TL-02
**As-is — ask first:** "If the production data were damaged this afternoon, what exactly would you do, and what would be lost?"
**Listen for:** whether any copy exists today; whether a restore has ever been tried; what the host offers; how many people can save at once before the system slows or refuses.
**Show:** the Business owner's two limits and the volume figures.
**Say:** "The business has said it can afford to lose at most ______ of work and be without the system for at most ______. It expects ______ jobs a month and ______ staff working at once."
**Ask:**
1. "What backup routine will meet those two limits, for both sets of data, and when will it be in place?" → TL-01
2. "When will a restore be practised from start to finish, with the books checked afterwards? Who does it?" → TL-01
3. "What did the load tests show, in plain numbers? At the business's volumes, does it cope, and with how much room?" → TL-02
4. "At what point would the present way of storing data have to be replaced? What is the warning sign?" → TL-02
**If no view — offer:** the Proposed answers for TL-01 and TL-02. Say they are proposals.
**Record:** the backup routine, a date and a name · the date of the first practised restore · load test figures against the business's volumes.
**Probe if time:** where backups are kept; who is told when one fails.

### Topic 2 — Security before go-live (15 min) · TL-03, TL-04, TL-05, TL-11, TL-12
**As-is — ask first:** "What security checking has been done so far, by whom, and what has not been looked at by anyone outside the team?"
**Listen for:** self-checks only; any known weaknesses; credentials that were shared during the build.
**Show:** the Business owner's decision on the security test.
**Say:** "The business has decided the independent security test ______ before go-live."
**Ask:**
1. "Who will carry out the security test and the review of third-party components, and on what dates?" → TL-03
2. "Are the data files encrypted where they are stored? If you do not know, who can find out?" → TL-04
3. "Which passwords and keys were used during the build, who changes them, and when?" → TL-05
4. "What are the password rules today: shortest length, kinds of character, how many old passwords are remembered? How long before an idle screen signs out? When the lock starts after five wrong attempts, is it from the first or the fifth?" → TL-11
5. "Which kinds of file may be attached, and are they checked for anything harmful?" → TL-12
**If no view — offer:** the Proposed answers for TL-03, TL-04 and TL-05.
**Record:** names and dates · the actual values for TL-11, to go back to the Business owner for confirmation.
**Probe if time:** who can sign a user out everywhere if a laptop is lost.

### Topic 3 — Long lists and speed at real volumes (10 min) · TL-06
**As-is — ask first:** "Which screens do you expect to slow down first as the data grows?"
**Listen for:** lists that load everything; screens never tried with a large amount of data.
**Show:** the speed figures from the rehearsal, and the business's volumes.
**Say:** "The speed figures in the document were measured on demonstration data. The business needs to know what to expect at its own volumes."
**Ask:**
1. "Which lists still load everything at once? When will each be fixed?" → TL-06
2. "Can the speed measurements be repeated on data the size the business expects in two years?" → TL-06
**If no view — offer:** the Proposed answer for TL-06.
**Record:** the list, with a date for each · a date for repeating the measurements.
**Probe if time:** speed on a phone on a mobile connection, for dispatch staff.

### Topic 4 — Testing and examples the business can read (10 min) · TL-07, TL-10
**As-is — ask first:** "Which parts of the system would you be least surprised to see fail in front of a customer?"
**Listen for:** modules with no automated checks; things skipped in the rehearsal; honesty about unknowns.
**Show:** the rehearsal's list of things not covered.
**Say:** "The rehearsal did not cover the status update screens, the vehicle inspection screen, keyboard use or what happens when the server fails. Vehicles, trucking and delivery runs have no automated checks."
**Say:** "The business cannot confirm a rule from the name of an automated check. They confirmed these worked examples: ______. I need the same for the remaining rules."
**Ask:**
1. "Who will test the areas the rehearsal skipped? QA can write manual tests; will the end-to-end scripts join the automated checks?" → TL-07
2. "Can you give three to five worked examples with real numbers for each main rule: charges, invoice numbers, posting, air weights?" → TL-10
3. "Can you give one real example of a file number for each kind of shipment, an invoice reference and an invoice number?" → TL-10
**If no view — offer:** the Proposed answers for TL-07 and TL-10.
**Record:** who tests what · a date for the worked examples.
**Probe if time:** a test stage where owners see a change before users do.

### Topic 5 — Dates, time zone and money (10 min) · TL-08, TL-09
**As-is — ask first:** "When the system stamps a date on an invoice or decides which month an entry belongs to, which clock is it using?"
**Listen for:** whether anyone has checked; behaviour near midnight and at month-end.
**Show:** the Accounting lead's exchange rate rule.
**Say:** "The Accounting lead has decided the exchange rate rule: ______. Invoice numbers restart each month and the books close by month, so the clock matters."
**Ask:**
1. "Where does the exchange rate come from today, and is a rate fetched by the user's own screen ever used on an invoice or in the books?" → TL-08
2. "What would it take to fetch the rate centrally and keep it with the invoice, as Accounting asked?" → TL-08
3. "Which time zone is used for dates, for the daily and monthly numbering, and for closing a month? Can it be fixed to Manila time?" → TL-09
**If no view — offer:** the Proposed answers for TL-08 and TL-09.
**Record:** the present behaviour as a fact · effort and date for the change.
**Probe if time:** how amounts are rounded when dollars become pesos, and whether VAT is rounded per line or on the total.

### Topic 6 — Fixes for the next version of the documents (10 min) · DOC-01 to DOC-18
**As-is — ask first:** "Who will issue the next version of the two documents, and when?"
**Listen for:** whether anyone owns the documents; whether they will be kept up to date after this.
**Show:** section F of [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md) with the triage marks: "Fix now" or "Waits for".
**Say:** "Each of these is a place where the two documents disagree, leave something out, or use a word without defining it. Most now have an answer from the business."
**Ask:**
1. Go down the list one by one. For each: "Fixed, will be fixed by a date, or still waiting on an answer?"

| ID | In short | Status today | Date |
|---|---|---|---|
| DOC-01 | Accountant read-only or may edit | | |
| DOC-02 | Self-approval priority | | |
| DOC-03 | Connectors "required" but optional | | |
| DOC-04 | Dispatcher is not a role | | |
| DOC-05 | Several companies, one set of books | | |
| DOC-06 | Release readiness statement | | |
| DOC-07 | House bill of lading | | |
| DOC-08 | Two revisions numbered 0.1 | | |
| DOC-09 | Undefined words | | |
| DOC-10 | VAT rule in the wrong group | | |
| DOC-11 | Acceptance examples owners can read | | |
| DOC-12 | Speed measured on demonstration data | | |
| DOC-13 | Viewer's access to the books | | |
| DOC-14 | Managers and user administration | | |
| DOC-15 | No Operations lead sign-off line | | |
| DOC-16 | Who maintains rates | | |
| DOC-17 | Three planned items missing from the design trace | | |
| DOC-18 | Requirements with no owner | | |

2. "The business agreed these new requirements: ______. Which can be in the next version, and which need estimating first?"
**If no view — offer:** the Proposed fix beside each item in the log.
**Record:** a status and date for each · the target date for version 0.2 of both documents.
**Probe if time:** adopting the refined statements from the [requirements breakdown](../requirements-breakdown/README.md) in place of the original wording.

---

## Close (10 min)

1. **Read back** every name and date. Ask: "Is that realistic?"
2. **Anything that cannot be met:** list it, with the reason, to take back to the Business owner before the play-back.
3. **Parking lot:** who answers each item and by when.
4. **Next step — say:** "You will have my notes tomorrow. At the play-back I will read the decisions to all four of you together and ask for sign-off on the description. After that, your team issues version 0.2."

## Questions covered

| Topic | Decided here | Uses a decision from |
|---|---|---|
| 1 | TL-01, TL-02 | BO-10, BO-01 |
| 2 | TL-03, TL-04, TL-05, TL-11, TL-12 | BO-01 |
| 3 | TL-06 | BO-10 |
| 4 | TL-07, TL-10 | |
| 5 | TL-08, TL-09 | AC-03 |
| 6 | DOC-01 to DOC-18 | all sessions |
