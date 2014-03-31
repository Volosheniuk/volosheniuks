  .data
int:
        .space 8
space:
        .space 8
address:
        .int 0x00110012
in_int:
        .string "%d"
out_int:
        .string "%d "
out:
        .string "\n"
.text
.globl main
main:
        pushl %ebp
        movl %esp, %ebp

        pushl $int
        pushl $in_int
        call scanf
        addl $8, %esp
         
        movl $space, %ebx
        movl int, %eax
        movl %eax, space


//neposredstven adress
	movl $23, %eax 
	pushl %eax
	pushl $out_int
	call printf
	addl $8, %esp
    


//priamaia adress
	movl (space), %eax 
	pushl %eax
	pushl $out_int
	call printf
	addl $8, %esp




//kosven adress
	movl (%ebx), %eax 
	pushl %eax
	pushl $out_int
	call printf
	addl $8, %esp

	pushl $out
	call printf
//make stack well	
	movl %ebp, %esp
	popl %ebp
	movl $0, %eax
ret	
