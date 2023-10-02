; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

global input_array
extern scanf, printf

segment .data
    float_format db "%lf", 0

%macro backup 0
    push rbp
    mov  rbp,rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf
%endmacro

%macro restore 0
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp
%endmacro

%macro input 0
    mov rax, 0
    mov rdi, float_format
    push qword 0
    mov rsi, rsp
    call scanf 
%endmacro

segment .text
input_array:
    backup
    push qword 0

    ; Parameters
    mov r14, rdi  ; Array Pointer
    mov r15, rsi  ; Maximnum Array Size
    xor r13, r13  ; Loop Counter

loop:

    ; Check capacity
    cmp r13, r15
    je done

    ; User input
    input

    ; ???
    cdqe

    ; Ctrl+D check
    cmp rax, -1
    pop r12
    je done

    ; Insert into array
    mov [r14 + r13 * 8], r12

    ; Iterate
    inc r13
    jmp loop
done:

    ; Return input array size
    pop rax
    mov rax, r13

    restore
    ret
