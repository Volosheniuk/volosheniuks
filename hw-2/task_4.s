 .data

x:
.space 4
y:
.space 4

scanchislo:
.string "%f"

printres:
.string "%.2f\n"

.text

.globl main

main:
//prolog
	pushl %ebp
	movl %esp, %ebp

//mainpart read data
	pushl $x
	pushl $scanchislo 
	call scanf
	pushl $y
	pushl $scanchislo
	call scanf
	addl $16, %esp
//math working
	flds y
	flds x
	fyl2x
	frndint
	fld1
	fscale
	flds y
	flds x
	fyl2x 
	frndint
	flds y
	flds x
	fyl2x
	fsubp 
	f2xm1 
	fld1 
	faddp
	fmulp
//end of math
	fstpl (%esp)
	pushl $printres
	call printf
	addl $4, %esp

//epilog
	movl $0, %eax 
	movl %ebp, %esp
	popl %ebp
	ret
