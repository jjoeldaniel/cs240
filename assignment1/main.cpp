#include <iostream>

extern "C"
{
    double calculate();
}

int main()
{
    std::cout << "Welcome to Trip Advisor by Richard Nguyen.\nWe help you plan your trip.\n"
              << std::endl;

    // TODO : take input from calculator
    int num = 0;
    std::cout << "The main module recieved this number " << num << " and will keep it for a while." << std::endl;
    std::cout << "A zero will be sent to your operating sytem.\nGood-bye. Have a safe trip." << std::endl;

    return 0;
}