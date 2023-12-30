.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1: part1
	$(info Part 1:)
	./part1 input.txt

.PHONY: Part2
Part2: part2
	$(info Part 2:)
	./part2 input.txt

%: %.rs common.rs
	rustc $<

.NOTPARALLEL:
.SILENT:
