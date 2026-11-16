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
  grep -qF -- "$t" GLOSSARY.md 2>/dev/null || echo "FAIL: term $t not in GLOSSARY.md"; done > .links.tmp

# 5. Every relative link resolves
find . -name '*.md' -not -path './.git/*' -not -path './docs/superpowers/*' -not -path './.superpowers/*' | while IFS= read -r f; do
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

# 7. Claims the final review found unsupported by the SRS/SAD must not come back
while IFS= read -r phrase; do
  hits=$(grep -rlF --include='*.md' --exclude-dir=.git --exclude-dir=docs --exclude-dir=.superpowers --exclude-dir=.scratch -- "$phrase" . 2>/dev/null)
  [ -n "$hits" ] && err "unsupported claim \"$phrase\" in: $(echo $hits)"
done <<'EOF'
paid data feed
every user sees every file
has no way to record one
cannot be billed
No backup today
not scheduled
the setting today
have no register
does not come from a Freight File
does not come from a freight file
no charge is produced
protects everything else
first or the fifth
would Freight File feel natural
Can it be fixed to Manila time
who marked the quote as accepted
EOF

# 8. Owner routing and privacy fixes from the final review stay in place
grep -qF "except AC-15" STAKEHOLDER-REGISTER.md 2>/dev/null || err "register does not carve AC-15/AC-18 out of the Accounting lead's decisions"
grep -qF "except OP-11" workshops/01-operations.md 2>/dev/null || err "workshop 1 still lists OP-11 as decided by Operations"
grep -qxF "notes/" .gitignore 2>/dev/null || err "notes/ (holds names) is not git-ignored"
grep -qF "NFR-SE-06/07" OPEN-QUESTIONS.md 2>/dev/null || err "DOC-18 does not list NFR-SE-06/07 as unowned"

[ $fail -eq 0 ] && echo OK; exit $fail
