.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1: part1
	$(info Part 1:)
	./part1

.PHONY: Part2
Part2:
	$(info Part 2:)
	$(info Nothing to do...)

%: %.zig
	zig build-exe -O ReleaseSafe $^ -femit-bin=$@

.PHONY: clean
clean:
	rm part?
	rm part?.o

.NOTPARALLEL:
.SILENT:
