.data

mytext:
	.space 100
mytextcop:
	.space 100
cop:
	.space 1
lengthS:
	.space 4
strstr:
	.string "YOURS STRING:"

ennd:
	.string "\n"
cheker:
	.string "%d"
fmt_str:
	.string "%c"
a:
	.space 4
count:
	.space 4
ptr:
	.space 4





scan_text:
//prolog
	pushl %ebp
	movl %esp,%ebp
//readdata
	movl 8(%ebp),%edi
	movl $0,%ecx
tsikl:
	pushl %ecx
	pushl %edi
	call getchar
	popl %edi
	popl %ecx
	cmpb $32, %al
	je finish
		incl %ecx
		pushl %ecx
		stosb
		popl %ecx
		jmp tsikl


finish:
	movl %ecx, lengthS
	pushl lengthS
	pushl $cheker
	call printf
	addl $8,%esp

//epilog
	movl %ebp,%esp
	popl %ebp
ret


.globl main
main:
//prolog
	pushl	%ebp
	movl	%esp, %ebp


//readstring
	pushl $mytext
	call scan_text
	addl $4,%esp
#	movl %eax, lengthS
//end of reading


#printstring
	pushl $strstr
	call printf
	addl $4,%esp
	movl lengthS,%ecx
	movl $mytext,%esi
typing:
	movl %ecx, count
	lodsb
	movl %esi, ptr
	movl %eax, a
	pushl a
	pushl $fmt_str
	call printf
	addl $8, %esp
	movl ptr, %esi
	movl count, %ecx
loop typing

/*	pushl $ennd
	call printf
	addl $4,%esp
*/
#end of printstring
	




//epilog
	movl    $0,%eax
	movl	%ebp, %esp
	popl	%ebp

ret
