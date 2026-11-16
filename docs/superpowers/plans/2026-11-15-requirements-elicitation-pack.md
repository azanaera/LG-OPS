# Requirements Elicitation Pack Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give QA everything needed to run requirements gathering with the four owners (Business owner, Accounting lead, Operations lead, Technical lead) and turn SRS/SAD v0.1 into a confirmed v0.2.

**Architecture:** A flat set of Markdown documents at the repo root, next to the three that already exist, plus two folders for the multi-file deliverables (`requirements-breakdown/`, `workshops/`). `OPEN-QUESTIONS.md` stays the single log of questions and decisions; `CONTEXT.md` stays the single source of term names; every new document points to those two instead of copying them. A shell script (`tools/check-docs.sh`) is the "test suite": it proves every requirement ID and question ID is covered and every link resolves.

**Tech Stack:** Markdown (GitHub-flavoured), Git Bash, `pdftotext` (already at `/mingw64/bin/pdftotext`).

**Spec:** `Document_SRS_v0.1_REDACTED.pdf`, `Document_SAD_v0.1_REDACTED.pdf` (both dated 8 November 2026). Read them as text first:

```bash
mkdir -p .scratch && pdftotext -layout Document_SRS_v0.1_REDACTED.pdf .scratch/srs.txt && pdftotext -layout Document_SAD_v0.1_REDACTED.pdf .scratch/sad.txt
```

(`.scratch/` is added to `.gitignore` in Task 1.) Also read the three existing documents in full before any task: `REQUIREMENTS-SUMMARY.md`, `OPEN-QUESTIONS.md`, `CONTEXT.md`.

## What already exists (do not recreate)

| Requested deliverable | Status | File |
|---|---|---|
| Requirements summary | **Exists**, accurate (125 requirements; 110 Built / 8 Partial / 7 Planned verified against the SRS) | `REQUIREMENTS-SUMMARY.md` — light update only (Task 11) |
| Glossary | **Exists as a developer-style term list** (100 terms, with "avoid" words) | `CONTEXT.md` — kept as the canonical list; `GLOSSARY.md` is a new stakeholder-facing view of it (Task 6) |
| Open questions | **Exists** (74 questions) | `OPEN-QUESTIONS.md` — 19 questions added (Task 2) |

## File structure

| File | Responsibility | Audience |
|---|---|---|
| `README.md` | Index: what each document is for, reading order, who gets what | Everyone |
| `REQUIREMENTS-SUMMARY.md` *(modify)* | What the system does today, in plain language | Team + stakeholders |
| `CONTEXT.md` *(unchanged unless a term is added)* | Canonical term names and words to avoid | Developers, testers |
| `GLOSSARY.md` | A–Z plain-language glossary, "you may know it as", example | Stakeholders + team |
| `OPEN-QUESTIONS.md` *(modify)* | The one log of questions, proposals and decisions | QA (owner) |
| `PROCESS-GAP-ANALYSIS.md` | Step-by-step gaps between the documented system and a complete, consistent business process | QA, team |
| `requirements-breakdown/README.md` | Refinement method, template, ID scheme, verdict totals | QA, Engineering |
| `requirements-breakdown/01-operations.md` | FR-AP, FR-OV, FR-SH, FR-VH, FR-PD, FR-FD, FR-TR, FR-PT, FR-MP | Operations lead session |
| `requirements-breakdown/02-accounting.md` | FR-RT, FR-BL, FR-BR, FR-FS, NFR-AU | Accounting lead session |
| `requirements-breakdown/03-business-and-technical.md` | FR-AU, FR-AD, IFR, NFR-SE/PF/AV/US/MT, DR, constraints C-01..05, assumptions A-01..04 | Business owner + Technical lead |
| `STAKEHOLDER-SUMMARY.md` | Business Process Summary for Validation: the process in business words with confirm boxes and a sign-off block | Stakeholders |
| `STAKEHOLDER-REGISTER.md` | Named owners, deputies, what each decides, how to reach them (RACI) | QA |
| `INTERNAL-TRIAGE-AGENDA.md` | Agenda for the internal meeting that sorts all questions before any stakeholder is asked | QA, Engineering, PM |
| `workshops/README.md` | Session order, ground rules, facilitation method, cross-owner items | QA |
| `workshops/01-operations.md` … `04-technical.md` | Walkthrough script per owner | QA (facilitator) |
| `SESSION-NOTES-TEMPLATE.md` | Minutes, decision record and sign-off form to copy per session | QA |
| `BA-REQUIREMENTS-STUDY-GUIDE.md` | Self-study for a QA doing BA work on this system | QA |
| `tools/check-docs.sh` | Coverage and link checks | QA |

## Global Constraints

- **Describe, do not agree.** Every statement of system behaviour is worded "the system currently …" and cites its source (`SRS FR-xx-nn` or `SAD §n.n`). Nothing is presented as agreed until an owner confirms it.
- **Proposals are labelled.** A recommended answer is always under a "Proposed" heading or column, never in the question itself.
- **Terms.** Use the canonical terms in `CONTEXT.md` exactly (Freight File, Operation Status, Sell Line, Accounting Bridge, Ledger …). Terms marked ⚑ there keep the ⚑ and their question ID on first use in each document.
- **Redaction.** Never write a company name, person name, address, credential or customer record. Use "the Company" and "the Platform". Named people go only in `STAKEHOLDER-REGISTER.md`, as blank fields for the user to fill.
- **IDs are permanent.** Never renumber a requirement or question. New questions take the next number in their group. Refined requirements are children: `FR-AP-02.1`. Candidate new requirements are `CR-nn`. Gaps are `GAP-nn`.
- **One log.** Answers and decisions are written only in `OPEN-QUESTIONS.md`. Other documents link to the question ID.
- **Stakeholder-facing text** (`GLOSSARY.md`, `STAKEHOLDER-SUMMARY.md`, and every "Say" line in `workshops/`) contains no requirement IDs and none of: SQLite, JWT, API, token, endpoint, Prisma, schema, repository, CI.
- **Style** matches the existing three documents: British spelling, short sentences, tables over prose, absolute dates (source documents: 8 November 2026; demo rehearsal: 5 November 2026; this pack: 15 November 2026).
- **Branch.** Work on `docs/elicitation-pack`, not `main`. One commit per task. End commit messages with `Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>`.

## Review Focus

The situations most likely to hurt QA when these documents meet real stakeholders. Each is pinned to the task that owns it.

1. **"That is not how we work."** The SRS/SAD describe code, not the business. Every workshop script opens each topic by asking how the work is done today *before* showing what the system does. → Task 9 check: each topic block has an "As-is" question first.
2. **Rubber-stamping.** A stakeholder shown a proposed answer says yes to end the meeting. Scripts ask the open question first and reveal the proposal only if the owner has no view. → Task 9 check: no "Say" line contains the proposal.
3. **Two owners, two answers.** AC-01/OP-11, AC-16/OP-02/Q7, AC-17, BO-02, BO-11, AC-18 cross owner lines. → Task 9: `workshops/README.md` lists every cross-owner question, who decides and who is consulted; Task 8 gives the tie-break rule.
4. **No decision in the room** (owner absent, unsure, or not yet named — Q1 is still open). → Task 9: `SESSION-NOTES-TEMPLATE.md` has a parking-lot table with owner and due date; Task 8: triage makes "name the four owners" its first item.
5. **Documents drift apart** after answers arrive. → Task 2 writes the update order into `OPEN-QUESTIONS.md`; Task 1's script fails if a question ID is missing from triage or workshops, or if the summary count is wrong.

---

### Task 1: Branch, check script and index skeleton

**Files:**
- Create: `tools/check-docs.sh`, `README.md`, `.gitignore`

**Interfaces:**
- Produces: `bash tools/check-docs.sh` — prints `FAIL: …` lines and exits 1, or prints `OK` and exits 0. Every later task ends by running it and expecting *its own* FAIL lines to be gone.

- [ ] **Step 1: Create the branch**

```bash
git checkout -b docs/elicitation-pack
```

- [ ] **Step 2: Write `tools/check-docs.sh`**

```bash
#!/usr/bin/env bash
# Run from the repo root: bash tools/check-docs.sh
fail=0; err(){ echo "FAIL: $*"; fail=1; }

# 1. Required files
for f in README.md REQUIREMENTS-SUMMARY.md CONTEXT.md OPEN-QUESTIONS.md GLOSSARY.md \
  PROCESS-GAP-ANALYSIS.md STAKEHOLDER-SUMMARY.md STAKEHOLDER-REGISTER.md \
  INTERNAL-TRIAGE-AGENDA.md SESSION-NOTES-TEMPLATE.md BA-REQUIREMENTS-STUDY-GUIDE.md \
  requirements-breakdown/README.md requirements-breakdown/01-operations.md \
  requirements-breakdown/02-accounting.md requirements-breakdown/03-business-and-technical.md \
  workshops/README.md workshops/01-operations.md workshops/02-accounting.md \
  workshops/03-business-owner.md workshops/04-technical.md
do [ -f "$f" ] || err "missing file $f"; done

# 2. Every SRS requirement ID appears in requirements-breakdown/
for g in FR-AU:12 FR-OV:2 FR-AP:7 FR-SH:12 FR-RT:5 FR-BL:10 FR-VH:3 FR-PD:3 FR-FD:4 \
  FR-BR:7 FR-FS:9 FR-TR:5 FR-PT:3 FR-MP:3 FR-AD:6 NFR-SE:7 NFR-AU:2 NFR-PF:3 NFR-AV:1 \
  NFR-US:2 NFR-MT:3 IFR:10 DR:6
do p=${g%%:*}; n=${g##*:}
  for i in $(seq 1 "$n"); do id=$(printf '%s-%02d' "$p" "$i")
    grep -rqF "### $id " requirements-breakdown/ 2>/dev/null || err "no breakdown entry for $id"
  done
done

# 3. Every question ID is triaged; every stakeholder question is in a workshop script
qids=$(grep -oE '^\| (Q[0-9]+|(BO|AC|OP|TL|DOC)-[0-9]+) ' OPEN-QUESTIONS.md | tr -d '| ')
total=$(echo "$qids" | wc -l | tr -d ' ')
grep -q "| \*\*Total\*\* | \*\*$total\*\* |" OPEN-QUESTIONS.md || err "OPEN-QUESTIONS summary total is not $total"
for q in $qids; do
  grep -qw -- "$q" INTERNAL-TRIAGE-AGENDA.md 2>/dev/null || err "$q not in INTERNAL-TRIAGE-AGENDA.md"
  case $q in BO-*|AC-*|OP-*|TL-*)
    grep -rqw -- "$q" workshops/ 2>/dev/null || err "$q not in any workshop script";; esac
done

# 4. Every glossary term in CONTEXT.md is in GLOSSARY.md
grep -oE '^\*\*[^*]+\*\*' CONTEXT.md | while IFS= read -r t; do
  grep -qF "$t" GLOSSARY.md 2>/dev/null || echo "FAIL: term $t not in GLOSSARY.md"; done > .links.tmp

# 5. Every relative link resolves
find . -name '*.md' -not -path './.git/*' -not -path './docs/superpowers/*' | while IFS= read -r f; do
  d=$(dirname "$f")
  grep -oE '\]\([^)]+\)' "$f" | sed -E 's/^\]\(//; s/\)$//; s/#.*$//' | grep -vE '^(https?:|mailto:|$)' |
  while IFS= read -r l; do [ -e "$d/$l" ] || echo "FAIL: broken link in $f -> $l"; done
done >> .links.tmp
[ -s .links.tmp ] && { cat .links.tmp; fail=1; }; rm -f .links.tmp

# 6. Stakeholder-facing text is free of requirement IDs and technical words
if [ -f STAKEHOLDER-SUMMARY.md ]; then
  grep -nE '\b(FR|NFR|IFR|DR)-[A-Z0-9-]+|SQLite|JWT|\bAPI\b|token|endpoint|Prisma|schema|repository' \
    STAKEHOLDER-SUMMARY.md && err "technical wording in STAKEHOLDER-SUMMARY.md"
fi
grep -hE '^\*\*Say:\*\*|^> \*\*Say' workshops/*.md 2>/dev/null |
  grep -nE '\b(FR|NFR|IFR|DR)-[A-Z0-9-]+|SQLite|JWT|\bAPI\b|token|endpoint|Prisma' && err "technical wording in a Say line"

[ $fail -eq 0 ] && echo OK; exit $fail
```

- [ ] **Step 3: Write `.gitignore`** containing `.scratch/` and `.links.tmp`.

- [ ] **Step 4: Write `README.md`** with: one-paragraph purpose; a "Start here" reading order for QA (Study guide → Summary → Gap analysis → Breakdown → Triage → Workshops); the File structure table from this plan (File / Responsibility / Audience) with each file linked **only once it exists** (add links in the task that creates the file); a five-row "Process" table: 1 Internal triage → 2 Send Stakeholder Summary + Glossary as pre-read → 3 Run workshops (Operations, Accounting, Business owner, Technical) → 4 Record decisions in the log → 5 Engineering issues SRS/SAD v0.2.

- [ ] **Step 5: Run the script and confirm it fails for the right reasons**

Run: `bash tools/check-docs.sh | sed -E 's/(FAIL: (missing file|no breakdown entry|term)).*/\1/; s/FAIL: [A-Z0-9-]+ (not in .*)/FAIL: \1/' | sort | uniq -c`
Expected: exit 1; 16 "missing file", 125 "no breakdown entry", 74 "not in INTERNAL-TRIAGE-AGENDA.md", 51 "not in any workshop script", 100 "term" (not in GLOSSARY.md). No "broken link" and no "summary total" failure.

- [ ] **Step 6: Commit**

```bash
git add tools/check-docs.sh README.md .gitignore
git commit -m "docs: add elicitation pack index and coverage check"
```

---

### Task 2: Process Gap Analysis and new open questions

**Files:**
- Create: `PROCESS-GAP-ANALYSIS.md`
- Modify: `OPEN-QUESTIONS.md` (append rows to sections B–F; update the Summary table; add one paragraph to "How to use this log")

**Interfaces:**
- Produces: gap IDs `GAP-01`… (used by Tasks 7–9) and question IDs up to **BO-14, AC-22, OP-18, TL-12, DOC-18** (93 questions in total: A 9, B 14, C 22, D 18, E 12, F 18).

- [ ] **Step 1: Append these 19 questions to `OPEN-QUESTIONS.md`** in the existing column layout (Why it matters / Ref / Proposed / Status `Open`). They were found on this review pass and are not in the 74.

| ID | Question | Ref | Proposed |
|---|---|---|---|
| BO-12 | The Platform "replaces spreadsheet and paper steps". What existing data must be loaded before go-live (customers, open files, tariffs, ledger opening balances), who prepares it, and what is the cut-over date? | SRS §2.1; SAD §2.3 | (decision needed) |
| BO-13 | Who trains users and who signs off user acceptance testing for each area? | SRS Review and Approval table | The owner of each area signs UAT for that area. |
| BO-14 | Which roles may delete which records, and which roles may read the audit trail? "Authorised user" and "authorised roles" are not named. | SRS FR-AD-01/02/03, DR-05 | Name the roles in each requirement. |
| AC-19 | The bridge has a third item type, "miscellaneous invoice", with its own tab. What is it used for and who raises one? No requirement covers it. | SAD §7.9 | (definition needed) |
| AC-20 | When an approved file is re-rated after its invoice is issued, the invoice is "marked for re-issue". Who is told, who re-issues, and may the old invoice stay with the customer meanwhile? | SAD §7.8 | (decision needed) |
| AC-21 | What is the fiscal year, and is there a year-end close beyond month-end close? | SRS FR-FS-06 | (fact needed) |
| AC-22 | What are check disbursements used for (supplier payments, refunds, other)? Are non-check payments (bank transfer, cash) recorded, and where? | SRS FR-BR-06, FR-FS-02 | (decision needed, with AC-09) |
| OP-13 | A file has a Mode of Ocean or Air only, yet a Direction of Domestic. What is a domestic file in practice (inter-island sea or air)? Is trucking-only work a file or only a Cartage Order? | SRS FR-SH-01 | (fact needed) |
| OP-14 | Quotes: who marks a quote Sent and Accepted, what proves the customer accepted, and does a quote expire by date automatically? | SRS FR-RT-04 | (decision needed) |
| OP-15 | Submit checks "dates" and "cargo". Which dates and which cargo fields are required, and do they differ for ocean, air and consolidation? | SRS FR-AP-02 | List the required fields per Mode. |
| OP-16 | How do approvers learn a file is Pending, and operators that it was returned? No notification requirement exists. | SRS FR-AP-02/05, FR-OV-01 | The Overview to-do list at minimum; email is a later item. |
| OP-17 | RORO: who may put a vehicle on Hold and release it? How do the Hold status, the customs hold flag and the lien release flag relate? | SRS FR-VH-02/03 | (decision needed) |
| OP-18 | Files created before the approval step are treated as Approved. Should any of them be reviewed before they are billed? | SAD §3.3, §8.4 | Review any that are not yet invoiced. |
| TL-11 | What are the actual values of the password policy (length, character rules, history depth) and the idle time-out? The SRS gives only the 72-byte maximum and "a period of inactivity". | SRS FR-AU-06/07/08 | State the values in the SRS; Business owner confirms them. |
| TL-12 | Which attachment file types are accepted, and are uploads scanned? | SRS FR-AD-04 | (fact needed) |
| DOC-15 | The SAD approval table has no Operations lead, although the SAD defines the approval and movement process. | SAD Document Control | Add the Operations lead. |
| DOC-16 | Who maintains tariffs: "the business" (SRS A-01) or "the accounting team" (SAD §14.1)? | SRS A-01; SAD §14.1 | Resolve with AC-18. |
| DOC-17 | SAD §15 traces FR-AP-01 to 06 and FR-BL-01 to 08 only; FR-AP-07, FR-BL-09 and FR-BL-10 have no design reference. | SAD §15 | Add them, marked Planned. |
| DOC-18 | NFR-US-01/02, constraints C-01 to C-05 and assumptions A-01 to A-04 are missing from the SRS traceability matrix, so nobody confirms them. | SRS §8 | Assign each an owner. |

- [ ] **Step 2: Update the Summary table** to B 14, C 22, D 18, E 12, F 18, **Total 93 / 93 open**, and add under "How to use this log": *"Update order when a question is answered: (1) this log, (2) `CONTEXT.md` and `GLOSSARY.md` if a term changed, (3) the matching entry in `requirements-breakdown/`, (4) `PROCESS-GAP-ANALYSIS.md` status. Nothing else stores decisions."*

- [ ] **Step 3: Write `PROCESS-GAP-ANALYSIS.md`**

Sections, in order:
1. **How to read this** — states plainly that the business's real as-is process is *not yet known*; column "How the business does it today" is blank and is filled in during workshops. Gap types: `Missing` (no requirement), `Contradiction` (documents disagree), `Undefined` (term or value not stated), `Unbuilt` (required, not built), `Unverified` (claimed, not proven at real scale), `Control` (segregation-of-duties or audit weakness). Severity: `High` blocks go-live or risks money/compliance; `Medium` workaround exists; `Low` cosmetic or accepted.
2. **Summary** — count by type and by severity; the top ten High gaps.
3. **Gaps by process step** — one table per step of the lifecycle (1 Quote, 2 Booking, 3 Approval, 4 Movement, 5 Tracking, 6 Billing, 7 Bridge, 8 Ledger and month-end), then **Before step 1** (data migration, set-up of tariffs and chart) and **After step 8** (collections, supplier payments, profit reporting), then **Cross-cutting** (roles and permissions, branches and companies, security, recoverability, records and retention, documents and legal formats, notifications, terminology).
   Columns: `GAP ID | What the documents say the system does (with ref) | How the business does it today | Gap | Type | Severity | Question | Proposed resolution`.
4. **Gaps with no owner** — anything where the confirming owner is unclear (DOC-18 items, cross-owner items).

Content rule: every one of the 84 questions in groups B–F maps to at least one gap row; a gap may cite several questions. Also include one row for each of the 12 known limitations (SRS App. B) and each of risks R-01 to R-13 (SAD §13). Expect roughly 60–75 rows.

- [ ] **Step 4: Verify coverage**

Run:
```bash
for q in $(grep -oE '^\| ((BO|AC|OP|TL|DOC)-[0-9]+) ' OPEN-QUESTIONS.md | tr -d '| '); do grep -qw -- "$q" PROCESS-GAP-ANALYSIS.md || echo "unmapped $q"; done; for r in $(seq -w 1 13); do grep -qw "R-$r" PROCESS-GAP-ANALYSIS.md || echo "unmapped R-$r"; done
```
Expected: no output. Then `bash tools/check-docs.sh | grep -c "summary total"` → `0`.

- [ ] **Step 5: Add the link in `README.md` and commit**

```bash
git add PROCESS-GAP-ANALYSIS.md OPEN-QUESTIONS.md README.md
git commit -m "docs: add process gap analysis and 19 new open questions"
```

---

### Task 3: Requirements breakdown — method and Operations

**Files:**
- Create: `requirements-breakdown/README.md`, `requirements-breakdown/01-operations.md`

**Interfaces:**
- Produces: the entry template and verdict vocabulary that Tasks 4 and 5 reuse verbatim; heading format `### <ID> <short title>` (the check script matches `### FR-AP-02 `).

- [ ] **Step 1: Write `requirements-breakdown/README.md`** containing:

**The "detailed enough" test.** A requirement passes only if all six hold: (1) one behaviour, not several joined by "and"; (2) a named Role as actor — not "user", "staff" or "authorised user"; (3) a stated trigger and precondition; (4) an observable result a tester can check without reading code; (5) every value stated — no "a period", "recent", "by the carrier rule" without the value; (6) every term is in `CONTEXT.md` and not marked ⚑.

**Verdicts.** `Detailed enough` (kept as one row, one example) · `Refined` (split into children, awaiting confirmation) · `Blocked` (cannot be refined until the linked question is answered).

**Entry template** (use exactly):

```markdown
### FR-AP-02 Submit a Freight File for approval
**Source (SRS, verbatim):** "The system shall move a draft or returned file to pending on submit, after checking the required fields (shipper, consignee, bill-to, origin, destination, dates, cargo), and record the revision and the submitter."
**Priority / Status:** Must / Built · **Owner:** Operations lead · **Verdict:** Refined

| ID | Refined statement | Actor | Confirmed |
|---|---|---|---|
| FR-AP-02.1 | A Freight File in Draft or For Correction can be submitted. | Operator, Manager, Superadmin | ☐ |
| FR-AP-02.2 | Submit is refused, naming each missing field, unless Shipper, Consignee, Bill-to Party, origin, destination, dates and cargo are filled. | (system) | ☐ |
| FR-AP-02.3 | On submit the Operation Status becomes Pending. | (system) | ☐ |
| FR-AP-02.4 | On submit the revision number increases by one and the Submitter and time are recorded. | (system) | ☐ |

**Worked examples**
- *Given* a Draft file with no Consignee, *when* the Operator submits, *then* it stays Draft and the message names "Consignee".
- *Given* a For Correction file at revision 1 with all fields filled, *when* the Operator submits, *then* it is Pending at revision 2.

**Not stated — ask:** which dates and cargo fields (OP-15); how the approver is told (OP-16).
```

**Rules.** Quote the SRS wording exactly. Do not invent behaviour: a child statement may only split or name what the SRS/SAD already says; anything new is a `CR-nn` row in a "Candidate requirements" table at the end of the file, each tied to a question ID. Every entry has at least one positive and one negative worked example with concrete values. Engineering check names (`check:billing`) are listed under a final "Engineering check" line, never as the example.

**Totals table** (filled in Task 5): per file, count of Detailed enough / Refined / Blocked.

- [ ] **Step 2: Write `requirements-breakdown/01-operations.md`** — 42 entries in SRS order: FR-OV-01..02, FR-AP-01..07, FR-SH-01..12, FR-VH-01..03, FR-PD-01..03, FR-FD-01..04, FR-TR-01..05, FR-PT-01..03, FR-MP-01..03. Use SAD §3.3, §7.1–7.6, §7.11–7.12, §8.4, §9.1, §9.5 to fill in detail the SRS omits.

Pinned worked-example values (use these so examples agree across documents; each carries "to be confirmed by the Operations lead"):
- FR-SH-04: gross 3.2 t, volume 5.0 m³ → Revenue Weight 5.0. Gross 8.0 t, 5.0 m³ → 8.0.
- FR-SH-05: 2 pieces of 100 × 50 × 40 cm, gross 30 kg → volumetric 2 × (200,000 ÷ 6000) = 66.67 kg → rounded up to 67.0 kg → Chargeable Weight 67.0 kg. Note under "ask": whether rounding is per piece or on the total (TL-10).
- FR-SH-11: HAWB A gross 100 kg / volumetric 60 kg; HAWB B gross 40 kg / volumetric 90 kg → MAWB gross 140, volumetric 150 → MAWB Chargeable Weight **150 kg**, not 190 kg.
- FR-AP-05: return with empty note → refused, file stays Pending.
- FR-MP-03: a 25° box → refused or clipped (ask which); a result of 2,000 markers → at most 1,500 returned.

Entries that must be `Blocked`, with their question: FR-AP-07 (BO-02), FR-TR-04/05 (BO-05), FR-FD-04 (OP-10), FR-PT-02 (BO-07), FR-SH-12 house number (AC-01, OP-11).
Candidate requirements to list: cancel a Freight File (OP-03), re-approval after edit (OP-02), notifications (OP-16), approval turnaround and deputy (OP-12), required-field list per Mode (OP-15), house bill of lading in printed documents (DOC-07).

- [ ] **Step 3: Verify**

Run: `bash tools/check-docs.sh | grep "no breakdown entry" | grep -cE "FR-(OV|AP|SH|VH|PD|FD|TR|PT|MP)-"`
Expected: `0`

- [ ] **Step 4: Link both files from `README.md` and commit**

```bash
git add requirements-breakdown/ README.md
git commit -m "docs: add requirements breakdown method and operations requirements"
```

---

### Task 4: Requirements breakdown — Accounting

**Files:**
- Create: `requirements-breakdown/02-accounting.md`

**Interfaces:**
- Consumes: template, verdicts and rules from `requirements-breakdown/README.md` (Task 3).

- [ ] **Step 1: Write the file** — 33 entries: FR-RT-01..05, FR-BL-01..10, FR-BR-01..07, FR-FS-01..09, NFR-AU-01..02. Also give FR-SH-06 (VAT) a cross-reference line at the top of the FR-BL section, since it is owned by Operations in the SRS but is a billing rule (DOC-10). Use SAD §7.7–7.10, §9.2, §9.3, §9.6.

Pinned worked-example values ("to be confirmed by the Accounting lead"):
- FR-RT-03: three valid Tariffs for one Charge Code — customer + lane 80.00, lane only 95.00, any 110.00 → 80.00 applies. Same case with the customer + lane Tariff expired yesterday → 95.00.
- FR-BL-03: calculated sell 1,800.00, Tariff minimum 2,500.00 → Sell Line 2,500.00.
- FR-SH-06 cross-reference: taxable lines total 10,000.00 at 12% → VAT 1,200.00, invoice total 11,200.00; the same invoice zero-rated → VAT 0.00.
- FR-BL-02: Manual Line 500.00 for a code that also has a Tariff of 450.00 → after recalculation the line is still 500.00.
- FR-BL-04/05: show the *shape* of an Invoice Reference and an Invoice Number without inventing a mode code — write `<mode code>-<YYYYMMDD>-<daily sequence>` and `<mode code>-<YYYYMM>-<monthly sequence>` and ask Engineering for one real example of each (TL-10).
- FR-BR-04: journal with debits 11,200.00 and credits 11,200.00 → Trial Verified, Ledger unchanged. Debits 11,200.00 and credits 10,000.00 → refused.
- FR-FS-04: Period for October 2026 Closed; an entry dated 31 October 2026 → refused, message names 1 November 2026 as the first open date.

Entries that must be `Blocked`: FR-BL-04 one Live Invoice per file (AC-01, AC-02), FR-BL-08 auto mode "rate note" (AC-14) and go-live mode (AC-13), FR-BL-09 (AC-06), FR-BL-10 (AC-07), FR-BR-04/05 which Roles post (AC-15), FR-FS-02 CDV meaning (DOC-09, AC-22), FR-FS-04 reopening (AC-12).
Candidate requirements: exchange rate capture (AC-03, TL-08), VAT treatment rules and withholding tax (AC-04), official invoice compliance (AC-05), collections and AR aging (AC-08), supplier bill matching (AC-09), profit per file (AC-10), billing of cartage / RORO / dispatch (AC-17), miscellaneous invoice (AC-19), re-issue after re-rate (AC-20), year-end close (AC-21).

- [ ] **Step 2: Verify**

Run: `bash tools/check-docs.sh | grep "no breakdown entry" | grep -cE "FR-(RT|BL|BR|FS)-|NFR-AU-"`
Expected: `0`

- [ ] **Step 3: Commit**

```bash
git add requirements-breakdown/02-accounting.md
git commit -m "docs: add accounting requirements breakdown"
```

---

### Task 5: Requirements breakdown — Business owner and Technical lead

**Files:**
- Create: `requirements-breakdown/03-business-and-technical.md`
- Modify: `requirements-breakdown/README.md` (fill the totals table)

**Interfaces:**
- Consumes: template, verdicts and rules from Task 3.

- [ ] **Step 1: Write the file** in two parts.

**Part A — Business owner (11 entries):** FR-AU-09..12, FR-AD-01..06, NFR-SE-05. Add the full Role × action permission matrix from `REQUIREMENTS-SUMMARY.md` §3 as the worked example for FR-AU-09/10, with each `?` cell tied to its question (AC-15, AC-16, DOC-13, DOC-14).
**Part B — Technical lead (39 entries):** FR-AU-01..08, IFR-01..10, NFR-SE-01..04 and 06..07, NFR-PF-01..03, NFR-AV-01, NFR-US-01..02, NFR-MT-01..03, DR-01..06. Then a short table for C-01..C-05 and A-01..A-04 (statement / who must confirm / question), since they have no owner (DOC-18).

Non-functional entries use this fit test instead of Given/When/Then: `Measure | Target | How measured | On what data | Current evidence`. NFR-PF-03 must show "On what data: demo copy only" and verdict `Blocked` on BO-10.

Pinned values: FR-AU-04 — five failed attempts at 09:00:00–09:00:40, a sixth at 09:00:50 → refused; an attempt at 09:01:45 → allowed (ask whether the minute runs from the first or the fifth failure, TL-11). IFR-09 — 1 MB JSON, 100 KB form, 15 MB attachment. FR-AU-06 — 72-byte maximum; other policy values unknown (TL-11).

Entries that must be `Blocked`: FR-AU-07/08 (TL-11), FR-AU-12 and FR-AD-01 (DOC-14, BO-14), FR-AD-05 and IFR-07 (BO-08), NFR-SE-07 (TL-03), NFR-AV-01 (TL-01), NFR-PF-02 (TL-06), DR-05 (BO-14).
Candidate requirements: password reset (BO-06), record retention (BO-11), volumes and concurrency target (BO-10, TL-02), backup targets — data-loss and restore-time limits (TL-01), time zone (TL-09), encryption at rest (TL-04), Branch scoping (BO-04), data migration and cut-over (BO-12).

- [ ] **Step 2: Fill the totals table in `requirements-breakdown/README.md`** by counting `**Verdict:**` lines:

```bash
for f in requirements-breakdown/0*.md; do echo "$f"; grep -oE '\*\*Verdict:\*\* (Detailed enough|Refined|Blocked)' "$f" | sort | uniq -c; done
```
Expected: counts per file sum to 42, 33 and 50 — 125 in total, one per SRS requirement ID. The FR-SH-06 cross-reference line and the constraints/assumptions table carry no Verdict line. If a file's sum differs, find the missing or duplicated entry.

- [ ] **Step 3: Verify**

Run: `bash tools/check-docs.sh | grep -c "no breakdown entry"`
Expected: `0`

- [ ] **Step 4: Commit**

```bash
git add requirements-breakdown/
git commit -m "docs: add business and technical requirements breakdown"
```

---

### Task 6: Stakeholder glossary

**Files:**
- Create: `GLOSSARY.md`
- Modify: `CONTEXT.md` only if a term is added (see Step 2); `REQUIREMENTS-SUMMARY.md` §11 pointer line

- [ ] **Step 1: Write `GLOSSARY.md`**

Header note: term names here are identical to `CONTEXT.md`; if the two ever differ, `CONTEXT.md` wins and this file is corrected.

Sections:
1. **How to use this glossary** — three sentences for a non-technical reader, and what ⚑ means ("we still need your answer on this one").
2. **The 12 words that matter most** — Freight File, File Number, Operation Status (Draft / Pending / For Correction / Approved), Submit, Return, Sell Line, Cost Line, Invoice, Accounting Bridge, Post, Ledger, Period. One line each plus the picture of the eight-step lifecycle.
3. **A–Z** — one table, alphabetical: `Term | Plain meaning (one sentence, no technical words) | You may know it as | Example from our work | Status`. "You may know it as" comes from the term's *Avoid* list in `CONTEXT.md`. "Status" is `Proposed`, or `⚑ <question ID>`. Every bold term defined in `CONTEXT.md` (100) appears, each bolded as `**Term**`.
4. **Trade and accounting abbreviations** — AP, AR, AWB, BL / HBL / MBL, CDV, JE, AJE, DG, FCL / LCL, FS, HS, P/D, POD, RORO, TACT, VAT, VGM, W/M, VIN, PHP/USD — `Abbreviation | Stands for | Glossary term to use instead`.
5. **Words that mean different things to different people** — a plain rewrite of `CONTEXT.md` "Flagged ambiguities" as `The word | Who uses it how | What we will say instead`.
6. **Words for the technical team only** — eight rows translating terms a stakeholder may hear in a meeting: proof of work, token/session, role-based access, audit trail, staging, deployment, backup and restore, penetration test. (This is the only place those words appear in this file.)

- [ ] **Step 2: Reconcile.** If writing the glossary shows a business term the SRS/SAD use that `CONTEXT.md` lacks (check: Miscellaneous Invoice ⚑ AC-19, Check Voucher, Subsidiary, Signatory, Cargo Warehouse, Title Status, Lien Release, Customs Hold), add it to `CONTEXT.md` in that file's format first, then to the A–Z table.

- [ ] **Step 3: Replace the pointer line in `REQUIREMENTS-SUMMARY.md` §11** so it reads: *"Quick reference in the source documents' own wording. Stakeholders: use [GLOSSARY.md](GLOSSARY.md). Developers and testers: canonical terms and words to avoid are in [CONTEXT.md](CONTEXT.md)."*

- [ ] **Step 4: Verify**

Run: `bash tools/check-docs.sh | grep -c "not in GLOSSARY.md"`
Expected: `0`

- [ ] **Step 5: Link from `README.md` and commit**

```bash
git add GLOSSARY.md CONTEXT.md REQUIREMENTS-SUMMARY.md README.md
git commit -m "docs: add stakeholder glossary"
```

---

### Task 7: Stakeholder Summary — Business Process Summary for Validation

**Files:**
- Create: `STAKEHOLDER-SUMMARY.md`

**Interfaces:**
- Consumes: `GAP-nn` IDs (Task 2), glossary terms (Task 6).
- Produces: validation item IDs `V-01`… that workshop scripts (Task 9) refer to.

- [ ] **Step 1: Write the file.** No requirement IDs, no technical words (the check script enforces this). Question IDs may appear only in a narrow right-hand "Ref" column. Target: readable in 15 minutes, about 250 lines.

Sections:
1. **Why you are reading this** — "Engineering described what the system does today. We need you to tell us whether that matches how the business works and should work. Mark each numbered item: ✔ Correct · ✎ Correct with a change · ✖ Wrong · ? Not mine to answer."
2. **The process on one page** — the eight-step lifecycle diagram and a one-line description of each step in business words.
3. **Who does what** — the five Roles as job descriptions, and the permission matrix from `REQUIREMENTS-SUMMARY.md` §3 with `?` cells shown as "we need your decision".
4. **Step-by-step validation** — one sub-section per lifecycle step (Quote, Booking, Approval, Movement, Tracking, Billing, Bridge, Ledger and month-end). Each has a short narrative ("Today, the system …") and a table: `V-ID | What the system does today | ✔ ✎ ✖ ? | Your correction | Ref`. Each sub-section names the owner expected to answer it. Aim for 5–9 items per step, 55–65 in total; state rules with a number from the pinned examples (Tasks 3–5), e.g. "A shipment of 3.2 tonnes and 5.0 cubic metres is charged on 5.0."
5. **What the system does not do today** — Planned items and known limitations in business words, each with "Is this acceptable at go-live? Yes / No / Until when".
6. **Decisions only you can make** — the ten highest-severity gaps from `PROCESS-GAP-ANALYSIS.md`, each as a question with two or three options and no recommendation marked.
7. **Sign-off** — table per owner: `Area | Name | Items confirmed (V-range) | Items changed | Signature | Date`, and the sentence "Signing confirms the description, not that the system is accepted."

- [ ] **Step 2: Verify**

Run: `bash tools/check-docs.sh | grep -c "STAKEHOLDER-SUMMARY"` → `0`. Run: `grep -c '^| V-' STAKEHOLDER-SUMMARY.md` → between 55 and 65.

- [ ] **Step 3: Link from `README.md` and commit**

```bash
git add STAKEHOLDER-SUMMARY.md README.md
git commit -m "docs: add business process summary for stakeholder validation"
```

---

### Task 8: Internal Triage Agenda and Stakeholder Register

**Files:**
- Create: `INTERNAL-TRIAGE-AGENDA.md`, `STAKEHOLDER-REGISTER.md`

- [ ] **Step 1: Write `STAKEHOLDER-REGISTER.md`** — all person fields blank for the user to fill.

Tables: (1) **Owners** — `Area | Role in the SRS | Name | Deputy | Decides | Consulted on | Best way to reach | Availability`, four rows pre-filled except names, "Decides" taken from `REQUIREMENTS-SUMMARY.md` §10. (2) **Other people to interview** — rows for an Operator (encoder), an approving Manager, a dispatcher, an Accountant who posts, a Superadmin: these are the people who know the real as-is process. (3) **RACI** for: answer a question, change a requirement, accept a gap for go-live, downgrade a Must, sign v0.2 — columns QA / Business owner / Accounting lead / Operations lead / Technical lead / Engineering. (4) **Tie-break rule**: when two owners disagree, the Business owner decides, and the decision is logged with both positions.

- [ ] **Step 2: Write `INTERNAL-TRIAGE-AGENDA.md`**

Sections:
1. **Purpose and outcome** — sort all 93 questions before any stakeholder is asked, so stakeholders only get questions that need them. Outcomes: named owners; each question routed; workshop dates; pre-read sent.
2. **Who attends / pre-read / length** — QA (chair), Technical lead, an engineer who wrote the SRS/SAD, project lead. 120 minutes. Pre-read: `REQUIREMENTS-SUMMARY.md`, `PROCESS-GAP-ANALYSIS.md` summary.
3. **Agenda** — timeboxed table `# | Minutes | Item | Questions covered | Output`:
   1. 10 — Mandate and people: Q1, Q2, Q3, Q4, Q9; fill `STAKEHOLDER-REGISTER.md`.
   2. 15 — Answer from the code now: questions Engineering can settle as fact (list them explicitly: TL-02, TL-04, TL-06, TL-08, TL-11, TL-12, BO-07 field list, AC-14 definition, AC-19, OP-15 field list, DOC-09 definitions).
   3. 20 — Document fixes: DOC-01 … DOC-18, each `Fix now / Waits for <question>`.
   4. 25 — Route the business questions: Q5–Q8 and every BO, AC, OP question to a session; mark cross-owner ones.
   5. 15 — Technical lead items needing a date and a name: TL-01, TL-03, TL-05, TL-07, TL-09, TL-10.
   6. 15 — Rank: which ten questions block go-live (start from the six in `REQUIREMENTS-SUMMARY.md` §10).
   7. 10 — Schedule the four workshops and the play-back; agree the pre-read send date.
   8. 10 — Actions and owners.
