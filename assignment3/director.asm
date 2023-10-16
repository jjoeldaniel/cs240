; ****************************************************************************************************************************
; Program name: "Array Sorter". This program takes an array input, sorts it, and prints the result                           *
; Copyright (C) 2023  Joel Daniel Rico                                                                                       *
;                                                                                                                            *
; This file is part of the software program "Array Sorter".                                                                  *                         
; "Array Sorter" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
; License version 3 as published by the Free Software Foundation.                                                            *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
; <https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: holliday@fullerton.edu                      *
; ****************************************************************************************************************************
;
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author information
;  Name: Joel Daniel Rico
;  CWID: 885687517
;  Email: joeldanielrico@csu.fullerton.edu
;
; Program information
;  Program name: Array Sorter
;  Programming languages: One module in C++ one module in C, two modules in X86-64, and one module in Bash.
;  Date program began: 2023-Oct-6
;  Date of last update: 2023-Oct-15
;  Files in this program: director.asm, input_array.asm, main.c, output_array.c, rx.sh, sort_pointers.asm
;  Status: This program was tested over a dozen times on Fedora 38 (Oct 2023) without errors.
;  Purpose: The program takes an array input, sorts it, and prints the result
;
; This file
;  Name: director.asm
;  Language: X86-64
;  Purpose: Manages input of an array, sorting, printing of the final result, and returning to main.c
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


extern scanf, printf
extern input_array, output_array
extern sort_pointers

section .data
    message1 db "This program will sort all of your doubles.", 10, 0
    message2 db 10, "Please enter floating point numbers separated by white space.  After the last numeric input enter at least one more white space and press cntl+d.", 10, 0
    message3 db 10, "Thank you.  You entered these numbers:", 10, 0
    message4 db "End of output array.", 0
    message5 db 10, 10, "The array is now being sorted without moving any numbers.", 10, 0
    message6 db 10, "The data in the array is now ordered as follows:", 10, 0
    message7 db 10, 10, "The array will be sent back to the caller function.", 10, 0

    float_format db "%lf", 0

    maximum_array_size equ 10

section .bss
    align 64
    backup_r resb 832
    array resq maximum_array_size

%macro print 1
    mov rax, 0
    mov rdi, %1
    call printf
%endmacro

%macro backup 0
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf
%endmacro

%macro restore 0
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp
%endmacro

section .text
    global director

director:
    backup

    ; Component Restore
    mov     rax, 7
    mov     rdx, 0
    xsave   [backup_r]

    ; Initial prompt
    print message1
    print message2

    ; Call input_array
    mov   rax, 0
    mov   rdi, array
    mov   rsi, maximum_array_size
    call  input_array
    mov   r13, rax

    ; NOTE: r13 = Size of array

    print message3

    ; Call output_array
    mov   rax, 0
    mov   rdi, array
    mov   rsi, r13
    call  output_array

    print message4
    print message5

    print message6

    ; Sort
    mov   rax, 0
    mov   rdi, array
    mov   rsi, r13
    call  sort_pointers

    ; Print sorted array
    mov   rax, 0
    mov   rdi, array
    mov   rsi, r13
    call  output_array
    print message4

    ; Print final message
    print message7

    ; Component Restore
    mov     rax, 7
    mov     rdx, 0
    xsave   [backup_r]

    ; Return
    mov rax, r13

    restore

    mov qword[rdi], rax
    mov rax, array

    ret
