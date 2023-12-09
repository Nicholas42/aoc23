.PHONY: all
all: part1 part2

.PHONY: part1
part1:
	$(info Part 1:)
	sqlite3 ':memory:' '.read part1.sqlite'

.PHONY: part2
part2:
	$(info Part 2:)
	sqlite3 ':memory:' '.read part2.sqlite'

.NOTPARALLEL:
.SILENT:
