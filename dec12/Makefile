NPROC=$(shell nproc)
.PHONY: all
all: part1 part2

.PHONY: part1
part1:
	$(info Part 1:)
	effekt.sh part1.effekt

.PHONY: part2
part2:
	$(info Part 2:)
	effekt.sh --compile part2.effekt

	# Poor mans parallelization
	cat input.txt | head -n 10 | xargs -P $(NPROC) -n 20 -d '\n' ./part2 dummy | paste -sd+ | bc

.NOTPARALLEL:
.SILENT:
