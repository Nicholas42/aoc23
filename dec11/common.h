#include <stdio.h>

typedef struct {
  long x;
  long y;
} Position;

Position *read_galaxies(FILE *const input, Position *target);

void expand(Position *const galaxies, const Position *const galaxy_end,
            int expansion_factor);

long compute_all_pairs_distance(const Position *const galaxies,
                                const Position *const galaxy_end);

FILE *open_file(const int argc, const char *const *const argv);
