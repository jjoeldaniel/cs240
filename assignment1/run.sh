# Program Name: CPSC 240 Assignment 1 - Compute Trip


# Removes all previous object files and output files
rm -f *.o
rm -f *.lis
rm -f compute-trip

# Compiles asm file
echo "Assembling the file compute_trip.asm"
nasm -f elf64 -l compute-trip.lis -o asm-output.o compute_trip.asm 

# Compiles cpp filea
echo "Compiling the file main.cpp"
g++ -c -m64 -Wall main.cpp -o cpp-output.o -fno-pie -no-pie -std=c++17

# Links the two object files
echo "Linking the object files"
g++ -m64 asm-output.o cpp-output.o -o compute-trip -fno-pie -no-pie -std=c++17


echo "Running the program compute_trip"
echo ""
# Runs the program
./compute-trip