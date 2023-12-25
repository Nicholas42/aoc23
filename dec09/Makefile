.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1:
	$(info Part 1:)
	sqlite3 ':memory:' '.read part1.sql'

.PHONY: Part2
Part2:
	$(info Part 2:)
	sqlite3 ':memory:' '.read part2.sql'

.NOTPARALLEL:
.SILENT:
