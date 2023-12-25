.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1:
	$(info Part 1:)
	fpc part1.pas
	./part1

.PHONY: Part2
Part2:
	$(info Part 2:)
	fpc part2.pas
	./part2

.PHONY: clean
clean:
	rm part? part?.o
.NOTPARALLEL:
.SILENT:
