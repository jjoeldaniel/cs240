#!/usr/bin/env bash

# Name: Joel Daniel Rico
# CWID: 885687517
# Program: Prompts input and stores in array

echo "Tested on: NASM version 2.16.01"
if command -v nasm &> /dev/null
then
	echo "Your NASM version: $(nasm -v)"
	echo ""
fi

# Removes all previous object files and output files
rm -f ./*.o
find . -type f  ! -name "*.*"  -delete

# List of assembly files outputs
FILES=()

# Assemble *.asm files
for file in *; do
	if [[ $file == *.asm ]]
	then

		# Remove file extension
		file="$(basename "${file}" .asm)"

		# Assemble
		nasm -f elf64 -o "${file}".o "${file}".asm 

		# Append
		FILES+=("${file}.o")
	fi
done

# Compile main.c
C_FILE="main"
gcc -c -o $C_FILE.o $C_FILE.c
FILES+=("${C_FILE}.o")

# Link object files
gcc -no-pie "${FILES[@]}" -o my_program > /dev/null 2>&1

# Removes all previous object files
rm -f ./*.o

./my_program
