#include <stdio.h>

extern double manage();

int main() {
	printf("Welcome to Array Management System");
	printf("This product is maintained by Your Name at joeldanielrico@csu.fullerton.edu");

	float result = 1;
	manage();

	printf("The main function received %f and will keep it for a while.\nPlease consider buying more software from our suite of commercial program.\nA zero will be returned to the operating system.  Bye\n", result);

	return 0;
}
