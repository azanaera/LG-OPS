# Requirements Breakdown 3: Business owner and Technical lead

**Confirmed by:** Business owner (Part A, 11 requirements) · Technical lead (Part B, 39 requirements) · **Method:** [README.md](README.md)

> Every statement below describes what the system **currently does** according to SRS v0.1 and SAD v0.1. Nothing here is agreed until its "Confirmed" box is ticked and the answer is in [OPEN-QUESTIONS.md](../OPEN-QUESTIONS.md).
>
> Part B is technical. Each entry starts with **"In plain words"** so that QA can explain it to a non-technical owner. Interface, non-functional and data requirements use a fit table (measure, target, how measured) in place of worked examples.

---

# Part A — Business owner

## Roles and access (FR-AU-09 to 12, NFR-SE-05)

### FR-AU-09 Five Roles
**Source (SRS, verbatim):** "The system shall support five roles: superadmin, manager, operator, accountant and viewer."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AU-09.1 | Every User holds exactly one Role: Superadmin, Manager, Operator, Accountant or Viewer. | (system) | ☐ |
| FR-AU-09.2 | What each Role may do is as in the permission matrix below. | (system) | ☐ |

**Worked example: the permission matrix as documented.** `✔` allowed · `✖` refused · `R` read only · `?` not stated or contradictory — **needs your decision**.

| Action | Superadmin | Manager | Operator | Accountant | Viewer | Question |
|---|:-:|:-:|:-:|:-:|:-:|---|
| Create or edit a Draft or For Correction file | ✔ | ✔ | ✔ | ✖ | ✖ | |
| Submit a file | ✔ | ✔ | ✔ | ✖ | ✖ | |
| Edit a Pending file | ✖ | ✖ | ✖ | ✖ | ✖ | |
| Approve or return a file | ✔ | ✔ | ✖ | ✖ | ✖ | |
| Approve a file they submitted themselves | ✔ today | ✔ today | n/a | n/a | n/a | BO-02 |
| Edit an Approved file | ✔ | ✔ | ✖ | ? | ✖ | AC-16, OP-02 |
| See files that are not yet Approved | ✔ | ✔ | ✔ | ✖ | R | |
| Trial Post and Post Bridge Items | ✔ | ? | ✖ | ✔ | ✖ | AC-15 |
| Ledger: Vouchers, Journals, Month-end Close | ✔ | ✔ | ✖ | ✔ | ✖ | AC-15 |
| Read the Ledger and its reports | ✔ | ✔ | ✖ | ✔ | ? | DOC-13 |
| Create, change and deactivate Users | ✔ | ? | ? | ? | ✖ | DOC-14, BO-14 |
| Change a Superadmin account | ✔ | ✖ | ✖ | ✖ | ✖ | |
| Change Company settings, including the Billing-to-Ledger Mode | ✔ | ? | ? | ? | ✖ | BO-14, AC-13 |
| Delete records | ? | ? | ? | ? | ✖ | BO-14 |
| Read the audit trail | ? | ? | ? | ? | ? | BO-14 |

**Not stated — ask:** whether five Roles are enough: a dispatcher is named as a process owner but is not a Role (OP-04). Whether a person can hold two Roles. Whether Roles should differ by Branch ⚑ (BO-04).

### FR-AU-10 Role checked on every action
**Source (SRS, verbatim):** "The server shall check the role of the signed-in user on every protected route."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AU-10 | Every action is checked against the User's Role by the system itself, not only by hiding buttons on the screen. | (system) | ☐ |

**Worked examples**
- *Given* an Operator who has no "Approve" button, *when* an approve request is sent anyway by other means, *then* it is refused.
- *Given* a Manager, *when* they approve a Pending file, *then* it is accepted.

**Not stated — ask:** nothing beyond the `?` cells in the matrix above.
**Engineering check:** check:security user policy; route tests.

### FR-AU-11 Viewer cannot change anything
**Source (SRS, verbatim):** "The server shall refuse every write request from the viewer role."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AU-11 | Any attempt to create, change or delete a record is refused. | Viewer | ☐ |

**Worked examples**
- *Given* a Viewer, *when* they try to add a Milestone, *then* it is refused.
- *Given* a Viewer, *when* they open a Freight File, *then* they can read it.

**Not stated — ask:** what a Viewer can read: all modules, including the Ledger and unapproved files (DOC-13). Whether a Viewer can raise a support ticket.

### FR-AU-12 Superadmin accounts are protected
**Source (SRS, verbatim):** "Only a superadmin shall change a superadmin account; a manager shall not manage superadmin accounts."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AU-12.1 | A Superadmin account can be changed only by a Superadmin. | Superadmin | ☐ |
| FR-AU-12.2 | *(Whether a Manager can change other Users at all is contradictory.)* | Manager | ☐ |

**Worked examples**
- *Given* a Manager, *when* they try to deactivate a Superadmin, *then* it is refused.
- *Given* a Manager, *when* they try to reset an Operator's password — allowed or refused? *(The documents disagree.)*

**Not stated — ask:** the SRS says Managers have "no user administration", yet this requirement implies they manage some Users (DOC-14). What happens if the only Superadmin leaves or is locked out.

### NFR-SE-05 No access to another Company's records
**Source (SRS, verbatim):** "A user shall never read or write records of a company not assigned to them, whatever identifiers are sent."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Detailed enough

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Requests for another Company's record that succeed | 0 | Ask for a record of Company B while signed in to Company A, by its exact identifier | Two test Companies | Cross-company request refused in route tests |

**Not stated — ask:** whether there will be more than one Company at all (BO-03). Whether a User can belong to several Companies and how they switch.

## Administration (FR-AD)

### FR-AD-01 Manage Users
**Source (SRS, verbatim):** "The system shall let an authorised user create, edit and deactivate users and set roles and company access."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AD-01.1 | A User can be created, edited and deactivated. | *"Authorised user" — Role not named* | ☐ |
| FR-AD-01.2 | A User's Role and Company access can be set. | *Role not named* | ☐ |
| FR-AD-01.3 | A change takes effect at the User's next action. | (system) | ☐ |

**Worked examples**
- *Given* an Operator is deactivated, *when* they next try to do anything, *then* they are refused.
- *Given* an Operator, *when* they try to create a User, *then* it is refused. *(Assumed — confirm.)*

**Not stated — ask:** which Roles are "authorised" (BO-14, DOC-14). There is no password reset: a User who forgets a password waits for an administrator (BO-06). Who approves a new User or a Role change.

### FR-AD-02 Manage Companies and settings
**Source (SRS, verbatim):** "The system shall let an authorised user maintain companies and their settings, including the billing-to-ledger mode."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AD-02.1 | A Company's details and settings can be maintained. | *Role not named* | ☐ |
| FR-AD-02.2 | The Billing-to-Ledger Mode (Manual, Review, Auto) is one of those settings and applies once saved. | *Role not named* | ☐ |

**Worked examples**
- *Given* the mode is changed from Review to Manual, *then* the next rated file is not staged. *(Assumed from "drafts only" — confirm.)*
- *Given* an Accountant, *when* they try to change the mode — allowed or refused? *(Not stated. Ask.)*

**Not stated — ask:** who may change the mode; Auto posts with no person checking (AC-13, BO-14). Whether a second Company may be created (BO-03).

### FR-AD-03 Audit trail
**Source (SRS, verbatim):** "The system shall write an audit record for every mutating request and record booking events for approval changes, and make both available to authorised roles."
**Priority / Status:** Must / Built · **Owner:** Business owner · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AD-03.1 | Every create, change and delete writes an audit record. | (system) | ☐ |
| FR-AD-03.2 | Every Submit, Approve and Return writes an event on the Freight File with the User, time, from and to status, note and image. | (system) | ☐ |
| FR-AD-03.3 | Both can be read. | *"Authorised roles" — not named* | ☐ |

**Worked examples**
- *Given* an Operator changes a Consignee, *then* an audit record shows who, when and what.
- *Given* a Manager returns a file, *then* its history shows the Return, the note and the time.

**Not stated — ask:** which Roles may read the audit trail (BO-14). How long it is kept (BO-11). Whether anyone can delete or change an audit record.

### FR-AD-04 Attachments and support tickets
**Source (SRS, verbatim):** "The system shall attach files to a record (up to 15 MB per request) and accept sign-in help requests as support tickets."
**Priority / Status:** Should / Built · **Owner:** Business owner · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AD-04.1 | A file of up to 15 MB can be attached to a record and opened from it. | Any User who can edit the record | ☐ |
| FR-AD-04.2 | A person who cannot sign in can send a help request from the sign-in page; it becomes a support ticket for administrators. | Anyone | ☐ |

**Worked examples**
- *Given* a 16 MB file, *when* it is attached, *then* it is refused.
- *Given* a help request sent from the sign-in page, *then* a ticket exists for administrators.

