# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 3.32%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 2.36%         |
| 3   | [vim](https://www.vim.org/)                                           | 3.51%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 3.15%         |
| 5   | [Perl](https://www.perl.org/)                                         | 6.68%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 2.97%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 2.22%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 11.11%        |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 3.57%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 7.94%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 8.24%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 7.99%         |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 4.68%         |
| 14  | [Go](https://go.dev/)                                                 | 6.10%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 6.32%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 8.22%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 11.54%        |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
