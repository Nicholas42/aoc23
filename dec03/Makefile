.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1:
	$(info Part 1:)
	./part1.vim input.txt >& /dev/null
	cat result_part1.txt

.PHONY: Part2
Part2:
	$(info Part 2:)
	./part2.vim input.txt >& /dev/null
	cat result_part2.txt

.NOTPARALLEL:
.SILENT:
