# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 2.09%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 1.48%         |
| 3   | [vim](https://www.vim.org/)                                           | 2.21%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 1.98%         |
| 5   | [Perl](https://www.perl.org/)                                         | 4.21%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 1.87%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 1.40%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 7.00%         |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 2.25%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 5.01%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 5.19%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 12.35%        |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 2.95%         |
| 14  | [Go](https://go.dev/)                                                 | 3.84%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 3.98%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 4.13%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 7.27%         |
| 18  | [Elixir](https://elixir-lang.org/docs.html)                           | 2.25%         |
| 19  | [ALGOL 68](https://en.wikipedia.org/wiki/ALGOL_68)                    | 10.22%        |
| 20  | [Rust](https://www.rust-lang.org/)                                    | 6.51%         |
| 21  | [Kotlin](https://kotlinlang.org/)                                     | 5.76%         |
| 22  | [Lua](https://lua.org/docs.html)                                      | 5.93%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `all` (default), `part1` and `part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
