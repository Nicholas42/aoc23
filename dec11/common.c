#include "common.h"
#include <errno.h>
#include <stdlib.h>

int compare_galaxies_by_x(const void *lhs, const void *rhs) {
  const Position *left = (const Position *)lhs;
  const Position *right = (const Position *)rhs;

  if (left->x < right->x) {
    return -1;
  }
  if (left->x > right->x) {
    return 1;
  }
  return 0;
}

void read_galaxies_from_buffer(Position **const target,
                               const char *const buffer,
                               const char *const buffer_end, int *const row,
                               int *const column) {
  for (const char *ptr = buffer; ptr != buffer_end; ++ptr) {
    switch (*ptr) {
    case '#':
      (*target)->x = (*column)++;
      (*target)->y = *row;
      (*target)++;
      break;
    case '\n':
      (*row)++;
      *column = 0;
      break;
    default:
      (*column)++;
    }
  }
}

Position *read_galaxies(FILE *const input, Position *target) {

  const size_t buffer_len = 1024;
  char buffer[buffer_len];
  size_t read_len;
  int row = 0;
  int column = 0;

  while ((read_len = fread(buffer, sizeof(char), buffer_len, input)) > 0) {
    read_galaxies_from_buffer(&target, buffer, buffer + read_len, &row,
                              &column);
  }

  return target;
}

void expand(Position *const galaxies, const Position *const galaxy_end,
            const int expansion_factor) {
  long last_coord = -1;
  long acc_inc = 0;
  for (Position *ptr = galaxies; ptr != galaxy_end; ++ptr) {
    if (ptr->y > last_coord) {
      acc_inc += (expansion_factor - 1) * (ptr->y - last_coord - 1);
    }
    last_coord = ptr->y;
    ptr->y += acc_inc;
  }

  qsort(galaxies, (unsigned long)(galaxy_end - galaxies), sizeof(Position),
        compare_galaxies_by_x);

  last_coord = -1;
  acc_inc = 0;
  for (Position *ptr = galaxies; ptr != galaxy_end; ++ptr) {
    if (ptr->x > last_coord) {
      acc_inc += (expansion_factor - 1) * (ptr->x - last_coord - 1);
    }
    last_coord = ptr->x;
    ptr->x += acc_inc;
  }
}

long compute_distance(const Position *const lhs, const Position *const rhs) {
  return labs(lhs->x - rhs->x) + labs(lhs->y - rhs->y);
}

long compute_all_pairs_distance(const Position *const galaxies,
                                const Position *const galaxy_end) {
  long total_distance = 0;
  for (const Position *lhs_ptr = galaxies; lhs_ptr < galaxy_end - 1;
       ++lhs_ptr) {
    for (const Position *rhs_ptr = lhs_ptr + 1; rhs_ptr < galaxy_end;
         ++rhs_ptr) {
      total_distance += compute_distance(lhs_ptr, rhs_ptr);
    }
  }
  return total_distance;
}

FILE *open_file(const int argc, const char *const *const argv) {

  if (argc < 2) {
    printf("Usage: %s <input>\n", argv[0]);
    return NULL;
  }
  FILE *input = fopen(argv[1], "r");

  if (input == NULL) {
    printf("Couldn't open file %s, errno %d\n", argv[1], errno);
  }
  return input;
}
