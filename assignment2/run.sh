#!/usr/bin/env bash

# Joel Daniel Rico
# CPSC 240
# Section 01
# Program Name: CPSC 240 Assignment 2 - Arrays

# Removes all previous object files and output files
./clean.sh

# Assemble *.asm files
for file in *; do
	if [[ $file == manage.asm ]]
	then
		file="$(basename "$file" .asm)"
		nasm -f elf64 -l "${file}".lis -o "${file}".o "${file}".asm 
	fi
done

# Compile main.c
C_FILE="main"
echo "Compile $C_FILE"
gcc -o $C_FILE.o $C_FILE.c -std=c17

# Links the two object files
echo "Linking the object files"
g++ -m64 manage.o main.o -o main -fno-pie -no-pie -std=c++17

./main
