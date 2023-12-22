# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 2.24%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 1.59%         |
| 3   | [vim](https://www.vim.org/)                                           | 2.37%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 2.12%         |
| 5   | [Perl](https://www.perl.org/)                                         | 4.50%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 2.00%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 1.50%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 7.49%         |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 2.41%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 5.35%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 5.55%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 13.21%        |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 3.15%         |
| 14  | [Go](https://go.dev/)                                                 | 4.11%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 4.26%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 4.42%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 7.78%         |
| 18  | [Elixir](https://elixir-lang.org/docs.html)                           | 2.40%         |
| 19  | [ALGOL 68](https://en.wikipedia.org/wiki/ALGOL_68)                    | 10.94%        |
| 21  | [Kotlin](https://kotlinlang.org/)                                     | 6.16%         |
| 22  | [Lua](https://lua.org/docs.html)                                      | 6.35%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
