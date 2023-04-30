.INP_STR:
    .string "%Ld %Ld %Ld %Ld %Ld"

.OUT_STR:
    .string "%Ld %Ld\n"

.global main

main:
    subq $40, %rsp
    leaq .INP_STR(%rip), %rdi
    movq %rsp, %rsi
    leaq 8(%rsp), %rdx
    leaq 16(%rsp), %rcx
    leaq 24(%rsp), %r8
    leaq 32(%rsp), %r9
    call __isoc99_scanf@PLT

    movq (%rsp), %r12 # %rax will store the minimum
    movq (%rsp), %r13 # %rbx will store the maximum
    movq %rsp, %r14

    movq $8, %rbx

maximum:
    cmp $39, %rbx
    jg end

    # Maximum
    cmp %r13, (%r14)
    jg switch1

    # Minimum
    cmp %r12, (%r14)
    jl switch2


    addq $8, %rbx
    movq %rsp, %r14
    addq %rbx, %r14 # incrementing add(rsp) by 8 # Incrementing the address
    jmp maximum

switch1:
    movq (%r14), %r13
    jmp maximum

switch2:
    movq (%r14), %r12
    jmp maximum

end:
    leaq .OUT_STR(%rip), %rdi
    movq %r12 ,%rsi
    movq %r13, %rdx
    call printf@PLT
    addq $40, %rsp
    xorl %eax, %eax
    ret
