# Much faster if available
EXE=$(shell command -v luajit 2> /dev/null)

.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1:
	$(info Part 1:)
	$(EXE) ./part1.lua

.PHONY: Part2
Part2:
	$(info Part 2:)
	$(EXE) ./part2.lua

.NOTPARALLEL:
.SILENT:
