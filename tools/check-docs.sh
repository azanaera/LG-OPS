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

[ $fail -eq 0 ] && echo OK; exit $fail
