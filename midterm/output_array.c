// Name: Joel Daniel Rico
// CWID: 885687517
// Date: 10/25/23
// Program Name: My Array
// File Function: Outputs array 

#include <stdio.h>

extern void output_array(const double *, const unsigned long);

void output_array(const double *array, const unsigned long size) {
  for (long i = 0; i < size; i++) {
    printf("%0.1f ", *(array + i));
  }
}
