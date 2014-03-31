 .data

int_label: 
	.space 4

mescanfff:
	.string "%d"
	.text
meprintfff:
	.string "Syma 1..N =%d\n"
	.text
	.globl main

main:
//prolog
	pushl %ebp
	movl %esp,%ebp

//scan data
	pushl $int_label
	pushl $mescanfff
	call scanf
	addl $8,%esp

	movl $0, %eax
	movl int_label, %ebx

	cmp $0,%ebx
	jne loop_start
		movl $0,%eax
		jmp mypr
	loop_start:
		cmp $0,%ebx
		jne letsdoit
			jmp loop_end
		letsdoit: 
		 	addl %ebx, %eax
			dec %ebx
			jmp loop_start
	loop_end: jmp mypr


mypr: 
	pushl %eax
	pushl $meprintfff
	call printf
	addl $8,%esp



//make stack well
	movl %esp,%ebp
	popl %ebp

	movl $0, %eax
ret

        
