#!/bin/bash

set -eu -o pipefail

declare -i LINE_LEN START_POS TOP LEFT RIGHT BOTTOM FROM CURRENT

TOP=0
LEFT=1
RIGHT=2
BOTTOM=3

INPUT=$(cat "$1")

find_pos() {
    tmp=${INPUT%%"$1"*}
    echo ${#tmp}
}

LINE_LEN=$(($(find_pos $'\n') + 1))
START_POS=$(find_pos 'S')

step() {
    declare CURRENT_PIPE
    CURRENT_PIPE="${INPUT:$CURRENT:1}"

    case "$FROM$CURRENT_PIPE" in
    "$TOP|")
        FROM=$TOP
        CURRENT=$((CURRENT + LINE_LEN))
        ;;
    "${TOP}L")
        FROM=$LEFT
        CURRENT=$((CURRENT + 1))
        ;;
    "${TOP}J")
        FROM=$RIGHT
        CURRENT=$((CURRENT - 1))
        ;;

    "$LEFT-")
        FROM=$LEFT
        CURRENT=$((CURRENT + 1))
        ;;
    "${LEFT}7")
        FROM=$TOP
        CURRENT=$((CURRENT + LINE_LEN))
        ;;
    "${LEFT}J")
        FROM=$BOTTOM
        CURRENT=$((CURRENT - LINE_LEN))
        ;;

    "$RIGHT-")
        FROM=$RIGHT
        CURRENT=$((CURRENT - 1))
        ;;
    "${RIGHT}F")
        FROM=$TOP
        CURRENT=$((CURRENT + LINE_LEN))
        ;;
    "${RIGHT}L")
        FROM=$BOTTOM
        CURRENT=$((CURRENT - LINE_LEN))
        ;;

    "$BOTTOM|")
        FROM=$BOTTOM
        CURRENT=$((CURRENT - LINE_LEN))
        ;;
    "${BOTTOM}F")
        FROM=$LEFT
        CURRENT=$((CURRENT + 1))
        ;;
    "${BOTTOM}7")
        FROM=$RIGHT
        CURRENT=$((CURRENT - 1))
        ;;

    *)
        echo >&2 "From $FROM and pipe $CURRENT_PIPE at $CURRENT do not fit."
        exit 1
        ;;
    esac
}

find_start_dir() {
    if expr "${INPUT:$START_POS-$LINE_LEN}" : '|\|F\|7' >/dev/null; then
        FROM=$BOTTOM
        CURRENT=$((START_POS - LINE_LEN))
    elif expr "${INPUT:$START_POS+1}" : '-\|J\|7' >/dev/null; then
        FROM=$LEFT
        CURRENT=$((START_POS + 1))
    elif expr "${INPUT:$START_POS+$LINE_LEN}" : '|\|J\|L' >/dev/null; then
        FROM=$TOP
        CURRENT=$((START_POS + LINE_LEN))
    elif expr "${INPUT:$START_POS-1}" : '-\|L\|F' >/dev/null; then
        FROM=$RIGHT
        CURRENT=$((START_POS - 1))
    else
        echo >&2 "No pipe outgoing from S!"
        exit 1
    fi
}