**Not stated — ask:** which file types are accepted and whether they are scanned (TL-12). Who handles tickets and how fast; this is the only way to get a password reset (BO-06). Whether an attachment can be removed.

### FR-AD-05 Integration status
**Source (SRS, verbatim):** "The system shall show the status of each integration (disconnected, connected or error); live connectors for barcode, label printing, government filing and carrier APIs are required."
**Priority / Status:** Could / Partial · **Owner:** Business owner · **Verdict:** Blocked

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AD-05.1 | Each integration shows a status: disconnected, connected or error. | (system) | ☐ |
| FR-AD-05.2 | *(Live connectors do not exist. Whether they are required is contradictory.)* | (system) | ☐ |

**Worked examples**
- *Given* an integration with no live connector, *then* the features that need it stay switched off (SAD §10.4).
- *Given* a connected scanner — cannot be tested: no connector exists.

**Not stated — ask:** the text says the connectors "are required" but the priority is Could. Which, if any, are needed at go-live (BO-08, DOC-03).

### FR-AD-06 Demonstration data
**Source (SRS, verbatim):** "The system shall seed demonstration data that is marked so it can be found, and shall not run the seed against production records."
**Priority / Status:** Should / Built · **Owner:** Business owner · **Verdict:** Detailed enough

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AD-06 | Demonstration records carry a marker so they can be found and removed, and the command that creates them refuses to run on production. | Administrator | ☐ |

**Worked examples**
- *Given* the demo copy, *then* its 22 demonstration Freight Files can be listed by their marker (SAD §7.13).
- *Given* the production system, *when* the demo command is run, *then* it refuses.

**Not stated — ask:** whether any demonstration records are in production today (Q2, BO-09).

---

# Part B — Technical lead

## Sign-in and sessions (FR-AU-01 to 08)

### FR-AU-01 Sign in
**Source (SRS, verbatim):** "The system shall let a user sign in with a username and password and return an access token and a refresh token."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** a User signs in with a username and password. The system then gives the browser two passes: a short-lived one used for each action, and a longer-lived one used to renew it.

**Worked examples**
- *Given* a correct username and password, *then* the User is signed in.
- *Given* a wrong password, *then* sign-in is refused and the message does not say which of the two was wrong. *(Assumed — confirm.)*

**Not stated — ask:** there is no password reset and no self-registration (BO-06).

### FR-AU-02 Stay signed in
**Source (SRS, verbatim):** "The system shall renew the access token with the refresh token while it is valid, without a new sign-in."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** while a User keeps working, they are not asked to sign in again every few minutes.

**Worked examples**
- *Given* the short-lived pass has expired and the longer one is still valid, *when* the User saves a file, *then* the save works with no new sign-in.
- *Given* both have expired, *then* the User must sign in again.

**Not stated — ask:** how long each pass lasts in production; "by configuration" gives no value (TL-13).

### FR-AU-03 Sign out
**Source (SRS, verbatim):** "The system shall revoke the refresh token on sign-out."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** after sign-out, the browser's passes no longer work, even if someone copied them.

**Worked examples**
- *Given* a User signs out, *when* the old pass is used again, *then* it is refused.
- *Given* a User closes the browser without signing out, *then* the pass stays valid until it expires. *(Assumed — confirm.)*

**Not stated — ask:** whether an administrator can sign a User out everywhere, for example when a laptop is lost.

### FR-AU-04 Lock after failed attempts
**Source (SRS, verbatim):** "The system shall block sign-in for one minute after five consecutive failed attempts."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** five wrong passwords in a row lock sign-in for one minute.

**Worked examples**
- *Given* five failed attempts between 09:00:00 and 09:00:40, *when* a sixth is made at 09:00:50, *then* it is refused even with the right password.
- *Given* the same, *when* an attempt is made at 09:01:45 with the right password, *then* it succeeds.

**Not stated — ask:** whether the block is per username or per device, and what resets the count (TL-11). Whether one minute is long enough for the business.

### FR-AU-05 Bot protection at sign-in
**Source (SRS, verbatim):** "The system shall require a solved, signed, expiring, single-use proof-of-work token before a sign-in is accepted."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** before each sign-in the browser solves a small puzzle in the background. It slows down automated password guessing. The User sees at most a short pause.

**Worked examples**
- *Given* a sign-in sent without a solved puzzle, *then* it is refused.
- *Given* a solved puzzle that was already used once, *then* it is refused.

