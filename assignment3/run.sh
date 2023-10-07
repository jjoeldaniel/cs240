#!/usr/bin/env bash

# Name: Joel Daniel Rico
# CWID: 885687517
# Program:
#
# This program takes input of a float array, displays
# the inputed values, sorts in ascending order, and returns 
# the newly sorted array.

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

for file in *; do
	if [[ $file == *.asm ]]
	then

		# Remove file extension
		file="$(basename "${file}" .asm)"

		# Assemble
		nasm -f elf64 -o "${file}".o "${file}".asm 

		# Append
		FILES+=("${file}.o")

	elif [[ $file == *.c ]]
	then

		# Remove file extension
		file="$(basename "${file}" .c)"

		# Compile
		gcc -c -o "${file}".o "${file}".c

		# Append
		FILES+=("${file}.o")
	
	elif [[ $file == *.cpp ]]
	then

		# Remove file extension
		file="$(basename "${file}" .cpp)"

		# Compile
		g++ -o "${file}".o "${file}".cpp

		# Append
		FILES+=("${file}.o")

	fi
done

OUTPUT_FILE="program"

# Link object files
gcc -no-pie "${FILES[@]}" -o "${OUTPUT_FILE}" -z noexecstack

# Removes all previous object files
rm -f ./*.o

./"${OUTPUT_FILE}"
