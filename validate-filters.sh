#!/usr/bin/env bash
set -uo pipefail

# Filter List Validator
# Validates Adblock Plus filter syntax for all .txt filter files

FILTER_FILES=(
  "filterlist.txt"
  "filterlist.streaming.hbo.txt"
  "filterlist.streaming.disney.txt"
  "filterlist.streaming.roku.txt"
  "filterlist.streaming.paramount.txt"
  "filterlist.streaming.peacock.txt"
  "filterlist.streaming.appletv.txt"
  "filterlist.streaming.hulu.txt"
  "filterlist.streaming.amazon.txt"
  "filterlist.streaming.netflix.txt"
  "filterlist.streaming.pluto.txt"
  "filterlist.streaming.tubi.txt"
  "filterlist.streaming.skyglass.txt"
)

errors=0
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_crlf() {
  local file="$1"
  if grep -rl $'\r' "$file" > /dev/null 2>&1; then
    echo -e "  ${RED}CRLF line endings${NC}"
    return 1
  fi
  return 0
}

check_trailing_whitespace() {
  local file="$1"
  local found
  found=$(grep -n '[[:space:]]$' "$file" | grep -v '^[0-9]*:\!')
  if [[ -n "$found" ]]; then
    echo -e "  ${YELLOW}Trailing whitespace${NC}"
    echo "$found" | head -5 | sed 's/^/    /'
    return 1
  fi
  return 0
}

check_block_duplicates() {
  local file="$1"
  local dupes
  dupes=$(grep -E '^\|\|' "$file" | sort | uniq -d)
  if [[ -n "$dupes" ]]; then
    echo -e "  ${RED}Duplicate block rules${NC}"
    echo "$dupes" | sed 's/^/    → /'
    return 1
  fi
  return 0
}

check_malformed() {
  local file="$1"
  local lineno=0
  local found=0
  while IFS= read -r line; do
    lineno=$((lineno + 1))
    line="${line%"${line##*[![:space:]]}"}"
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^! ]] && continue
    [[ "$line" =~ ^# ]] && continue
    [[ "$line" =~ ^\[ ]] && continue
    [[ "$line" =~ ^@@ ]] && continue
    [[ "$line" =~ ^[0-9] ]] && continue
    [[ "$line" =~ ^/ ]] && continue
    [[ "$line" =~ ^\^ ]] && continue
    [[ "$line" =~ ^[a-zA-Z0-9] ]] && continue
    if [[ ! "$line" =~ ^\|\| ]]; then
      echo -e "  ${YELLOW}Unrecognized line $lineno: ${line:0:60}${NC}"
      found=1
    fi
  done < "$file"
  return $found
}

echo "=========================================="
echo "  Filter List Validator"
echo "=========================================="
echo ""

total=0
for file in "${FILTER_FILES[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo -e "  ${YELLOW}⚠ Missing${NC}: $file"
    continue
  fi
  echo "Checking: $file"
  file_errors=0
  check_crlf "$file" || ((file_errors++))
  check_trailing_whitespace "$file" || ((file_errors++))
  check_block_duplicates "$file" || ((file_errors++))
  check_malformed "$file" || ((file_errors++))
  if [[ $file_errors -eq 0 ]]; then
    echo -e "  ${GREEN}✓ Clean${NC}"
  fi
  errors=$((errors + file_errors))
  total=$((total + 1))
  echo ""
done

echo "=========================================="
if [[ $errors -eq 0 ]]; then
  echo -e "${GREEN}✅ All $total files passed.${NC}"
else
  echo -e "${RED}❌ $errors issue(s) across $total files.${NC}"
fi
echo "=========================================="
exit $(( errors > 0 ? 1 : 0 ))
