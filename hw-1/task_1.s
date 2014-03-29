    .data

int_label1:
    .space 4
int_label2:
    .space 4
scannstring:
    .string "%d"
endprint:
    .string "\n"


    .text
    .globl main
main:
//prolog
    pushl %ebp 
    movl %esp, %ebp 
    
   
 //read data   
    pushl $int_label1
    pushl $scannstring 
    call scanf
    addl $8, %esp
    movl int_label1, %eax 
    
    movl $0, %edx 
//ebx ==counter
    movl $0, %ebx 
    movl $2, %ecx 
    
start:
    cmpl $0, %eax 
    jng middle

    movl $0, %edx 
    divl %ecx 
    pushl %edx
    
    incl %ebx
    jmp start
middle:
    cmpl $0, %ebx 
    jng end

    pushl $scannstring 
    call printf
    addl $8, %esp

    decl %ebx 
    jmp middle
end:

    pushl $endprint
    call printf
    addl $4, %esp
    
    movl %ebp, %esp
    popl %ebp
    movl $0, %eax
    ret
