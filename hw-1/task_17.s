.data

int_count: 
     .space 4
 scann_string:
 	.string "%d"
	.text
printf_string:
	.string "%d\n"
	.text
	.globl main


main:

//prolog
	pushl %ebp
	movl %esp,%ebp

//scan data
	pushl $int_count
	pushl $scann_string
	call scanf
	addl $8,%esp

//for 1---count do
	movl int_count,%ecx
	movl $0,%eax
	cmp $0, %ecx
	jne for
	   jmp  myprintf
	for:
		addl %ecx,%eax
		loop for
//printf
   myprintf:
	pushl %eax
	pushl $printf_string
	call printf
	addl $8,%esp

//make stack well
	movl %esp,%ebp
	popl %ebp

	movl $0,%eax

ret 


