# Much faster if available
EXE=$(shell command -v luajit 2> /dev/null)

.PHONY: all
all: part1 part2

.PHONY: part1
part1:
	$(info Part 1:)
	$(EXE) ./part1.lua

.PHONY: part2
part2:
	$(info Part 2:)
	$(EXE) ./part2.lua

.NOTPARALLEL:
.SILENT:
