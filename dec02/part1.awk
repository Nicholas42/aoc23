#!/bin/awk -f

BEGIN {
    idx_sum = 0
}

{
    good = 1
    for (i = 1; i <= NF; i++) {
        sub(/,|;/, "", $i)
        switch($i) {
            case "red":

            if($(i-1) > 12) {
                good = 0;
            }
            break;

            case "green":
            if($(i-1) > 13) {
                good = 0;
            }
            break;

            case "blue":
            if($(i-1) > 14) {
                good = 0;
            }
            break;
        }
    }

    if(good) {
        idx_sum += $2
    }
}

END {
    print idx_sum
}
