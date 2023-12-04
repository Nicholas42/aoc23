#!/bin/env -S jq --raw-input --slurp -f

include "./common";

parse_scratchcards
| map(
        select(.)
        | pow(2; . - 1)
     )
| add
