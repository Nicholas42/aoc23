.PHONY: all
all: part1 part2

.PHONY: part1
part1: part1.elf
	$(info Part 1:)
	./part1.elf

.PHONY: part2
part2: part2.elf
	$(info Part 2:)
	./part2.elf

%.elf: %.o common.o
	ld -o $@ common.o $<

%.o: %.asm
	nasm -f elf64 -g -o $@ $<

.PHONY: clean
clean:
	rm *.o
	rm *.elf

.NOTPARALLEL:
.SILENT:
