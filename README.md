# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language   | Share of code |
| --- | ---------- | ------------- |
| 1   | sed        | 7.08%         |
| 2   | Awk        | 5.04%         |
| 3   | Vim Script | 7.50%         |
| 4   | jq         | 6.72%         |
| 5   | Perl       | 14.26%        |
| 6   | bc         | 6.34%         |
| 7   | APL        | 4.74%         |
| 8   | Assembly   | 23.70%        |
| 9   | SQL        | 7.62%         |
| 10  | Shell      | 16.95%        |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
