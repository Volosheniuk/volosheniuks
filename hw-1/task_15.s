.data
int_label: 
	.space 4
scann_string: 
	.string "%d"
	.text
printff_string: 
	.string "ABS(A)=%d\n"
	.text
.globl  main

main:
//prolog
	pushl %ebp
	movl %esp,%ebp

//scan A
	pushl $int_label
	pushl $scann_string
	call scanf
	addl $8,%esp


	movl int_label,%eax
// if (A<=0)  A=-A
	cmp $0, %eax
	jnl bolshe
		movl $-1, %ebx
		mull %ebx
		jmp myprintf
		
		
	bolshe: 
		jmp myprintf
// myprintf 

	myprintf: 
		pushl %eax
		pushl $printff_string
		call printf
		addl $8,%esp

//reset stack
	movl %esp,%ebp
	popl %ebp
//everything is ok
	movl $0,%eax

	ret
