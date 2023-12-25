.PHONY: All
All: Part1 Part2

.PHONY: Part1
Part1: common.mod common.o
	$(info Part 1:)
	gfortran -g part1.f90 -o part1 common.o
	./part1

.PHONY: Part2
Part2: common.mod
	$(info Part 2:)
	gfortran -g part2.f90 -o part2 common.o
	./part2

%.o %.mod: %.f90
	gfortran -c $<
.NOTPARALLEL:
.SILENT:
