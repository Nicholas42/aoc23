#!/bin/env -S jq --raw-input --slurp -f

include "./common";

parse_scratchcards
| enumerate
| reduce .[] as [$index, $wins] (
        map(1);  # Initially, we have one of each scratchcard
        .[$index] as $won_copies  # This is the final number of copies of card $index
        | enumerate
        | map(  # update the copies of all cards
            if .[0] > $index and .[0] <= $index + $wins  # For all cards that we win copies of...
            then .[1] + $won_copies  # add a copy for each copy of our current card
            else .[1] end  # The rest stays the same
            )
        )  # We have now a list of numbers of copies of each card
| add
