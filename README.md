# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day | Language                                                              | Share of code |
| --- | --------------------------------------------------------------------- | ------------- |
| 1   | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 1.84%         |
| 2   | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 1.31%         |
| 3   | [vim](https://www.vim.org/)                                           | 1.95%         |
| 4   | [jq](https://jqlang.github.io/jq/)                                    | 1.74%         |
| 5   | [Perl](https://www.perl.org/)                                         | 3.70%         |
| 6   | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 1.64%         |
| 7   | [GNU APL](https://www.gnu.org/software/apl/)                          | 1.23%         |
| 8   | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 6.16%         |
| 9   | [SQLite](https://www.sqlite.org/docs.html)                            | 1.98%         |
| 10  | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 4.40%         |
| 11  | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 4.57%         |
| 12  | [Effekt](https://effekt-lang.org/)                                    | 10.86%        |
| 13  | [Ruby](https://www.ruby-lang.org/en/)                                 | 2.59%         |
| 14  | [Go](https://go.dev/)                                                 | 3.38%         |
| 15  | [Free Pascal](https://www.freepascal.org/)                            | 3.50%         |
| 16  | [Common Lisp](https://lisp-lang.org/)                                 | 3.63%         |
| 17  | [Fortran](https://fortran-lang.org/)                                  | 6.39%         |
| 18  | [Elixir](https://elixir-lang.org/docs.html)                           | 1.97%         |
| 19  | [ALGOL 68](https://en.wikipedia.org/wiki/ALGOL_68)                    | 8.99%         |
| 20  | [Rust](https://www.rust-lang.org/)                                    | 5.72%         |
| 21  | [Kotlin](https://kotlinlang.org/)                                     | 5.06%         |
| 22  | [Lua](https://lua.org/docs.html)                                      | 5.22%         |
| 24  | [Python](https://docs.python.org/3/)                                  | 3.69%         |
| 25  | [Zig](https://ziglang.org/)                                           | 8.35%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `All` (default), `Part1` and `Part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
