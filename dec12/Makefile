NPROC=$(shell nproc)
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

	# Poor mans parallelization
	cat input.txt | head -n 10 | xargs -P $(NPROC) -n 20 -d '\n' ./part2 dummy | paste -sd+ | bc

.NOTPARALLEL:
.SILENT:
