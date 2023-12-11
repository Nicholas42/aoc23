.PHONY: all
all: part1 part2

.PHONY: part1
part1: part1.elf
	$(info Part 1:)
	./part1.elf input.txt

.PHONY: part2
part2: part2.elf
	$(info Part 2:)
	./part2.elf input.txt

%.elf: %.c common.c common.h
	gcc -Wall -Werror -Wextra -Wconversion -g -o $@ $^

.PHONY: clean
clean:
	rm *.elf

.NOTPARALLEL:
.SILENT:
