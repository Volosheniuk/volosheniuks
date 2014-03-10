.text
.globl	my_minus
.globl  my_plus
.globl  my_mult
.globl  my_div
.globl  my_inc
.globl  my_dec

my_minus:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	popl	%ebx

	movl	%ebp, %esp
	popl	%ebp
	ret
;/////////////////////////////////
my_plus:
        pushl   %ebp
        movl    %esp, %ebp

        pushl   %ebx
        movl    8(%ebp), %eax
        movl    12(%ebp), %ebx
        addl    %eax, %ebx
        movl    %ebx, %eax
        popl    %ebx

        movl    %ebp, %esp
        popl    %ebp
        ret

;//////////////////////////////////
my_mult:
	pushl   %ebp
        movl    %esp, %ebp

        pushl   %ebx
        movl    8(%ebp), %eax
        movl    12(%ebp), %ebx
        mul     %ebx
        popl    %ebx

        movl    %ebp, %esp
        popl    %ebp
        ret
;///////////////////////////////////
;my_div:
;	pushl   %ebp
;        movl    %esp, %ebp
;
;        pushl   %ebx
;        movl    8(%ebp), %eax
;        movl    8(%ebp), %ebx
;	movl    %ebx %edx
;        div     %ebx
;        popl    %ebx
;
;        movl    %ebp, %esp
;        popl    %ebp
;        ret
;////////////////////////////////////
my_inc:
	pushl   %ebp
        movl    %esp, %ebp

        pushl   %ebx
        movl    8(%ebp), %eax
        movl    12(%ebp), %ebx
        inc     %eax
        popl    %ebx

        movl    %ebp, %esp
        popl    %ebp
        ret

my_dec: pushl   %ebp
        movl    %esp, %ebp

        pushl   %ebx
        movl    8(%ebp), %eax
        movl    12(%ebp), %ebx
        dec     %eax
        popl    %ebx

        movl    %ebp, %esp
        popl    %ebp
        ret



