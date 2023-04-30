/*
Given two numbers H, W (height, width), output the area and perimeter of the
rectangle.

• Input: H, W
• Output: Area P erimeter
*/

.section .rodata
.INP_STR:
    .string "%Ld %Ld"     # input string since we are taking two inputs

.OUT_STR:
    .string "%Ld %Ld\n"   # output string since we are printing two outputs

.section    .text 
.globl  main   

main:
    subq    $56, %rsp               # allocating 56 bytes on the stack (since it was not giving any errors for 56 bytes)
    leaq    .INP_STR(%rip), %rdi    # loading the input string into rdi which is the first argument of scanf
    leaq    (%rsp), %rsi            # loading the address of the first input into rsi which is the second argument of scanf
    leaq    4(%rsp), %rdx           # loading the address of the second input into rdx which is the third argument of scanf

    call __isoc99_scanf@PLT         # calls the scanf function

    movq    (%rsp), %r8             # moving the first input into r8
    movq    4(%rsp), %r9            # moving the second input into r9=
    
    movq    %r8, %rsi       # moving the first input into rsi which is the second argument of printf     
    movq    %r8, %rdx       # moving the first input into rdx which is the third argument of printf

    # rsi has the area 
    imulq   %r9, %rsi       # multiplying the first input with the second input and storing it in rsi

    # rdx has the perimeter
    addq    %r9, %rdx       # adding the first input with the second input and storing it in rdx
    imulq   $2, %rdx        # multiplying the sum of the first and second input with 2 and storing it in rdx

    leaq    .OUT_STR(%rip), %rdi        # loading the output string into rdi which is the first argument of printf
    # the second argument of printf is already in rsi
    # the third argument of printf is already in rdx
    call    printf@PLT

    addq    $56, %rsp       # deallocating the 56 bytes from the stack
    xorq    %rax, %rax      # clearing the return value of rax to 0
    ret

