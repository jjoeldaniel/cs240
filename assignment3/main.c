// Name: Joel Daniel Rico
// CWID: 885687517
// Program:
//
// This program takes input of a float array, displays
// the inputed values, sorts in ascending order, and returns
// the newly sorted array.

#include <stdio.h>

extern double **director(unsigned long *n);

int main() {
  printf("\nWelcome to a great program developed by Joel Daniel Rico.\n");

  unsigned long size = 0;
  double **arr = director(&size);

  printf("\nThe main function received this set of numbers:\n");
  for (unsigned long i = 0; i < size; i++) {
    printf("%1.10lf\n", *(arr[i]));
  }

  printf("Main will keep these and send a zero to the operating system.\n");

  return 0;
}
