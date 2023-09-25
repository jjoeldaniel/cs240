// Name: Joel Daniel Rico
// CWID: 885687517
// Program: Prompts input and stores in array

#include <stdio.h>

extern double manage();

int main() {
	printf("\n\nWelcome to Array Management System\n");
	printf("This product is maintained by Joel Daniel Rico at joeldanielrico@csu.fullerton.edu\n\n");

	double result = manage();

	printf("\nThe main function received %f and will keep it for a while.\nPlease consider buying more software from our suite of commercial program.\nA zero will be returned to the operating system. Bye\n", result);

	return 0;
}
