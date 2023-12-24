# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 2.01%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 1.42%         |
| 3   | [vim](https://www.vim.org/)                                           | 2.12%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 1.90%         |
| 5   | [Perl](https://www.perl.org/)                                         | 4.04%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 1.79%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 1.34%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 6.72%         |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 2.16%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 4.80%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 4.98%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 11.86%        |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 2.83%         |
| 14  | [Go](https://go.dev/)                                                 | 3.69%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 3.82%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 3.96%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 6.98%         |
| 18  | [Elixir](https://elixir-lang.org/docs.html)                           | 2.16%         |
| 19  | [ALGOL 68](https://en.wikipedia.org/wiki/ALGOL_68)                    | 9.81%         |
| 20  | [Rust](https://www.rust-lang.org/)                                    | 6.25%         |
| 21  | [Kotlin](https://kotlinlang.org/)                                     | 5.52%         |
| 22  | [Lua](https://lua.org/docs.html)                                      | 5.70%         |
| 24  | [Python](https://docs.python.org/3/)                                  | 4.03%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
