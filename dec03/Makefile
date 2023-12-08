.PHONY: all
all: part1 part2

.PHONY: part1
part1:
	$(info Part 1:)
	./part1.vim input.txt >& /dev/null
	cat result_part1.txt

.PHONY: part2
part2:
	$(info Part 2:)
	./part2.vim input.txt >& /dev/null
	cat result_part2.txt

.NOTPARALLEL:
.SILENT:
