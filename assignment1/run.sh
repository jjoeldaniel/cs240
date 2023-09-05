#!/usr/bin/env bash

nasm -f elf64 -o calculator.o calculator.asm
g++ -o main main.cpp
g++ -m64 -o main main.cpp calculator.o
./main