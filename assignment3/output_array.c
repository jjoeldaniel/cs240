// Name: Joel Daniel Rico
// CWID: 885687517
// Program:
//
// This program takes input of a float array, displays
// the inputed values, sorts in ascending order, and returns 
// the newly sorted array.

#include <stdio.h>

extern void output_array(const double *, const long);

void output_array(const double *array, const long size)
{
  for (long i = 0; i < size; i++)
  {
    printf("%.8f\n", *(array + i));
  }
}
