/*
Given a number X, find the first natural number i whose factorial is divisible
by X.

• Input: X
• Output: Integral value of the number whose factorial is to be taken

*/

.section .rodata

.INP_STR:
    .string "%d"    # the format string for scanf

.OUT_STR:
    .string "%d\n"  # the format string for printf

.section .text

.globl  main

main:

    subq    $56, %rsp               # allocate space for the local variables (56 since it was not giving any issues)
    leaq    .INP_STR(%rip), %rdi    # load the address of the input string into rdi
    leaq    (%rsp), %rsi        # load the address of the local variable into rsi

    call    __isoc99_scanf@PLT  # calls the scanf function

    movq    (%rsp), %r8         # will hold the value of X

    movq    $1, %rbx            # will be the answer
    movq    $1, %r9             # holds the factorial

    movq    $1, %rdx            # to avoid breaking the loop in the first instance

    jmp     .loop

.loop:

    imulq   %rbx, %r9   # r9 = r9 * rbx
    movq    %r9, %rax   # rax = r9
    cqto
    idivq   %r8         # rax  = rax / r8 (X), rdx = rax % r8(X)
    
    cmpq    $0, %rdx    # if rdx == 0, then the factorial is divisible by X
    je      .print      # if remainder is 0, then print the answer
    addq    $1, %rbx    # else increment the answer
    jmp     .loop       # and go back to the loop

.print:

    leaq    .OUT_STR(%rip), %rdi    # load the address of the output string into rdi
    movq    %rbx, %rsi              # load the value of the answer into rsi
    call    printf@PLT              # calls the printf function

    xorq    %rax, %rax              # return 0
    addq    $56, %rsp               # deallocate the space for the local variables
    ret
