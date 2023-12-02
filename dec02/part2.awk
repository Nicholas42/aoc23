#!/bin/awk -f

BEGIN {
    power_sum = 0
}

{
    red = 0
    green = 0
    blue = 0
    for (i = 1; i <= NF; i++) {
        sub(/,|;/, "", $i)
        switch($i) {
            case "red":

            if($(i-1) > red) {
                red = $(i-1);
            }
            break;

            case "green":
            if($(i-1) > green) {
                green = $(i-1);
            }
            break;

            case "blue":
            if($(i-1) > blue) {
                blue = $(i-1);
            }
            break;
        }
    }

    power_sum += red * green * blue
}

END {
    print power_sum
}
