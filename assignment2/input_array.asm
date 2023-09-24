; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

global input_array
extern scanf

segment .data
fstring db "%lf", 0

%macro backup 0
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
%endmacro

%macro restore 0
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
%endmacro

segment .text
input_array:
    backup
    pushf
    push qword 0
    ; Inputting the information from the parameters into the registers
    mov r14, rdi
    mov r15, rsi
    xor r13, r13
loop:
    ; Ensuring that the capacity isn't surpassed by the counter variable
    cmp r13, r15

    je done
    mov rax, 0
    mov rdi, fstring ; Specify's that a float will be inputted
    push qword 0
    mov rsi, rsp
    call scanf ; Call for the input value
    cdqe ; sign-extends DWORD (32-bit value) in the EAX register to a QWORD (64-bit value) in the RAX register
    cmp rax, -1
    pop r12 ; Pop the value into r12
    je done
    mov [r14 + r13 * 8], r12 ; Place the value at the valid memory address
    inc r13 ; Counter increments
    jmp loop ; Loop repeats
done:
    restore

    ret                                     ;Pop the integer stack and jump to the address equal to the popped value.