**Not stated — ask:** how long the pause is on an older phone or office computer.
**Engineering check:** check:captcha, check:captcha-enforcement.

### FR-AU-06 Password policy
**Source (SRS, verbatim):** "The system shall enforce the password policy, including a 72-byte maximum."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Blocked
**In plain words:** passwords must meet rules. The only rule the SRS states is a maximum length of 72 bytes (about 72 ordinary characters).

**Worked examples**
- *Given* a password longer than 72 bytes, *then* it is refused.
- *Given* a password of 6 characters — accepted or refused? *(The policy is not stated.)*

**Not stated — ask:** the minimum length and character rules (TL-11). The Business owner should confirm them.
**Engineering check:** check:security.

### FR-AU-07 Password history
**Source (SRS, verbatim):** "The system shall keep a password history and refuse reuse of a recent password on change."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Blocked
**In plain words:** a User cannot change their password back to one they used recently.

**Worked examples**
- *Given* a User changes their password to the one they had just before, *then* it is refused.
- *Given* a password used ten changes ago — accepted or refused? *(How many are remembered is not stated.)*

**Not stated — ask:** how many past passwords count as "recent" (TL-11). Whether passwords expire.

### FR-AU-08 Idle time-out
**Source (SRS, verbatim):** "The browser shall end the session after a period of inactivity."
**Priority / Status:** Should / Built · **Owner:** Technical lead · **Verdict:** Blocked
**In plain words:** a User who walks away is signed out after a while.

**Worked examples**
- *Given* no activity for the idle time, *then* the User is signed out.
- *Given* a half-typed Freight File when the time runs out — is the typing lost? *(Not stated. Ask.)*

**Not stated — ask:** the idle time (TL-11). Whether the User is warned first.

## Interfaces (IFR)

### IFR-01 One shell for logistics and Ledger
**Source (SRS, verbatim):** "The system shall present one shell with navigation to the logistics suite and the ledger, and show the signed-in company and user."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** one application, one menu, and the screen always shows who is signed in and for which Company.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Company and User shown on every page | Always | Screen check at desktop and phone width | Any | Screen check |

**Not stated — ask:** whether an Operator sees Ledger menu items they cannot open.

### IFR-02 Loading, empty and error states
**Source (SRS, verbatim):** "Every list screen shall show loading, empty and error states."
**Priority / Status:** Should / Partial · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** a list never just sits blank. It says "loading", "nothing here yet" or "something went wrong".

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| List screens showing all three states | All | Check each list while loading, with no records, and with the connection cut | Empty Company; forced error | Partial — the screens that fail are not named |

**Not stated — ask:** the list of screens that do not yet comply. Forced server errors were not tested in the rehearsal (TL-07).

### IFR-03 How money is shown
**Source (SRS, verbatim):** "Money values shall be shown with tabular figures and the document currency."
**Priority / Status:** Should / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** amounts line up in columns and always show their currency.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Amounts shown without a currency | 0 | Visual check | Billing and Ledger screens | Visual check on billing and ledger screens |

**Not stated — ask:** whether a USD Invoice also shows its PHP value, and at what rate (AC-03).

### IFR-04 Protected interface
**Source (SRS, verbatim):** "The API shall be JSON over HTTPS under /api, with bearer tokens for every route except sign-in, challenge, public lookup and support."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** nothing can be read or changed without signing in, except four things: signing in itself, its puzzle, the Public Lookup and the help request form.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Actions that work without a sign-in, other than the four named | 0 | Call each without signing in | All routes | Route tests refuse calls without a token |

**Not stated — ask:** the SAD also lists "health and status" as open without sign-in (SAD §10.2); the SRS does not. What does it reveal?

### IFR-05 Readable error messages
**Source (SRS, verbatim):** "The API shall return a consistent error body with a message the user can read."
**Priority / Status:** Should / Partial · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** when something is refused, the User is told why in words they understand.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Refusals with a plain-language reason | All | Trigger each kind of refusal in each module | Negative tests | Partial — the areas that fail are not named |

**Not stated — ask:** who writes and approves the wording of messages that business users see (for example a refused Submit or an unmapped Charge Code).

### IFR-06 Outside data services
**Source (SRS, verbatim):** "The server shall call public ship, aircraft, exchange-rate and vehicle-lookup services only through configured endpoints; an unset aircraft endpoint reports not configured."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** ship positions, aircraft positions, exchange rates and vehicle number lookups come from outside services. If one is not set up, the system says so and does not show made-up data.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Feed shown as "not configured" when unset | Always | Unset the feed; open the map | Test system | Configuration review; feed states tested |

