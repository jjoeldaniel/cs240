// ****************************************************************************************************************************
// Program name: "Array Sorter". This program takes an array input, sorts it, and prints the result                           *
// Copyright (C) 2023  Joel Daniel Rico                                                                                       *
//                                                                                                                            *
// This file is part of the software program "Array Sorter".                                                                  *                         
// "Array Sorter" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
// License version 3 as published by the Free Software Foundation.                                                            *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
// <https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: holliday@fullerton.edu                      *
// ****************************************************************************************************************************
//
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// Author information
//  Name: Joel Daniel Rico
//  CWID: 885687517
//  Email: joeldanielrico@csu.fullerton.edu
//
// Program information
//  Program name: Array Sorter
//  Programming languages: One module in C++ one module in C, two modules in X86-64, and one module in Bash.
//  Date program began: 2023-Oct-6
//  Date of last update: 2023-Oct-8
//  Files in this program: director.asm, input_array.asm, main.c, output_array.c, rx.sh, sort_pointers.c
//  Status: This program was tested over a dozen times on Fedora 38 (Oct 2023) without errors.
//  Purpose: The program takes an array input, sorts it, and prints the result
//
// This file
//  Name: main.c
//  Language: C
//  Purpose: Executes program by printing UI and calling director.asm and printing the returned result
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


#include <stdio.h>

extern double **director(unsigned long *n);

int main() {
  printf("\nWelcome to a great program developed by Joel Daniel Rico.\n");

  unsigned long size = 0;
  double **arr = director(&size);

  printf("\nThe main function received this set of numbers:\n");
  for (unsigned long i = 0; i < size; i++) {
    printf("%.5lf\n", *(arr[i]));
  }

  printf("Main will keep these and send a zero to the operating system.\n");

  return 0;
}
