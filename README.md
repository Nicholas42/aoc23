# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 2.56%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 1.82%         |
| 3   | [vim](https://www.vim.org/)                                           | 2.71%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 2.43%         |
| 5   | [Perl](https://www.perl.org/)                                         | 5.15%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 2.29%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 1.71%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 8.56%         |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 2.75%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 6.12%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 6.35%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 15.11%        |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 3.61%         |
| 14  | [Go](https://go.dev/)                                                 | 4.70%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 4.87%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 5.05%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 8.89%         |
| 18  | [Elixir](https://elixir-lang.org/docs.html)                           | 2.75%         |
| 19  | [ALGOL 68](https://en.wikipedia.org/wiki/ALGOL_68)                    | 12.50%        |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
