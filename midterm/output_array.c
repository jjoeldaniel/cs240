#include <stdio.h>

extern void output_array(const double *, const unsigned long);

void output_array(const double *array, const unsigned long size) {
  for (long i = 0; i < size; i++) {
    printf("%0.1f ", *(array + i));
  }
}
