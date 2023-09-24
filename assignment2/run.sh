#!/usr/bin/env bash

# Removes all previous object files and output files
./clean.sh

# List of assembly files outputs
FILES=()

# Assemble *.asm files
for file in *; do
	if [[ $file == *.asm ]]
	then
		./assemble.sh "${file}"
		file="$(basename "${file}" .asm).o"
		FILES+=("${file}")
	fi
done

# Compile main.c
C_FILE="main"
echo "Compile $C_FILE"
gcc -c -o $C_FILE.o $C_FILE.c
FILES+=("${C_FILE}.o")

# Link object files
echo "Linking object files"
gcc -no-pie "${FILES[@]}" -o my_program > /dev/null 2>&1

./my_program
