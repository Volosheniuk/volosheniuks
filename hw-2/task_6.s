.data

chislo:
.space 4
scanchislo:
.string "%d"
mystr:
.string "OF=%d SF=%d ZF=%d  CF=%d\n"

.macro outf
//vse 0
	subl $16, %esp
	movl $0, -4(%ebp)
	movl $0, -8(%ebp)
	movl $0, -12(%ebp)
	movl $0, -16(%ebp)
//if flag not 0	
	jnc CF0
	movl $1, -4(%ebp)
	CF0:
	je ZF0
	movl $1, -8(%ebp)
	ZF0:
	jns SF0
	movl $1, -12(%ebp)
	SF0:
	jno OF0
	movl $1, -16(%ebp)
	OF0:
//wright flag
	pushl -4(%ebp)
	pushl -8(%ebp)
	pushl -12(%ebp)
	pushl -16(%ebp)
	pushl $mystr
	call printf        
	addl $8, %esp	
.endm
.text
.globl main

main:
//prolog
	pushl %ebp
	movl %esp, %ebp
	pushl $chislo
	pushl $scanchislo
	call scanf
	addl $8, %esp
//macro	
	outf
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
ret


