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
		file="$(basename "${file}" .c)"

		# Compile
		gcc -o "${file}".o "${file}".c

		# Append
		FILES+=("${file}.o")

	fi
done

# Link object files
gcc -no-pie "${FILES[@]}" -o my_program -z noexecstack

# Removes all previous object files
rm -f ./*.o

./my_program
