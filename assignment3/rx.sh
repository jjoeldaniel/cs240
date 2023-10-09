#!/usr/bin/env bash

# ****************************************************************************************************************************
# Program name: "Array Sorter". This program takes an array input, sorts it, and prints the result                           *
# Copyright (C) 2018  Floyd Holliday                                                                                         *
#                                                                                                                           *
# This file is part of the software program "Array Sorter".                                                                  *                         
# "Array Sorter" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
# License version 3 as published by the Free Software Foundation.                                                            *
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
# A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
# <https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: holliday@fullerton.edu                      *
# ****************************************************************************************************************************
#
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
# Author information
#  Name: Joel Daniel Rico
#  CWID: 885687517
#  Email: joeldanielrico@csu.fullerton.edu
#
# Program information
#  Program name: Array Sorter
#  Programming languages: One module in C++ one module in C, two modules in X86-64, and one module in Bash.
#  Date program began: 2023-Oct-6
#  Date of last update: 2023-Oct-8
#  Files in this program: director.asm, input_array.asm, main.c, output_array.c, rx.sh, sort_pointers.c
#  Status: This program was tested over a dozen times on Fedora 38 (Oct 2023) without errors.
#  Purpose: The program takes an array input, sorts it, and prints the result
#
# This file
#  Name: rx.sh
#  Language: Bash
#  Purpose: Deletes old files, assembles and compiles all necessary files, then links and executes finished program
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


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
