#include <stdio.h>

extern void output_array(const double *, const long);

void output_array(const double *array, const long size)
{
  for (long i = 0; i < size; i++)
  {
    printf("%.8f\n", *(array + i));
  }
}