**Not stated — ask:** the requirement says the *server* calls the exchange-rate service, but the SAD allows the *browser* to call it (SAD §10.3, §11.3). Is a browser-fetched rate ever used on an Invoice or in the Ledger (TL-08, AC-03)? What happens to billing when the exchange-rate service is down.

### IFR-07 Device and outside connectors
**Source (SRS, verbatim):** "Device connectors (barcode scanner, signature pad, label printer), government customs filing and carrier rate APIs shall report connected, disconnected or error."
**Priority / Status:** Could / Partial · **Owner:** Business owner (SRS §8) · **Verdict:** Blocked
**In plain words:** the system has a status light for each device and outside connection, but none of the connections exists yet.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Connectors that work | Not decided | — | — | Status records exist; no live connector |

**Not stated — ask:** which connectors are needed, and when (BO-08).

### IFR-08 Encrypted connection
**Source (SRS, verbatim):** "All browser traffic shall use HTTPS in production."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** everything sent between the browser and the system is encrypted (the padlock in the address bar).

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Pages served without encryption | 0 | Try the plain address | Production | Hosting configuration review |

**Not stated — ask:** nothing.

### IFR-09 Size limits
**Source (SRS, verbatim):** "Request bodies shall be limited to 1 MB JSON, 100 KB form and 15 MB on the attachment route."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** one save can carry at most 1 MB of data, and one attachment upload at most 15 MB.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Oversize request accepted | Never | Send 1.1 MB of data; attach a 16 MB file | Test system | Oversize request is refused |

**Not stated — ask:** whether a Consolidation with 40 HAWB rows and long descriptions stays under 1 MB. Whether 15 MB is enough for scanned documents.

### IFR-10 Browser connection limits
**Source (SRS, verbatim):** "Browser connections shall be limited by the content security policy to the application, the map tile hosts and the public data hosts."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** the pages are only allowed to talk to the system itself, the map provider and the named data services. This limits what a malicious script could do.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Connections to any other host | Blocked | Header inspection | Deployed build | Header inspection on a deployed build |

**Not stated — ask:** nothing for the business.

## Security (NFR-SE-01 to 04, 06, 07)

### NFR-SE-01 Passwords are not stored readable
**Source (SRS, verbatim):** "Passwords shall be stored only as salted one-way hashes."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** nobody, including administrators, can read a User's password from the database.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Readable passwords in the database | 0 | Database inspection | Any | Database inspection shows no plain passwords |

**Not stated — ask:** nothing.

### NFR-SE-02 Signed, short-lived passes
**Source (SRS, verbatim):** "Access and refresh tokens shall be signed and short-lived by configuration; signing secrets shall be required in production."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** the passes a browser holds cannot be forged and do not last long. The production system refuses to start without its secret keys.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Production starts without secrets | Never | Start without them | Production settings | Production start refuses missing secrets |
| Lifetime of each pass | **Not stated** | Read the production settings | Production | — |

**Not stated — ask:** the lifetimes (TL-13). Who holds the secrets, and when the development ones are replaced (TL-05).

### NFR-SE-03 Security headers
**Source (SRS, verbatim):** "Responses shall carry security headers; the content security policy shall block scripts and fonts from other origins; body sizes shall be limited."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** standard browser protections are switched on. This repeats IFR-09 and IFR-10.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Standard security headers present | All | Header check | Deployed build | Header check on a deployed build |

**Not stated — ask:** nothing for the business.

### NFR-SE-04 Protection against guessing and flooding
**Source (SRS, verbatim):** "Sign-in and public lookup shall be protected by rate limits, throttling and proof of work (FR-AU-04, FR-AU-05, FR-PT-03)."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** sign-in and the Public Lookup are both protected against automated guessing. This sums up three other requirements.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| The three linked requirements pass | All | Their own checks | Test system | Security checks pass |

**Not stated — ask:** the limits themselves (see FR-PT-03 and TL-13).

### NFR-SE-06 Secrets stay on the server
**Source (SRS, verbatim):** "Feed credentials and secrets shall never reach the browser or the repository."
**Priority / Status:** Must / Built · **Owner:** *none in SRS §8* (DOC-18); Technical lead assumed · **Verdict:** Detailed enough
**In plain words:** passwords for outside services are kept on the server only, never in the web pages or in the source code.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Secrets found in the pages or the source | 0 | Source and bundle review | Current release | Source and bundle review |

