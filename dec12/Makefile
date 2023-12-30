.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1:
	$(info Part 1:)
	effekt.sh part1.effekt

.PHONY: Part2
Part2:
	$(info Part 2:)
	effekt.sh --compile part2.effekt

	# Poor man's parallelization
	parallel -a input.txt ./part2.js dummy | paste -sd+ | bc


.PHONY: Part2.cpp
Part2.cpp: part2
	./part2 input.txt

part2: part2.cpp
	clang++ -std=c++20 part2.cpp -o part2 -g -Wall -Wextra -pedantic -Werror -O3 -ltbb

.NOTPARALLEL:
.SILENT:
