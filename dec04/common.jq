def split_non_empty($sep): split($sep) | map(select(. != ""));

# Parse scratchcards.
#   Expects: One string of the format 'Card 42: 1 2 3 | 4 5 6'
#   Returns: A list of the count of winning numbers per card
def parse_scratchcards:
split_non_empty("\n")
| map(
        split("[:|]"; null)  # ["Card $n", "<winning numbers>", "<numbers had>"]
        | map(split_non_empty(" ")) # [["Card", $n], [<winning numbers>], [<numbers had>]]
        | .[1] as $winnings
        | .[2]
        | map(
            select( # Select the numbers we have that are winners
                IN($winnings[])
                )
            )
        | length
     );

# Add indices to the provided array. Same as pythons enumerate
def enumerate: [foreach .[] as $item (-1; . + 1; [., $item])];
