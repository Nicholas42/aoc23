#!/bin/sh

set -ex

DAY=${1:-$(date +%d)}
DAY_UNPADDED=$(echo "$DAY" | sed 's/^0//')
FNAME="dec$DAY/input.txt"

mkdir -p "$(dirname "$FNAME")"
wget -o /dev/null --load-cookies aoc_cookie.txt "https://adventofcode.com/2023/day/$DAY_UNPADDED/input" -O - > "$FNAME"

if [ ! -f "dec$DAY/Makefile" ]; then
    TAB="$(printf '\t')"
    cat << EOF > "dec$DAY/Makefile"
.PHONY: all
all: part1 part2

.PHONY: part1
part1:
$TAB\$(info Part 1:)

.PHONY: part2
part2:
$TAB\$(info Part 2:)

.NOTPARALLEL:
.SILENT:
EOF
fi
