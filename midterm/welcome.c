// Name: Joel Daniel Rico
// CWID: 885687517
// Program: Prompts input and stores in array

#include <stdio.h>

extern double manage();

int main() {
	printf("\nWelcome to My Array by Joel Daniel Rico\n");

	double result = manage();

	printf("\n\nThe main function received %0.1f and will study it.\n\n0 will be returned to the operating system.\n", result);

	return 0;
}