**Not stated — ask:** credentials used during development must be replaced before go-live; by whom and when (TL-05).

### NFR-SE-07 Penetration test and dependency audit
**Source (SRS, verbatim):** "A penetration test and dependency audit shall be completed before go-live."
**Priority / Status:** Must / Planned · **Owner:** *none in SRS §8* (DOC-18); Technical lead assumed · **Verdict:** Blocked
**In plain words:** an independent tester tries to break in, and the third-party software the system uses is checked for known weaknesses. Neither has been done.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Signed test report | Exists before go-live | Report on file | Production-like system | None — Planned, no date stated |

**Not stated — ask:** who does it and when (TL-03). Which findings would stop go-live, and who decides (BO-01). Whether database files are encrypted on the host (TL-04).

## Performance (NFR-PF)

### NFR-PF-01 Benchmark on every change
**Source (SRS, verbatim):** "The concurrency benchmark shall run on each pull request."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** every code change is automatically tested for how it behaves when many things happen at once.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Benchmark runs on each change | Always | Pipeline record | Synthetic data | check:benchmark runs |
| Benchmark result that fails a change | **Not stated** | — | — | — |

**Not stated — ask:** the requirement says the benchmark *runs*, not what result it must reach. What number of Users working at once does it represent, against the real volumes (BO-10, TL-02)?

### NFR-PF-02 Lists are paged
**Source (SRS, verbatim):** "Every list endpoint shall page its results."
**Priority / Status:** Must / Partial · **Owner:** Technical lead · **Verdict:** Blocked
**In plain words:** long lists load a page at a time, not everything at once. Some lists do not yet.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Lists that return everything at once | 0 | Endpoint review | Large data set | Paging on entity lists; review not done |

**Not stated — ask:** which lists are not paged (TL-06). This is a **Must** that is not complete (BO-01).

### NFR-PF-03 Response times
**Source (SRS, verbatim):** "On the rehearsal copy: Overview first paint no more than 0.6 s; opening a booking no more than 0.4 s; saving no more than 0.2 s; bridge queue with 200 files about 1.0 s."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Blocked
**In plain words:** how fast the main screens respond. The numbers were measured on a demonstration copy, not at real volumes.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Overview appears | ≤ 0.6 s | Timed | **Demo copy only** | 0.45 to 0.6 s |
| Open a Freight File | ≤ 0.4 s | Timed | **Demo copy only** | 0.3 to 0.4 s |
| Save | ≤ 0.2 s | Timed | **Demo copy only** | 0.15 s |
| Bridge queue with 200 files | about 1.0 s | Timed | **Demo copy only** | about 1.0 s |

**Not stated — ask:** real volumes: files per month, Users at once, growth (BO-10). Targets at those volumes (DOC-12). "About 1.0 s" is not a testable limit. The conditions: office network, phone, number of Users at once.

## Availability (NFR-AV)

### NFR-AV-01 Health check, backup and restore
**Source (SRS, verbatim):** "The platform shall expose a health endpoint for hosting probes, and a documented backup and restore procedure shall exist for both database files."
**Priority / Status:** Must / Partial · **Owner:** Technical lead · **Verdict:** Blocked
**In plain words:** the host can check that the system is running. But no routine for backing up and restoring the two databases has been documented or practised.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Health check answers | Always | Call it | Production | Present |
| Backup procedure, written and run on a schedule | Exists | Document and backup log | Both databases | **None documented** |
| Restore tested | Before go-live | Restore to a test system and reconcile the Ledger | Both databases | **None documented** |
| Most data that may be lost | **Not stated** | — | — | — |
| Longest time to restore | **Not stated** | — | — | — |

**Not stated — ask:** when the procedure will exist, how much data may be lost, how long a restore may take (TL-01). No uptime target is stated at all. This is a **Must** that is not complete, on a risk rated High (BO-01).

## Usability (NFR-US)

### NFR-US-01 Usable on a phone
**Source (SRS, verbatim):** "Every screen shall be usable at 390 px width without horizontal page scrolling."
**Priority / Status:** Should / Partial · **Owner:** *none in the SRS traceability matrix* (DOC-18) · **Verdict:** Refined
**In plain words:** every screen works on a phone held upright without scrolling sideways. Some screens do not yet.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Screens needing sideways scrolling at phone width | 0 | Screen check per module | Any | Partial — failing screens not named |

