# Advent of Code 2023

## Intention

I plan to solve every day of this Advent of Code with a different programming/scripting language. The current solves are:

| Day          | Language                                                              | Share of code |
| ------------ | --------------------------------------------------------------------- | ------------- |
| [1](dec01/)  | [sed](https://www.gnu.org/software/sed/manual/sed.html)               | 1.68%         |
| [2](dec02/)  | [awk](https://www.gnu.org/software/gawk/manual/gawk.html)             | 1.19%         |
| [3](dec03/)  | [vim](https://www.vim.org/)                                           | 1.78%         |
| [4](dec04/)  | [jq](https://jqlang.github.io/jq/)                                    | 1.59%         |
| [5](dec05/)  | [Perl](https://www.perl.org/)                                         | 3.39%         |
| [6](dec06/)  | [bc](https://www.gnu.org/software/bc/manual/html_chapter/bc_toc.html) | 1.50%         |
| [7](dec07/)  | [GNU APL](https://www.gnu.org/software/apl/)                          | 1.12%         |
| [8](dec08/)  | [asm](https://en.wikipedia.org/wiki/Assembly_language)                | 5.63%         |
| [9](dec09/)  | [SQLite](https://www.sqlite.org/docs.html)                            | 1.81%         |
| [10](dec10/) | [Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) | 4.02%         |
| [11](dec11/) | [C](https://www.open-std.org/jtc1/sc22/wg14/)                         | 4.17%         |
| [12](dec12/) | [Effekt](https://effekt-lang.org/)                                    | 9.93%         |
| [13](dec13/) | [Ruby](https://www.ruby-lang.org/en/)                                 | 2.37%         |
| [14](dec14/) | [Go](https://go.dev/)                                                 | 3.09%         |
| [15](dec15/) | [Free Pascal](https://www.freepascal.org/)                            | 3.20%         |
| [16](dec16/) | [Common Lisp](https://lisp-lang.org/)                                 | 3.32%         |
| [17](dec17/) | [Fortran](https://fortran-lang.org/)                                  | 5.85%         |
| [18](dec18/) | [Elixir](https://elixir-lang.org/docs.html)                           | 1.81%         |
| [19](dec19/) | [ALGOL 68](https://en.wikipedia.org/wiki/ALGOL_68)                    | 8.22%         |
| [20](dec20/) | [Rust](https://www.rust-lang.org/)                                    | 5.23%         |
| [21](dec21/) | [Kotlin](https://kotlinlang.org/)                                     | 4.63%         |
| [22](dec22/) | [Lua](https://lua.org/docs.html)                                      | 4.77%         |
| [23](dec23/) | [C++2](https://github.com/hsutter/cppfront/tree/main)                 | 8.56%         |
| [24](dec24/) | [Python](https://docs.python.org/3/)                                  | 3.37%         |
| [25](dec25/) | [Zig](https://ziglang.org/)                                           | 7.63%         |

## Technical Details

Every day is in a separate directory named like `dec07`. Each directory contains a Makefile with the targets `All` (default), `Part1` and `Part2`. The latter will run the solver on the two parts respectively and the former just runs both parts.

If you provide your session cookie in the [format used by wget](https://unix.stackexchange.com/questions/36531/format-of-cookies-when-using-wget) you can use `./get_input.sh` to retrieve todays input.
