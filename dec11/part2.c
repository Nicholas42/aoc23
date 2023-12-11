#include "common.h"

int main(int argc, const char **argv) {
  FILE *input = open_file(argc, argv);

  if (input == NULL) {
    return 1;
  }

  Position galaxies[1024];

  const Position *const galaxy_end = read_galaxies(input, galaxies);
  fclose(input);

  expand(galaxies, galaxy_end, 1000000);

  const long total_distance = compute_all_pairs_distance(galaxies, galaxy_end);
  printf("%ld\n", total_distance);
}
