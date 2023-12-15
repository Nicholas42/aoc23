# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language   | Share of code |
| --- | ---------- | ------------- |
| 1   | sed        | 4.13%         |
| 2   | Awk        | 2.94%         |
| 3   | Vim Script | 4.37%         |
| 4   | jq         | 3.92%         |
| 5   | Perl       | 8.31%         |
| 6   | bc         | 3.69%         |
| 7   | APL        | 2.76%         |
| 8   | Assembly   | 13.83%        |
| 9   | SQL        | 4.45%         |
| 10  | Shell      | 9.88%         |
| 11  | C          | 10.25%        |
| 12  | Effekt     | 9.95%         |
| 13  | Ruby       | 5.82%         |
| 14  | Go         | 7.59%         |
| 15  | Pascal     | 7.86%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
