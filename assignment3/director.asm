; Name: Joel Daniel Rico
; CWID: 885687517
; Program:
; 
; This program takes input of a float array, displays
; the inputed values, sorts in ascending order, and returns 
; the newly sorted array.

extern scanf, printf
extern input_array, output_array
extern sort_array

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

    ; TODO: Sort
    mov   rax, 0
    mov   rdi, array
    mov   rsi, r13
    call  sort_array

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
