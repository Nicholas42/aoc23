#!/bin/bash

HERE=$(dirname "$0")
source "$HERE/common.sh"

find_start_dir

declare -i STEPS
STEPS=1

while [ $CURRENT -ne $START_POS ]; do
    step
    STEPS=$((STEPS + 1))
done

echo $((STEPS / 2))
