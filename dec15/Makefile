.PHONY: all
all: part1 part2

.PHONY: part1
part1:
	$(info Part 1:)
	fpc part1.pas
	./part1

.PHONY: part2
part2:
	$(info Part 2:)
	fpc part2.pas
	./part2

.PHONY: clean
clean:
	rm part? part?.o
.NOTPARALLEL:
.SILENT:
