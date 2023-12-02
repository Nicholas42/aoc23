#!/bin/sh

set -ex

DAY=${1:-$(date +%d)}
DAY_UNPADDED=$(echo "$DAY" | sed 's/^0//')
FNAME="dec$DAY/input.txt"

mkdir -p "$(dirname "$FNAME")"
wget -o /dev/null --load-cookies aoc_cookie.txt "https://adventofcode.com/2023/day/$DAY_UNPADDED/input" -O - > "$FNAME"
