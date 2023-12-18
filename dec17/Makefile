.PHONY: all
all: part1 part2

.PHONY: part1
part1: common.mod common.o
	$(info Part 1:)
	gfortran -g part1.f90 -o part1 common.o
	./part1

.PHONY: part2
part2: common.mod
	$(info Part 2:)
	gfortran -g part2.f90 -o part2 common.o
	./part2

%.o %.mod: %.f90
	gfortran -c $<
.NOTPARALLEL:
.SILENT:
