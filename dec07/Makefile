.PHONY: all
all: part1 part2

.PHONY: part1
part1:
	$(info Part 1:)
	./part1.apl 2> /dev/null

.PHONY: part2
part2:
	$(info Part 2:)
	sleep 1 # Otherwise, we somehow have a broken pipe
	./part2.apl 2> /dev/null

.NOTPARALLEL:
.SILENT:
