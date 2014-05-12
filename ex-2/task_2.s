.data
myprint:
	.string "%.10lf\n"
myscan:	
	.string "%lf %lf"
x:	.space 8
y:	.space 8

.text
.global main
main:
//prolog
pushl	%ebp
movl	%esp,	%ebp
//znachenia
pushl	$y
pushl	$x
pushl	$myscan
call scanf
addl	$0xc,	%esp

finit
	fld1    
//zagr +1 v registr stek
	fldl	y
//st(1)=y
	fldl	x
//st(0)=x
	fsubp   
//st(0)=x-y
	fyl2x	
//log2(x-y)
//log10(x+y)=log2(x+y)/log2(10)

	fldl2t  
//log2(10)
	fld1
	fldl	y   
//st(1)=y
	fldl	x   
//st(0)=x
	faddp	
	fyl2x	
	fdivp
	faddp

	sub	$8,	%esp
	fstpl	(%esp)
	pushl	$myprint
	call printf
	addl	$12,	%esp
//epilog
	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
ret