**Not stated — ask:** who confirms usability (DOC-18). Which staff really work on a phone (dispatchers and drivers?) and which screens matter most to them. Keyboard focus order was not tested (TL-07). No accessibility requirement exists.

### NFR-US-02 Light and dark appearance
**Source (SRS, verbatim):** "Screens shall be provided and verified in light and dark appearance."
**Priority / Status:** Should / Built · **Owner:** *none in the SRS traceability matrix* (DOC-18) · **Verdict:** Detailed enough
**In plain words:** the system has a light and a dark colour scheme.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Screens with both schemes | All | Screenshots | Any | Light and dark screenshots in the design records |

**Not stated — ask:** whether printed documents are unaffected by the dark scheme.

## Delivery (NFR-MT)

### NFR-MT-01 Database changes only add
**Source (SRS, verbatim):** "Production schema changes shall be additive and applied by a start-up routine, mirrored in the schema file."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** a new release may add fields to the database but never removes or renames existing ones, so a release cannot destroy data by its structure change.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Structure matches the definition after start-up | Always | Automated check | Test system | check:schema-drift and check:schema-heal pass |

**Not stated — ask:** how a change that must remove or rename something is done, and who approves it (SAD §6.4 says "planned, reviewed data migration").

### NFR-MT-02 Checks before merge
**Source (SRS, verbatim):** "A change shall merge only when the web and server checks pass in continuous integration."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** no code change is accepted unless all automated checks pass.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Changes merged with failing checks | 0 | Pipeline record | — | Pull request checks required |

**Not stated — ask:** the end-to-end scripts are not among those checks, and vehicles, cartage and dispatch have no automated checks (TL-07).

### NFR-MT-03 One release path
**Source (SRS, verbatim):** "Production shall be deployed only from main, one deployment at a time."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** every accepted change goes live automatically, one at a time, from a single reviewed source.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Releases from any other source | 0 | Deployment record | — | Deployment workflow with concurrency group |

**Not stated — ask:** every merge goes live straight away. Is there a test stage where owners see a change before users do? Who approves a release, how users are told, and how a bad release is undone? Is the site already in use (Q2)?

## Data rules (DR)

### DR-01 Every record belongs to a Company
**Source (SRS, verbatim):** "Every operational row shall carry a company code set by the server from the signed-in user."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** the system, not the User's browser, decides which Company a record belongs to.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Record saved under a Company the browser asked for | Never | Send a different Company value | Two test Companies | Client-sent company value ignored |

**Not stated — ask:** see BO-03.

### DR-02 Exact money arithmetic
**Source (SRS, verbatim):** "Money shall use exact decimal handling for invoice and ledger totals."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** amounts are added and multiplied without the tiny rounding errors computers can make, so totals are right to the centavo.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Invoice and Ledger totals wrong by any amount | 0 | Automated cases | Sample Invoices | check:invoice passes |

**Not stated — ask:** the rounding rule: VAT rounded per line or on the Invoice total; rounding when a USD amount becomes PHP (AC-03, AC-04). Currencies with no decimals, such as JPY.

### DR-03 Journals balance
**Source (SRS, verbatim):** "A posted journal shall have equal debit and credit totals."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Detailed enough
**In plain words:** nothing unbalanced can enter the Ledger.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Posted Journals where debits ≠ credits | 0 | Automated cases; Ledger query | Full Ledger | check:bridge passes |

**Not stated — ask:** whether leftover rows in the production Ledger all balance (BO-09).

### DR-04 Numbers are never reused
**Source (SRS, verbatim):** "An issued reference number shall not be reused."
**Priority / Status:** Must / Built · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** a File Number, Invoice Reference or Invoice Number, once given, is never given to anything else.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Duplicate numbers | 0 | Sequence checks | All files and Invoices | Unique sequence checks |

**Not stated — ask:** which numbers this covers. Whether gaps in a series are acceptable to the tax authority, for example the number of a Draft that is never issued (AC-05). Which time zone starts a new day or month (TL-09).

### DR-05 Controlled deletion
**Source (SRS, verbatim):** "Deletion shall be limited to roles allowed by the route and shall leave an audit record."
**Priority / Status:** Must / Built · **Owner:** Technical lead (decision: Business owner) · **Verdict:** Blocked
**In plain words:** only some Roles can delete, and every deletion is recorded. Which Roles can delete what is not written down.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Deletion by a Role that is not allowed | Never | Try each Role on each record type | Test system | Delete route refuses non-permitted roles |

