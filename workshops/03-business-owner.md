# Workshop 3: Business owner

| | |
|---|---|
| **Owner** | Business owner |
| **Also invite** | The system administrator · the Technical lead for topics 1 and 5 · one engineer |
| **Length** | 90 minutes: opening 5 · seven topics 75 · close 10 |
| **Pre-read** | [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) sections 3, 5 and 6 (V-57 to V-61, the "not done today" list, decisions D-1 to D-10) |
| **Ask them to bring** | The intended go-live date · rough volumes: jobs a month, staff who will use the system · the list of offices |
| **You bring** | The decisions from Workshops 1 and 2, written into this script · [03 breakdown, Part A](../requirements-breakdown/03-business-and-technical.md) · [gap analysis, top ten](../PROCESS-GAP-ANALYSIS.md) · cost and date for each unfinished item, from Engineering |
| **Decides here** | BO-01 to BO-14 · AC-15 · AC-18 |

## Carried in from Workshops 1 and 2

Write these in before the session:

- Operations on one-person offices (for BO-02): ______
- Operations on whether offices work separately (for BO-04): ______
- Operations' concerns about the public page (for BO-07): ______
- Accounting's view on who may post (for AC-15): ______
- Accounting's view on who enters rates, and how many there are (for AC-18): ______
- The legal retention period, from Accounting (for BO-11): ______
- Anything the two leads disagreed on: ______

## Opening (5 min)

**Say:** "Thank you for making the time. I have met Operations and Accounting. Most of how the work is done is now clear. What is left are decisions only you can make: what must be ready before we go live, who is allowed to do what, and a few points where the two teams need you to choose."

**Say:** "For each one I will tell you what the system does today and what your leads told me, then ask for your decision. If you need more information before deciding, say so and I will get it."

**Say:** "I will not recommend an answer unless you ask me to."

---

### Topic 1 — What must be ready before go-live (15 min) · D-1, N-01 to N-04 · BO-01
**As-is — ask first:** "Is there a date you have in mind for starting to use the system for real work? What is driving that date?"
**Listen for:** whether the date is fixed or flexible; what happens if it slips; whether staff are already using it.
**Show:** [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) section 6, decision D-1, with Engineering's effort and date for each item.
**Say:** "The engineering document marks some items as required for release. Four of those are not finished: the credit note; an independent security test; a routine backup with a practised way to restore; and loading long lists a page at a time."
**Say:** "Of the four, the backup is the one that protects everything else. Today, if the data were lost or damaged, there is no routine copy to go back to."
**Ask:**
1. "For each of the four: must it be done before go-live, or may it follow by a stated date?" → BO-01
2. "Who signs when one of these is postponed?" → BO-01
**If no view — offer:** the Proposed answer for BO-01. Say it is a proposal.
**Record:** a decision and a date for each of the four · who signs a postponement.
**Probe if time:** the wider "not done today" list, N-05 to N-19: which of these would stop you going live?

### Topic 2 — Controls: who may do what (15 min) · D-2, D-7, V-18, V-50, V-57, V-58 · BO-02, BO-14, AC-15
**As-is — ask first:** "Today, before a job is billed, who checks it? And could the same person book a job, approve it and enter it in the books?"
**Listen for:** how much they rely on separate people checking each other; past problems; what auditors have asked for.
**Show:** the role table in [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) section 3. Point to each **?**.
**Say:** "Today a manager can approve a file that the same manager submitted. A manager also has the accounting functions. So one person could book a job, approve it and send it to the books."
**Say:** "The documents do not say which roles may delete records, or who may read the record of who changed what."
**Ask:**
1. "May a manager approve their own file? If not, what happens in an office with one manager?" → BO-02
2. "Who may send amounts to the books: accountants only, or managers too? May the person who approved a file also post it?" → AC-15
3. "Who may delete records, and which records may never be deleted?" → BO-14
4. "Who may read the record of who changed what?" → BO-14
**If no view — offer:** the Proposed answers for BO-02 and AC-15, with what each lead said. Say they are proposals.
**Record:** each decision in one sentence · every **?** in the role table filled in.
**Probe if time:** who may add users and change roles; what happens if the only administrator is away.

### Topic 3 — Companies and branches (8 min) · V-56, V-59 · BO-03, BO-04
**As-is — ask first:** "How is the business organised: one company or several, and how many offices? Do the offices keep their work separate?"
**Listen for:** plans for sister companies; whether a manager in one office should see another's files; whether accounts are kept per office.
**Show:** the carried-in notes from Operations.
**Say:** "Today the system could hold more than one company, each seeing only its own records. But the books exist for one company only. Offices appear on the map and nowhere else: every user sees every file of the company."
**Ask:**
1. "Will more than one company use the system? If so, when?" → BO-03
2. "Should users, files or approvals be limited to an office?" → BO-04
**If no view — offer:** the Proposed answer for BO-03.
**Record:** one company or several · whether offices are a boundary.
**Probe if time:** reporting per office.

