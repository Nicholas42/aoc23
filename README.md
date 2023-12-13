# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language   | Share of code |
| --- | ---------- | ------------- |
| 1   | sed        | 6.02%         |
| 2   | Awk        | 4.28%         |
| 3   | Vim Script | 6.38%         |
| 4   | jq         | 5.72%         |
| 5   | Perl       | 12.12%        |
| 6   | bc         | 5.39%         |
| 7   | APL        | 4.03%         |
| 8   | Assembly   | 20.16%        |
| 9   | SQL        | 6.48%         |
| 10  | Shell      | 14.41%        |
| 11  | C          | 14.95%        |
| 12  | Effekt     | unfinished    |
| 13  | Ruby       | tbd           |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
