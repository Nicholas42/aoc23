# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language   | Share of code |
| --- | ---------- | ------------- |
| 1   | sed        | 4.48%         |
| 2   | Awk        | 3.19%         |
| 3   | Vim Script | 4.75%         |
| 4   | jq         | 4.25%         |
| 5   | Perl       | 9.03%         |
| 6   | bc         | 4.01%         |
| 7   | APL        | 3.00%         |
| 8   | Assembly   | 15.01%        |
| 9   | SQL        | 4.82%         |
| 10  | Shell      | 10.73%        |
| 11  | C          | 11.13%        |
| 12  | Effekt     | 10.80%        |
| 13  | Ruby       | 6.32%         |
| 14  | Go         | 8.24%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
