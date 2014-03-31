.data
    int_label1:
        .space 4
    myprint:
        .string "%x"
    printfd:
        .string "%d"
        pr:
            .string "\n"

.text
    .globl main
main:
//prolog
    pushl %ebp
    movl %esp, %ebp
    

//read data    
    pushl $int_label1
    pushl $myprint
    call scanf
    addl $8, %esp
    movl int_label1, %eax
    
    movl $32, %ecx

    give:
        shll $1,%eax
   
        movl $0, %ebx
        jnc printb
        incl %ebx
        
    printb:
        pushl %eax
        pushl %ecx
        pushl %ebx
        pushl $printfd
        call printf
        addl $8, %esp
        popl %ecx
        popl %eax
    loop give
pushl $pr
        call printf
    movl %ebp, %esp
    popl %ebp
    movl $0, %eax
    ret
