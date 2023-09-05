// Joel Daniel Rico
// CPSC 240
// Section 01
// Program Name: CPSC 240 Assignment 1 - Compute Trip

#include <iostream>

extern "C" long long calculate();

int main()
{
    std::cout << "Welcome to Trip Advisor by Joel Daniel Rico.\n"
              << "We help you plan your trip.\n\n";

    long long number = calculate();

    std::cout << "\nThe main module received this number " << number << " and will keep it for a while.\n"
              << "A zero will be sent to your operating system.\n"
              << "Good-bye. Have a great trip.\n";
    return 0;
}