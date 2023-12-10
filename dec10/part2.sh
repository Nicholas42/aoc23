#!/bin/bash

HERE=$(dirname "$0")
source "$HERE/common.sh"

declare -i LAST START_DIR
find_start_dir
START_DIR=$((3 - FROM))

replace_loop_pipe() {
    declare PIPE NEW_PIPE
    PIPE=${INPUT:$1:1}

    case $PIPE in
    "|")
        NEW_PIPE="\\"
        ;;
    "-")
        NEW_PIPE="_"
        ;;
    "7")
        NEW_PIPE="&"
        ;;
    "L")
        NEW_PIPE="l"
        ;;
    "F")
        NEW_PIPE="f"
        ;;
    "J")
        NEW_PIPE="j"
        ;;
    esac

    INPUT="${INPUT:0:$1}$NEW_PIPE${INPUT:$1+1}"
}

while [ $CURRENT -ne $START_POS ]; do
    LAST=$CURRENT
    step
    replace_loop_pipe $LAST
done

declare NEW_START
case "$START_DIR$FROM" in
"$TOP$BOTTOM" | "$BOTTOM$TOP")
    NEW_START="\\"
    ;;
"$TOP$LEFT" | "$LEFT$TOP")
    NEW_START="j"
    ;;
"$TOP$RIGHT" | "$RIGHT$TOP")
    NEW_START="l"
    ;;

"$RIGHT$BOTTOM" | "$BOTTOM$RIGHT")
    NEW_START="f"
    ;;
"$RIGHT$LEFT" | "$LEFT$RIGHT")
    NEW_START="_"
    ;;

"$LEFT$BOTTOM" | "$BOTTOM$LEFT")
    NEW_START="&"
    ;;

*)
    echo "Start direction $START_DIR and end direction $FROM do not fit"
    exit 1
    ;;
esac

INPUT="${INPUT:0:$START_POS}$NEW_START${INPUT:$START_POS+1}"

declare -i IS_INSIDE INSIDE_COUNT
IS_INSIDE=0
INSIDE_COUNT=0

for ((POS = 0; POS < ${#INPUT}; POS++)); do
    case ${INPUT:$POS:1} in
    "\\" | "l" | "j")
        IS_INSIDE=$((1 - IS_INSIDE))
        ;;
    "_" | "f" | "&") ;;
    $'\n')
        if [ $IS_INSIDE -eq 1 ]; then
            echo "INSIDE AT END OF LINE. THIS SHOULDN'T HAPPEN. LINE: $((POS / LINE_LEN))"
            exit 1
        fi
        ;;
    *)
        INSIDE_COUNT=$((INSIDE_COUNT + IS_INSIDE))
        ;;
    esac

done

echo $INSIDE_COUNT
