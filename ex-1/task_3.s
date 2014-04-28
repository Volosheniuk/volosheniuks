		.data
myscan:
        .string "%c"
myprint:
        .string "%c"
stringend:
        .string "\n"
mydata:
        .space 1
.text
.globl main
main:
        pushl %ebp
        movl %esp, %ebp
//our counter
        movl $9, %ebx 

letsgo:
        cmpl $0 , %ebx
        je finish
        decl %ebx
        pushl $mydata
        pushl $myscan
        call scanf
        addl $8, %esp

 

		movb mydata, %al
		pushl %eax
		jmp letsgo

		finish:
		movl $10, %ebx
start2:
         cmpl $0 , %ebx
        decl %ebx
        je end

        pushl $myprint
        call printf

        addl $8, %esp

        jmp start2
end:
        pushl $stringend
        call printf

        addl $4, %esp

        movl $0 , %eax
        movl %ebp, %esp
        popl %ebp
ret
