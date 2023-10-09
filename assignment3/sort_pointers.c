// Name: Joel Daniel Rico
// CWID: 885687517
// Program:
//
// This program takes input of a float array, displays
// the inputed values, sorts in ascending order, and returns
// the newly sorted array.

#include <stdio.h>

extern void sort_pointers(double *[], const unsigned long);

void sort_pointers(double *array[], unsigned long size) {

  // bool
  int swapped = 0;

  for (unsigned long i = 0; i < size; i++) {

    for (unsigned long j = 0; j < size - i - 1; ++j) {

      // comparison
      if (*(array[j]) > *(array[j + 1])) {
        double *temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;

        // set swapped to true
        swapped = 1;
      }
    }
    // break if no swaps
    if (swapped != 1) {
      break;
    }

    // reset to false
    swapped = 0;
  }
}
