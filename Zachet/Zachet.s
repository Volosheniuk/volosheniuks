.data

mytext: 
	.space 1000
lengthS:
	.space 4
 strprint:
	.string "%d\n"
strres2:
	.string "count(0)=%d"
strres:
	.string "c(0)=%d c(1)=%d c(2)=%d c(3)=%d c(4)=%d c(5)=%d c(6)=%d c(7)=%d c(8)=%d c(9)=%d \n"
ptr:
	.space 4
count00:
	.space 4
count11:
        .space 4
count22:
        .space 4
count33:
        .space 4
count44:
        .space 4
count55:
        .space 4
count66:
        .space 4
count77:
        .space 4
count88:
        .space 4
count99:
        .space 4

//function 1

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

//epilog
	movl %ebp,%esp
	popl %ebp
ret




//function2 counter

counter:
//prolog
     pushl %ebp
     movl %esp,%ebp
//main part of counter
	movl 8(%ebp),%esi
	movl lengthS,%ecx	





oncemore:
	movl %ecx,ptr
	lodsb
	cmp $48,%al
	je goc0

	 cmp $49,%al
	  je goc1
           cmp $50,%al
	    je goc2
	     cmp $51,%al
		je goc3
		 cmp $52,%al
		  je goc4
		   cmp $53,%al
		    je goc5	
		     cmp $54,%al
		      je goc6	
		       cmp $55,%al
			je goc7
			 cmp $56,%al
			  je goc8			  
                           cmp $57,%al
			    je goc9


				jmp go
	goc0:
		addl $1,count00
		jmp go

	goc1:
		addl $1,count11
		jmp go
	goc2:
		addl $1,count22
		jmp go
	goc3:
		addl $1,count33
		jmp go
	goc4:
		addl $1,count44
		jmp go
	goc5:
		addl $1,count55
		jmp go
	goc6:
		addl $1,count66
		jmp go
	goc7:
		addl $1,count77
		jmp go
	goc8:
		addl $1,count88
		jmp go
	goc9:
		addl $1,count99
		jmp go

	go:
	movl ptr,%ecx
loop oncemore
        
//epilog
	movl %ebp,%esp
	popl %ebp
ret


.globl main

main:
//prolog
	pushl	%ebp
	movl	%esp, %ebp
//read data
	//read stroka
	pushl $mytext
	call scan_text
	addl $4,%esp
	//count[i]=0


//proverka1
//	pushl lengthS
//	pushl $strprint
//	call printf
//	addl $4,%esp

	movl $0,%eax
	
	movl %eax,count00

	movl %eax,count11
	movl %eax,count22	
	movl %eax,count33
	movl %eax,count44
	movl %eax,count55
	movl %eax,count66
	movl %eax,count77
	movl %eax,count88
	movl %eax,count99



 //call counter
	pushl $mytext
	call counter
	addl $4,%esp

//printres

	pushl count99
	pushl count88
	pushl count77
	pushl count66
	pushl count55
	pushl count44
	pushl count33
	pushl count22
	pushl count11
	pushl count00
	pushl strres
	call printf
	addl $44, %esp


//epilog
	movl $0,%eax
	movl %ebp,%esp
        popl %ebp
ret
