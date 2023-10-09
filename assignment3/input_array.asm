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
;  Date of last update: 2023-Oct-8
;  Files in this program: director.asm, input_array.asm, main.c, output_array.c, rx.sh, sort_pointers.c
;  Status: This program was tested over a dozen times on Fedora 38 (Oct 2023) without errors.
;  Purpose: The program takes an array input, sorts it, and prints the result
;
; This file
;  Name: input_array.asm
;  Language: X86-64
;  Purpose: Takes user input of an array
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


global input_array
extern scanf, printf, malloc

segment .data
    float_format db "%lf", 0

segment .bss
    align          64
    backup_r  resb 832

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

%macro input 0
    mov rax, 0
    mov rdi, float_format
    mov rsi, r12
    call scanf 
%endmacro

segment .text
input_array:
    backup
    mov         rax, 7
    mov         rdx, 0
    xsave       [backup_r]

    ; Parameters
    mov r14, rdi  ; Array Pointer
    mov r15, rsi  ; Maximnum Array Size
    xor r13, r13  ; Loop Counter
    jmp loop

loop:

    ; Check capacity
    cmp r13, r15
    jge done

    ; Allocate space
    mov         rax, 0
    mov         rdi, 8
    call        malloc
    mov         r12, rax

    ; User input
    input

    ; Ctrl+D check
    cdqe
    cmp rax, -1
    je done

    ; Insert into array
    mov [r14 + r13 * 8], r12

    ; Iterate
    inc r13
    jmp loop
done:

    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_r]

    ; Return input array size
    mov rax, r13

    restore
    ret