### Topic 4 — Customers, the public and passwords (10 min) · V-31 to V-33, V-60, V-61 · BO-05, BO-06, BO-07, BO-08
**As-is — ask first:** "How do customers find out where their cargo is today? What would you not want a competitor to be able to find out?"
**Listen for:** how sensitive customer names and routes are; how much customers ask for a login; tolerance for staff waiting on a password reset.
**Show:** the public lookup in the demo copy, with a real-looking reference. Show exactly what appears.
**Say:** "Today anyone who knows or guesses a reference number can see that shipment's status, without signing in. The exact list of what is shown has never been written down. Here is what appears today: ______."
**Say:** "Customers cannot sign in. Staff who forget their password cannot reset it themselves: they send a help request and wait for an administrator."
**Ask:**
1. "Which of these details may the public see? Is it acceptable that a guessed number shows a status?" → BO-07
2. "Do customers need their own sign-in on day one, or is the public page enough?" → BO-05
3. "Is it acceptable that a forgotten password needs an administrator?" → BO-06
4. "Barcode scanners, signature pads, label printers, government filing and carrier connections do not exist yet. Are any needed on day one?" → BO-08
**If no view — offer:** the Proposed answers for BO-05, BO-06, BO-07 and BO-08.
**Record:** the list of public details, item by item · decisions on the other three.
**Probe if time:** password rules and how long an idle screen stays signed in (TL-11): ask what they are comfortable with.

### Topic 5 — Being ready on day one (12 min) · D-8, D-9, N-10, N-18, N-19 · BO-09, BO-10, BO-12, BO-13, AC-18
**As-is — ask first:** "On the first morning of real use, what must already be in the system for staff to do their jobs?"
**Listen for:** open jobs in progress; customer list; rates; opening balances; who would prepare each; whether staff have been trained.
**Show:** [Stakeholder Summary](../STAKEHOLDER-SUMMARY.md) section 6, decisions D-8 and D-9.
**Say:** "Today there is no plan for loading existing customers, open jobs, rates or the opening balances of the books. The rate tables are mostly empty. Speed has been measured on demonstration data only."
**Say:** "Two housekeeping items are waiting for you: a clean-up of old entries in the books that has been tested but not run, and an earlier copy of the system that was stopped but not removed."
**Ask:**
1. "What existing data must be loaded, who prepares it, and on what date do we switch over?" → BO-12
2. "Who enters the rates, and by when?" → AC-18
3. "Roughly how many jobs a month, how many staff at once, and how much growth in two years?" → BO-10
4. "How much work could you afford to lose, and how long could you be without the system?" → feeds TL-01
5. "Who trains the staff, and who signs to say each area works?" → BO-13
6. "When may the clean-up run, and may the old copy be removed?" → BO-09
**If no view — offer:** the Proposed answers for BO-09 and BO-13.
**Record:** names and dates · the volume figures · the two limits (data lost, time down) for session 4.
**Probe if time:** a trial period running the old way and the new way side by side.

### Topic 6 — Keeping records (5 min) · BO-11
**As-is — ask first:** "How long do you keep shipping files and accounting papers today, and why that long?"
**Listen for:** legal periods; customer contracts; storage habits.
**Show:** the retention period Accounting gave.
**Say:** "Today nothing in the system says how long records are kept, or whether they may ever be removed."
**Ask:**
1. "How long must records be kept, and may anything be removed or archived after that?" → BO-11
**If no view — offer:** the Proposed answer for BO-11.
**Record:** the period, per kind of record if it differs.
**Probe if time:** who may ask for a customer's records to be removed.

### Topic 7 — Points your leads need you to settle (10 min) · carried items
**As-is — ask first:** "Before I list them: is there anything from your leads' sessions that you have already heard about and want to raise?"
**Listen for:** disagreements already escalated informally.
**Show:** the carried-in list at the top of this script. For each disagreement, one sentence per position.
**Say:** "On these points Operations and Accounting each gave me an answer, and the answers differ. I will read both. I am not recommending either."
**Ask:**
1. For each carried disagreement: "Which way do you want it?" → the question ID noted beside it
2. "The posting mode on day one: Accounting asked for ______. Do you agree?" → confirms AC-13
3. "Nobody has been named to confirm that the screens are usable, or to confirm the assumptions the engineers made. Who should that be?" → DOC-18
**If no view — offer:** nothing. If they cannot choose, ask what they need to know, and park it with a date.
**Record:** each decision with both positions.
**Probe if time:** anything in the pre-read they marked ✖ or ? that has not come up.

---

## Close (10 min)

1. **Read back** every decision, one sentence each. Ask: "Is that right?"
2. **Parking lot:** agree who answers each item and by when.
3. **Carried to the Technical lead:** the go-live decisions on the four unfinished items, the volumes, and the two limits for backup.
4. **Next step — say:** "You will have my notes tomorrow. After the technical session there is a half-hour play-back with all four of you, where I read the decisions back and ask for sign-off on the description."
5. **Ask:** "Is there a decision you expected me to ask for that I did not?"

## Questions covered

| Topic | Decided here | Confirmed or fed forward |
|---|---|---|
| 1 | BO-01 | |
| 2 | BO-02, BO-14, AC-15 | |
| 3 | BO-03, BO-04 | |
| 4 | BO-05, BO-06, BO-07, BO-08 | TL-11 |
| 5 | BO-09, BO-10, BO-12, BO-13, AC-18 | TL-01 |
| 6 | BO-11 | |
| 7 | carried items | AC-13, DOC-18 |
