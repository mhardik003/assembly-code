.INP_STR:
    .string "%Ld %Ld"

.OUT_STR:
    .string "%Ld\n"

.section    .text
.global main

main:
    subq $40, %rsp
    leaq .INP_STR(%rip), %rdi
    movq %rsp, %rsi
    leaq 8(%rsp), %rdx
    call __isoc99_scanf@PLT

    movq (%rsp), %rcx
    cmp 8(%rsp), %rcx  # Comparing M and N, (rax, rbx) will max and min respectively
    jle lesser
    jg greater
    
greater:
    movq (%rsp), %rax
    movq 8(%rsp), %rbx
    jmp div
    
lesser:
    movq (%rsp), %rbx
    movq 8(%rsp), %rax
    jmp div


div:
    xorq %rdx, %rdx
    divq %rbx
    cmp $0, %rdx 
    je end

    movq %rbx, %rax
    movq %rdx, %rbx
    jmp div

end:
    leaq .OUT_STR(%rip), %rdi
    movq %rbx ,%rsi
    call printf@PLT
    addq $40, %rsp
    xorl %eax, %eax
    ret
