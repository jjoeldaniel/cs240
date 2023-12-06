; Name: Joel Daniel Rico
; CWID: 885687517
; Email: joeldanielrico@csu.fullerton.edu
; Date: 12/06/23

global manage
extern printf
extern input_array
extern output_array
max_size equ 10

segment .data
    message1 db 10, "We will take care of all your array needs.", 10, "Please input float numbers separated by ws.  After the last number press ws followed by control-d. "
    message2 db "Here are the values in the array.", 10, 10, 0
    message3 db 10, "The numbers of the array have been displayed.", 10, "Thank you for using Array Management System."

segment .bss
    align 64
    storedata resb 832
    input_count resb max_size
    random_number_array resq 10

%macro backup 0
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf
%endmacro

%macro restore 0
    popf          
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp
%endmacro

%macro print 1
    push qword 0
    mov rax, 0
    mov rdi, %1
    call printf
    pop rax
%endmacro

segment .text
manage:
    backup

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    ; Move the number of random numbers to generate (10) into r15
    mov      r15, max_size

    print message1

    ; Generate 10 random numbers inside the array
    mov      rax, 0
    mov      rdi, random_number_array
    mov      rsi, 10 ; Number of random numbers to generate
    call     input_array

    print message2

    ; Show the content of the array
    mov         rax, 0
    mov         rdi, random_number_array
    mov         rsi, r15
    call        output_array

    print message3

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    mov         rax, max_size 
    
    restore

    ; Clean up
    ret
