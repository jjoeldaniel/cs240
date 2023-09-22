#!/usr/bin/env bash

# Joel Daniel Rico
# CPSC 240
# Section 01
# Program Name: CPSC 240 Assignment 2 - Arrays

# Removes all previous object files and output files
rm -f *.o
rm -f *.lis

# Compile main.c
C_FILE="main"
echo "Compile $C_FILE"
gcc -o $C_FILE.o $C_FILE.c -std=c17

# Assemble *.asm files
for file in *; do
	if [[ $file == *.asm ]]
	then
		# nasm -f elf64 -o "${file}".o "${file}".asm
		echo "${file}"
	fi
done

chmod +x ./main.o
./main.o
