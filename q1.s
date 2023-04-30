/*
Given two numbers perform basic arithmetic operations, i.e. add,
subtract, divide, modulus- using switch case.

• Input: M N S
• Output: Result of chosen operation in integer format
• Switch case: ’1’ for addition(M + N), ’2’ for subtract(M − N), ’3’ for
divide(M/N) and ’4’ for modulus(M%N)

*/

.section    .rodata

.INP_STR:
    .string "%d %d %d" # since we are inputting three vairables

.OUT_STR:
    .string "%d\n"  # since we have to output one variable

.section    .text

.globl main

main:
    subq $56, %rsp # providing space on stack (56 since it was working without errors)
    
    # scanf("%d %d %d", &a, &b);
    leaq    .INP_STR(%rip), %rdi        # 1st arguement to scanf
    leaq    (%rsp), %rsi                # 2nd arguement to scanf
    leaq    8(%rsp), %rdx               # 3rd arguement to scanf
    leaq    16(%rsp), %rcx              # 4th arguement to scanf

    call     __isoc99_scanf@PLT         # calling the scanf function

    movq    16(%rsp), %rax              # shifting the "type of operation" value to rax

    cmpq    $1, %rax                    # check if the input is equal to 1, then addition
    je      .addition

    cmpq    $2, %rax                    # check if the input is equal to 2, then substraction
    je      .substraction
 
    cmpq $3, %rax                       # check if the input is equal to 3, then division
    je .division

    cmpq $4, %rax                       # check if the input is equal to 4, then modulus
    je .modulus
    

.addition: 
    
    /*
     Function that adds two numbers
    */

    movq     (%rsp), %rax       # moves the first arguement of the input to rax
    addq     8(%rsp), %rax
    jmp     .print_result       # jumps to the print_result function

.substraction:

    /*
     Function that subtracts two numbers
    */

    movq    (%rsp), %rax        # moves the first arguement of the input to rax
    subq    8(%rsp), %rax
    jmp     .print_result       # jumps to the print_result function

.division:

    /*
     Function that divides two numbers
    */

    cqto                    # "convert quadword to octaword"
    xor     %rdx, %rdx      # clearing out rdx register
    movq    (%rsp), %rax
    movq    8(%rsp), %rbx
    div     %rbx            # divides rax by rbx and stores the quotient in rax and remainder in rdx
    
    jmp     .print_result   # jumps to the print_result function

.modulus:

    /*
     Function that finds the modulus of two numbers
    */

    cqto                    # "convert quadword to octaword"
    xor     %rdx, %rdx      # clearing out rdx register
    
    movq    (%rsp), %rax    # moves the first arguement of the input to rax
    movq    8(%rsp), %rbx   # moves the second arguement of the input to rbx
    idivq   %rbx            # divides rax by rbx and stores the quotient in rax and remainder in rdx
    movq    %rdx, %rax      # moves the remainder to rax
    jmp     .print_result   # jumps to the print_result function


.print_result:

    movq    %rax, %rsi              # moves the result to rsi which is the 2nd arguement to printf
    leaq    .OUT_STR(%rip), %rdi    # moves the string to rdi which is the 1st arguement to printf
    call    printf@PLT              # calling the printf function
    addq    $56, %rsp               # frees the 8 bytes on the stack
    xorl    %eax, %eax              # clears the eax register to 0 
    ret