4. **Triage sheet** — one table with **every one of the 93 question IDs written out individually** (no ranges; the check script looks for each ID): `ID | One-line topic | Route (Answer internally / Operations / Accounting / Business owner / Technical / Doc fix) | Blocks go-live? | Needs pre-work from Engineering | Session`. Pre-fill "Route" with the default from the ID prefix and the Step-3 lists; leave the last three columns blank.
5. **Triage rules** — a question goes to a stakeholder only if it needs a business decision or a business fact; a question Engineering can answer from the code is answered here and the stakeholder is asked only to confirm; never drop a question — mark it `Deferred` in the log with a reason.
6. **Output checklist** — owners named; triage sheet complete; worked examples requested from Engineering (TL-10); pre-read (`STAKEHOLDER-SUMMARY.md`, `GLOSSARY.md`) sent five working days before the first workshop.

- [ ] **Step 3: Verify**

Run: `bash tools/check-docs.sh | grep -c "not in INTERNAL-TRIAGE-AGENDA.md"`
Expected: `0`

- [ ] **Step 4: Link both from `README.md` and commit**

```bash
git add INTERNAL-TRIAGE-AGENDA.md STAKEHOLDER-REGISTER.md README.md
git commit -m "docs: add internal triage agenda and stakeholder register"
```

---

### Task 9: Workshop walkthrough scripts and session notes template

**Files:**
- Create: `workshops/README.md`, `workshops/01-operations.md`, `workshops/02-accounting.md`, `workshops/03-business-owner.md`, `workshops/04-technical.md`, `SESSION-NOTES-TEMPLATE.md`

**Interfaces:**
- Consumes: `V-nn` items (Task 7), `GAP-nn` (Task 2), breakdown entries (Tasks 3–5), question IDs.

- [ ] **Step 1: Write `workshops/README.md`**

- **Order and why:** 1 Operations (the process starts here) → 2 Accounting (depends on how files are approved and consolidated) → 3 Business owner (decides what the first two could not, and the release gate) → 4 Technical (turns decisions into dates) → 5 Play-back (30 minutes, all owners, read back the decisions and collect sign-off on `STAKEHOLDER-SUMMARY.md`). 90 minutes each for 1–4.
- **Ground rules:** as-is before to-be; one question at a time; open question first, proposal only if the owner has no view; say the decision back in one sentence and write it down in front of them; "I don't know" is a valid answer and goes to the parking lot with a name and a date; no solution design in the room.
- **Roles in the room:** facilitator (QA), note-taker, the owner, one or two practitioners (an Operator, an Accountant), one engineer to answer "what does it do today" — who listens and does not defend.
- **Topic block format** used by every script (exact):

```markdown
### Topic 3 — Approving a file (15 min) · V-14 to V-21 · OP-02, OP-12, BO-02
**As-is — ask first:** "Walk me through what happens today between a booking being typed up and it being billed. Who checks it?"
**Listen for:** who checks; what they check; what happens when it is wrong; how long it takes.
**Show:** STAKEHOLDER-SUMMARY.md step 3 (or the demo screen).
**Say:** "Today the system holds a file as Pending until a Manager approves it or sends it back with a note. Nobody can change it while it waits."
**Ask:**
1. "If a Manager changes the weight after approving, should someone check it again?" → OP-02
2. "How quickly does a file need to be approved, and who covers when the approver is away?" → OP-12
**If no view — offer:** the Proposed answer from OPEN-QUESTIONS.md for that ID.
**Record:** decision · who decided · any new term → GLOSSARY.
**Probe if time:** edge cases (rush shipments, one-person office, file approved by mistake).
```

- **Cross-owner questions** table — `Question | Decides | Consulted | Raised in session | Confirmed in session`: AC-01 + OP-11 (Accounting decides; Operations consulted), Q7 / OP-02 / AC-16 (Operations decides re-approval; Accounting decides accountant edit rights), AC-17 (Accounting decides; Operations describes the services), BO-02 (Business owner decides; Operations states the one-person-office reality), BO-11 (Business owner decides; Accounting states the legal period), AC-18 / DOC-16 (Business owner names the tariff owner), AC-15 (Business owner decides segregation; Accounting consulted), BO-04 (Business owner; Operations consulted).
- **After each session:** within one working day update `OPEN-QUESTIONS.md` in the stated order, send the notes to the owner for correction, carry unanswered items into the next session's opening.

- [ ] **Step 2: Write the four scripts.** Each has: header (owner, attendees, length, pre-read, what to bring); a 5-minute opening script (purpose; "we are checking the description, not the system; nothing you say is a commitment until you sign"); 6–8 topic blocks in the format above; a 10-minute close (read back decisions, parking lot, next step); a "Questions covered" list.

Coverage — every ID below must appear in the named script (the check script confirms each BO/AC/OP/TL ID appears somewhere in `workshops/`):

| Script | Topic blocks | Questions |
|---|---|---|
| `01-operations.md` | Words we use; Quote to booking; Approving a file; Consolidation and documents; RORO vehicles; Cartage and dispatch; Tracking and public lookup; Cancellations and exceptions | OP-01 … OP-18; consult on AC-01, AC-17, BO-02, BO-04; Q5, Q7 |
| `02-accounting.md` | From approved file to invoice; Who is billed (consolidation, several parties); Currency and tax; Corrections (void, credit note, re-issue); The bridge and who posts; Ledger, periods and close; After the invoice (collections, supplier bills, profit); Tariffs and set-up | AC-01 … AC-22; consult on BO-11; Q6, Q8 |
| `03-business-owner.md` | Release gate (the four Must items); Controls (self-approval, segregation of duties); Companies and branches; Customers and the public (portal, lookup, password reset); Go-live readiness (data migration, training, UAT, volumes); Records and retention; Decisions carried from sessions 1 and 2 | BO-01 … BO-14; decide AC-15, AC-18; Q1–Q3 confirmations |
| `04-technical.md` | Backup, restore and capacity; Security sign-off (penetration test, credentials, encryption); Paging and performance at real volumes; Test coverage and worked examples; Dates, time zone and money rules; Document fixes for v0.2 | TL-01 … TL-12; DOC-01 … DOC-18 status |

The "Say" lines use the pinned example numbers from Tasks 3–5 and glossary terms only.

- [ ] **Step 3: Write `SESSION-NOTES-TEMPLATE.md`** — header (session, date, attendees, facilitator, note-taker); **Decisions** `# | Question ID | Decision in one sentence | Decided by | Affects (requirement / term)`; **As-is facts learned** `# | Process step | What they do today | Differs from the system? (GAP ID or new)`; **New questions raised** `Proposed ID | Question | Owner`; **Parking lot** `Item | Owner | Due date | Carried to session`; **New or changed terms**; **Actions** `Action | Owner | Due`; **Confirmation** — "Sent to the owner on __; corrections received on __; log updated on __."

- [ ] **Step 4: Verify (including Review Focus 1 and 2)**

```bash
bash tools/check-docs.sh | grep -cE "workshop|Say line"
for f in workshops/0*.md; do t=$(grep -c '^### Topic' "$f"); a=$(grep -c '^\*\*As-is — ask first:\*\*' "$f"); echo "$f topics=$t as-is=$a"; done
grep -n '^\*\*Say:\*\*' workshops/0*.md | grep -ciE 'we propose|we recommend|should be'
```
Expected: `0`; every file shows `topics` equal to `as-is` and between 6 and 8; `0`.

