// Name: Joel Daniel Rico
// CWID: 885687517
// Program:
//
// This program takes input of a float array, displays
// the inputed values, sorts in ascending order, and returns
// the newly sorted array.

#include <stdio.h>

extern void output_array(const double *[], const unsigned long);

void output_array(const double *array[], const unsigned long size) {
  for (unsigned long i = 0; i < size; i++) {
    printf("%1.10lf\n", *(array[i]));
  }
}
