# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language    | Share of code |
| --- | ----------- | ------------- |
| 1   | sed         | 3.32%         |
| 2   | Awk         | 2.36%         |
| 3   | Vim Script  | 3.51%         |
| 4   | jq          | 3.15%         |
| 5   | Perl        | 6.68%         |
| 6   | bc          | 2.97%         |
| 7   | APL         | 2.22%         |
| 8   | Assembly    | 11.11%        |
| 9   | SQL         | 3.57%         |
| 10  | Shell       | 7.94%         |
| 11  | C           | 8.24%         |
| 12  | Effekt      | 7.99%         |
| 13  | Ruby        | 4.68%         |
| 14  | Go          | 6.10%         |
| 15  | Pascal      | 6.32%         |
| 16  | Common Lisp | 8.22%         |
| 17  | Fortran     | 11.54%        |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
