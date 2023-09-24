#!/usr/bin/env bash

# Remove file extension
FILE="$(basename "$1" .asm)"

echo "Assemble ${FILE}"
nasm -f elf64 -o "${FILE}".o "${FILE}".asm 