- [ ] **Step 5: Link from `README.md` and commit**

```bash
git add workshops/ SESSION-NOTES-TEMPLATE.md README.md
git commit -m "docs: add workshop walkthrough scripts and session notes template"
```

---

### Task 10: BA Requirements Study Guide

**Files:**
- Create: `BA-REQUIREMENTS-STUDY-GUIDE.md`

- [ ] **Step 1: Write the file** — written to the reader ("you"), a QA taking the BA role for the first time on this system. About 350 lines.

Sections:
1. **Your job in one paragraph** — you are not confirming the documents; you are finding out what the business needs and where the documents differ. A QA's instinct (expected vs actual, edge cases, "how would I test this?") is the right tool; the shift is from *verifying* answers to *eliciting* them.
2. **Seven-day study plan** — table `Day | Read | Do | You can now…` covering: Summary and Glossary; freight basics; approval and movement; billing and tax; bridge and ledger; gap analysis and breakdown; dry-run a workshop script aloud.
3. **Freight forwarding in 20 minutes** — what a forwarder sells; export vs import vs domestic; ocean (FCL/LCL, bill of lading, Revenue Weight) and air (air waybill, Chargeable Weight, why volume matters, with the 67.0 kg example); consolidation (MAWB/HAWB, why the 150 kg vs 190 kg difference is the forwarder's margin); RORO; cartage; Incoterms and why they decide who is billed; the documents and who receives each.
4. **Accounting in 20 minutes** — receivable vs payable; Sell Line vs Cost Line and profit per file; invoice vs official receipt vs credit note; VAT (12%, zero-rated, exempt) in one example; debit and credit with the 11,200.00 journal; what "posting" and "closing a month" mean and why accountants refuse to edit posted entries; segregation of duties — why "the person who approves should not be the person who posts".
5. **How this system thinks** — the three ideas (one File Number, approval before billing, bridge as the only door to the Ledger) and the ten state lists, pointing to `REQUIREMENTS-SUMMARY.md` §5.
6. **How to read a requirement critically** — the six-point "detailed enough" test from `requirements-breakdown/README.md`, applied live to three SRS requirements: FR-AP-02 (compound), FR-AU-08 ("a period of inactivity" — no value), FR-AD-01 ("authorised user" — no actor). Then: the weak words to hunt (appropriate, authorised, recent, a period, etc., may, support, as needed).
7. **Elicitation techniques, with when to use each** — table `Technique | Use it when | Example from this project`: process walk-through ("show me the last file you billed"), document analysis (ask for a real invoice, a real manifest, the tariff spreadsheet), observation of an encoder for 30 minutes, scenario and edge-case questions, worked examples with numbers, the five whys, playback.
8. **Asking good questions** — open before closed; one thing at a time; ask for the last real case, not the general rule; never ask "does the system need X?" — ask "what happens today when X?"; ten rewritten examples `Weak question → Better question` drawn from the log (e.g. AC-01, OP-03, BO-02).
9. **Handling the room** — the stakeholder who says "just make it like the old way"; the one who designs screens; two owners who disagree (tie-break rule in `STAKEHOLDER-REGISTER.md`); the engineer who defends the build; "I'll get back to you" (parking lot with a date); silence.
10. **Recording and closing the loop** — decision in one sentence; who and when; the update order from `OPEN-QUESTIONS.md`; what "Answered", "Closed" and "Deferred" mean; how an answer becomes a test case.
11. **Traps specific to this project** — the documents were written from code; "Built" does not mean "correct" or "wanted"; acceptance columns are engineering checks; performance numbers are demo-only; four Must items are unbuilt; terms with ⚑.
12. **Per-session cheat sheets** — one half-page each for Operations, Accounting, Business owner, Technical: the five things you must leave with, the three terms you must be fluent in, the one topic most likely to derail.
13. **Self-test** — 20 questions with an answer key at the end, e.g. "A MAWB has two HAWBs: 100 kg gross / 60 kg volumetric and 40 kg gross / 90 kg volumetric. What is the MAWB Chargeable Weight and why is it not 190?"; "Name the three Billing-to-Ledger Modes and the risk of the third"; "Which four Must requirements are not built?"; "Why can an Accountant not see a Pending file?".
14. **Further reading** — generic titles only (BABOK Guide elicitation chapter; IATA TACT rules; Incoterms 2020; local tax authority invoicing rules), no URLs.

- [ ] **Step 2: Verify** — `bash tools/check-docs.sh | grep -c "BA-REQUIREMENTS-STUDY-GUIDE"` → `0`; `grep -c '^## ' BA-REQUIREMENTS-STUDY-GUIDE.md` → `14`.

- [ ] **Step 3: Link from `README.md` and commit**

```bash
git add BA-REQUIREMENTS-STUDY-GUIDE.md README.md
git commit -m "docs: add BA requirements study guide for QA"
```

---

### Task 11: Update the Requirements Summary and close out

**Files:**
- Modify: `REQUIREMENTS-SUMMARY.md`, `README.md`

- [ ] **Step 1: Edit `REQUIREMENTS-SUMMARY.md`**
  - Header "Companions" line: add `GLOSSARY.md`, `PROCESS-GAP-ANALYSIS.md`, `requirements-breakdown/`.
  - §10 "Open questions" column: `BO-01 to BO-14`, `AC-01 to AC-22`, `OP-01 to OP-18`, `TL-01 to TL-12`.
  - §10 "The biggest gaps to raise first": add **7. No data migration or cut-over plan** (BO-12) and **8. No owner confirms usability requirements, constraints or assumptions** (DOC-18).
  - §8 "Not specified at all" row: add "password policy values and idle time-out (TL-11), notifications (OP-16), fiscal year (AC-21)".
  - §3 permission matrix: add a row "Delete records / read the audit trail" with `?` in every Role column, linked to BO-14.

- [ ] **Step 2: Finish `README.md`** — confirm every file in the File structure table is linked.

- [ ] **Step 3: Run the full check**

Run: `bash tools/check-docs.sh`
Expected: `OK`, exit 0.

- [ ] **Step 4: Redaction sweep**

Run: `grep -rniE "@[a-z0-9-]+\.(com|ph|net)|password *[:=]|\+63|[0-9]{3,4}-[0-9]{3,4}-[0-9]{4}" --include='*.md' . | grep -v docs/superpowers`
Expected: no output.

- [ ] **Step 5: Commit**

```bash
git add REQUIREMENTS-SUMMARY.md README.md
git commit -m "docs: update requirements summary for the elicitation pack"
```

---

## Not in this plan (recommended later)

- **Requirements Traceability Matrix and test plan** — build after v0.2, from the confirmed breakdown.
- **UAT scripts per Role** — after the owners sign.
- **To-be process maps (swim-lane diagrams)** — only once the as-is facts from the workshops are in.
- **Data migration plan** — depends on BO-12.
