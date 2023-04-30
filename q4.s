/*
Given two numbers M and N, find GCD(M, N).

• Input: MN (0 < M, N < LONG MAX)
• Output: Integral value of the GCD
*/

.section .rodata

.INP_STR:
    .string "%Ld %Ld"    # the format string for scanf

.OUT_STR:
    .string "%Ld\n"  # the format string for printf

.section .text

.globl  main

main:

    subq    $56, %rsp               # allocate space for the local variables (56 since it was not giving any issues)
    leaq    .INP_STR(%rip), %rdi    # load the address of the input string into rdi
    leaq    (%rsp), %rsi        # load the address of the local variable into rsi
    leaq    8(%rsp), %rdx
    call    __isoc99_scanf@PLT  # calls the scanf function
    movq   (%rsp),%rax
    movq   8(%rsp),%rbx
    cmp     %rax, %rbx
    jge     .greater_than
    jle     .less_than


.greater_than:
    
    movq   (%rsp),%rax
    movq   8(%rsp),%rbx
    jmp .euclid_loop

.less_than:

    movq   (%rsp),%rbx
    movq   8(%rsp),%rax
    jmp .euclid_loop


.euclid_loop:

    cqto
    cmp     $0, %rax
    jle      .end
    
    movq    %rax, %r8
    idivq   %rbx
    movq    %r8, %rbx
    movq    %rdx, %rax
    jmp     .euclid_loop


.end:
    movq %rbx, %rsi
    leaq .OUT_STR(%rip), %rdi
    call printf@PLT

    addq    $56, %rsp
    xorq    %rax, %rax
    ret



