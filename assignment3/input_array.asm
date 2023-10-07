; Name: Joel Daniel Rico
; CWID: 885687517
; Program:
;
; This program takes input of a float array, displays
; the inputed values, sorts in ascending order, and returns 
; the newly sorted array.

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
