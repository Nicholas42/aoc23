# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language          |
| --- | ----------------- |
| 1   | sed               |
| 2   | awk               |
| 3   | vim               |
| 4   | jq                |
| 5   | perl              |
| 6   | bc                |
| 7   | gnu-apl           |
| 8   | assembly language |
| 9   | sql               |
| 10  | bash              |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
