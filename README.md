# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 3.20%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 2.28%         |
| 3   | [vim](https://www.vim.org/)                                           | 3.39%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 3.04%         |
| 5   | [Perl](https://www.perl.org/)                                         | 6.45%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 2.87%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 2.14%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 10.73%        |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 3.45%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 7.67%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 7.95%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 7.72%         |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 4.52%         |
| 14  | [Go](https://go.dev/)                                                 | 5.89%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 6.10%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 7.94%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 11.14%        |
| 18  | [Elixir](https://elixir-lang.org/docs.html)                           | 3.44%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
