CPPFRONT_COMMIT=210b2a0855de26ba9b02492aa010792b85e6026e
CXX=clang++ # Version doesn't bild with gcc
CXXFLAGS=-O3 -std=c++20 -Wall -Wextra -g -pedantic -Werror

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

.PHONY: clean
clean:
	rm -f part?.cpp
	rm -f part?

part%: part%.cpp common.h
	$(CXX) $(CXXFLAGS) -DCPP2_IMPORT_STD $< -o $@

%.cpp: %.cpp2 cppfront cpp2util.h
	./cppfront $<

%.h: %.h2 cppfront cpp2util.h
	./cppfront $<

cppfront cpp2util.h:
	{ \
		set -e;\
		TMP=$$(mktemp -d); \
		wget https://github.com/hsutter/cppfront/archive/$(CPPFRONT_COMMIT).zip -P $$TMP; \
		unzip $$TMP/$(CPPFRONT_COMMIT).zip -d $$TMP; \
		$(CXX) $(CXXFLAGS) $$TMP/cppfront-$(CPPFRONT_COMMIT)/source/cppfront.cpp -o cppfront; \
		cp $$TMP/cppfront-$(CPPFRONT_COMMIT)/include/cpp2util.h .;\
	}

.NOTPARALLEL:
# .SILENT:
