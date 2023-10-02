#include <stdio.h>

extern void output_array(double *, long);

void output_array(double *array, long size)
{
  for (long i = 0; i < size; i++)
  {
    printf("%.8f, ", *(array + i));
  }
}
