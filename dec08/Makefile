.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1: part1
	$(info Part 1:)
	./part1

.PHONY: Part2
Part2: part2
	$(info Part 2:)
	./part2

%: %.o common.o
	ld -o $@ common.o $<

%.o: %.asm
	nasm -f elf64 -g -o $@ $<

.PHONY: clean
clean:
	rm *.o
	rm part?

.NOTPARALLEL:
.SILENT:
