.data

int_N: .space 4

myscan: 
	.string "%d"
	.text
myprintt:
	.string "factorial(N)= %d\n"
	.text

	.globl main


main:
//prolog
	pushl %ebp
	movl %esp,%ebp


//scanf
	pushl $int_N
	pushl $myscan
	call scanf
	addl $8,%esp
//do while
	movl int_N, %eax
	movl int_N, %ebx
	dec %ebx
//if N=0 factorial=1
	cmp $0,%eax
	jne not_equal
		movl $1, %eax
		jmp use_myprintfff

	not_equal: 
		cmp $1,%eax
		jne loop_start
			movl $1,%eax
			jmp use_myprintfff
	loop_start:
		
		mull %ebx
		dec %ebx
		cmp $0, %ebx
		je loop_end
		   
		   jmp loop_start
		

	loop_end: jmp use_myprintfff

	use_myprintfff:
		pushl %eax
		pushl $myprintt
		call printf
		addl $8, %esp

//make stack well
	movl %esp,%ebp
	popl %ebp

	movl $0,%eax


ret


