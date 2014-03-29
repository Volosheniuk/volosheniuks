	.data
printfstring:
	.string "%d"
charstring:
	.string "%c"
count:
	.space 4
suma:
	.space 4
pr:
	.string "\n"
array:
	.long 1, 2, 4, 8
array_end:
	.text

//print suma
justpr:
	pushl %ecx
	pushl suma
	pushl $printfstring
	call printf
	addl $8, %esp
	popl %ecx
	jmp getres
	.globl main
main:

	pushl %ebp
	movl %esp, %ebp

	movl $8, %ecx
start:
	movl $12, count
	movl $0, suma
letsstart:
	pushl %ecx
	call getchar
	popl %ecx
	movl $array, %edx
	addl count, %edx
	movl (%edx), %ebx

	subb $48, %al
	cmpb $0, %al
	je end
	addl %ebx, suma
end:
	subl $4, count
	cmpl $0, count
	jge letsstart
	cmpl $10, suma
	jl justpr
	subl $10, suma
	addl $65, suma
	pushl %ecx
	pushl suma
	pushl $charstring
	call printf
	addl $8, %esp
	popl %ecx
getres:
	decl %ecx
	cmpl $0, %ecx
	jg start
	pushl $pr
	call printf
	addl $4, %esp
//make stack well
	movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
ret