**Not stated — ask:** the table of which Role may delete which record (BO-14). Whether an Approved file, an Issued Invoice or a posted Journal can ever be deleted. Whether a deleted record can be recovered. Retention (BO-11).

### DR-06 Separate store for attachments
**Source (SRS, verbatim):** "Attachment content shall move to a separate file store before attachment volume grows."
**Priority / Status:** Could / Planned · **Owner:** Technical lead · **Verdict:** Refined
**In plain words:** attached files are kept inside the main database today, which makes it grow and makes backups slower. Moving them out is planned.

| Measure | Target | How measured | On what data | Current evidence |
|---|---|---|---|---|
| Attachments held outside the database | All | Storage review | Production | None — stored in the database |
| Size at which the move must happen | **Not stated** | — | — | — |

**Not stated — ask:** "before attachment volume grows" has no number. How many attachments are expected (BO-10). Accepted file types (TL-12).

---

## Constraints and assumptions with no owner

The SRS lists these in §2.5 and §2.6. Only C-01 is in its traceability matrix (Technical lead); no owner confirms the others (DOC-18).

| ID | Statement (SRS) | In plain words | Who should confirm | Question |
|---|---|---|---|---|
| C-01 | Production has no migration command. Schema changes must be additive and applied at start-up. | Releases can only add to the database structure. | Technical lead (per SRS §8) | — |
| C-02 | Secrets are held only in host settings; never committed or sent to the browser. | Keys and passwords live only on the server. | Technical lead | TL-05 |
| C-03 | Production records must not be used for testing or demonstrations. | Real data is never used for demos or tests. | Business owner | BO-09 |
| C-04 | Ledger postings are made only through the accounting bridge. | Nothing reaches the Ledger except through the Accounting Bridge. *But Accountants can also record Journals directly (FR-FS-03) — confirm what the rule really is.* | Accounting lead | AC-15 |
| C-05 | Amounts are held with their currency; the ledger records in PHP. | Invoices can be in other currencies; the books are in pesos. | Accounting lead | AC-03 |
| A-01 | Tariffs and charge rates are entered by the business. Most lanes have no tariff yet. | Someone in the business must type in the rates. | Business owner | AC-18, DOC-16 |
| A-02 | The ledger chart contains the accounts that billing codes map to. | The chart is assumed to be complete. | Accounting lead | AC-07 |
| A-03 | Public data services remain available under their own terms; the platform degrades when they are not. | If an outside service stops, that feature stops. | Technical lead | TL-08 |
| A-04 | The owner rotates development credentials before go-live. | Passwords used during building are changed before real use. | Business owner, Technical lead | TL-05 |

---

## Candidate requirements

These are **not** requirements. Each is a possible new requirement raised by a gap, waiting for the owner's decision on the linked question.

| ID | Candidate requirement | Why | Question | Gap |
|---|---|---|---|---|
| CR-40 | A User who forgets their password asks an administrator through a support ticket; there is no self-service reset. | No requirement says so either way. | BO-06 | GAP-62 |
| CR-41 | Records are kept for a stated period and are archived, not deleted, before it ends. | No retention rule. | BO-11 | GAP-67 |
| CR-42 | The system supports a stated number of files per month and Users at once, with response-time targets at that volume. | Measured on demo data only. | BO-10, TL-02 | GAP-58 |
| CR-43 | Both databases are backed up on a schedule; a stated maximum of data may be lost; a restore takes no longer than a stated time and is tested. | No documented procedure today. | TL-01 | GAP-57 |
| CR-44 | All business dates, sequences and Period boundaries use one stated time zone. | Not specified. | TL-09 | GAP-42 |
| CR-45 | Database files are encrypted on the host. | "Planned for review." | TL-04 | GAP-61 |
| CR-46 | Users, Freight Files or approvals are limited by Branch. | Branches exist only on the map. | BO-04 | GAP-64 |
| CR-47 | Existing data (Customers, open files, Tariffs, Ledger opening balances) is loaded and reconciled before go-live. | No migration plan. | BO-12 | GAP-01 |
| CR-48 | The password policy and the idle time are stated as values. | Only the 72-byte maximum is stated. | TL-11 | GAP-63 |
| CR-49 | A table states which Role may delete which record and which Roles may read the audit trail. | "Authorised" is not defined. | BO-14 | GAP-66 |
| CR-50 | Accepted attachment types are listed. | Only the size is stated. | TL-12 | GAP-68 |
| CR-51 | Each area has a named person who trains users and signs acceptance. | Nobody accepts the working system. | BO-13 | GAP-04 |
