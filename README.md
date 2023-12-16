# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language    | Share of code |
| --- | ----------- | ------------- |
| 1   | sed         | 3.75%         |
| 2   | Awk         | 2.67%         |
| 3   | Vim Script  | 3.97%         |
| 4   | jq          | 3.56%         |
| 5   | Perl        | 7.55%         |
| 6   | bc          | 3.36%         |
| 7   | APL         | 2.51%         |
| 8   | Assembly    | 12.56%        |
| 9   | SQL         | 4.04%         |
| 10  | Shell       | 8.98%         |
| 11  | C           | 9.31%         |
| 12  | Effekt      | 9.04%         |
| 13  | Ruby        | 5.29%         |
| 14  | Go          | 6.90%         |
| 15  | Pascal      | 7.14%         |
| 16  | Common Lisp | 9.29%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
