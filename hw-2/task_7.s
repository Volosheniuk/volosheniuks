.data

mytext:
	.space 100
mytextcop:
	.space 200
cop:
	.space 1
cop2:
	.space 100
lengthS:
	.space 4
strstr:
	.string "YOURS STRING:"
strstr2 :
	.string "String after rule2:"
strstr3:
	.string "string after rule1:"

ennd:
	.string "\n"
cheker:
	.string "%d\n"
fmt_str:
	.string "%c"
a:
	.space 4
count:
	.space 4
ptr:
	.space 4
myflag:
	.space 4
countA:
	.space 4
counta:
	.space 4
flag:
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



//function 2


checksv:
//prolog
        pushl %ebp
	movl %esp,%ebp

//main part
	
	movl 8(%ebp),%esi
	
	movl $0, countA
	movl $0, counta
	movl lengthS,%ecx
myloop2:
	movl %ecx, ptr
	lodsb
	
	cmpb $65,%al
	jb go
	   cmpb $122,%al
	   ja go
	   	cmpb $91,%al
		jb go1
		   cmpb $97,%al
		   ja go2
		   	jmp go

	go2:
		addl $1,counta
		jmp go
	go1:
		addl $1,countA
		jmp go
	go:
	movl ptr,%ecx
	loop myloop2

//end of main part 
	movl counta,%eax
	movl countA,%ecx
	cmpl %eax,%ecx
	je yra
		movl $0,flag

	yra:

//epilog
	movl %ebp,%esp
	popl %ebp
ret






//function 3 letsrule2

letsrule2:
//prolog
	pushl %ebp
  	movl %esp,%ebp
//main part
	movl 8(%ebp),%esi
	movl $mytextcop,%edi
	movl lengthS,%ecx
loopf3:
 	movl %ecx, ptr	
	lodsb
	stosb
	stosb
	movl ptr,%ecx
	loop loopf3

//wright answer
#printstring
	pushl $strstr2
	call printf
	addl $4,%esp
	movl lengthS,%ecx
	addl %ecx,%ecx
	movl $mytextcop,%esi
typing2:
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
	loop typing2

	pushl $ennd
	call printf
	addl $4,%esp

#end of printstring
//epilog
	movl %ebp,%esp
	popl %ebp
ret





//function 4  letsrule1


letsrule1:
//prolog
	pushl %ebp
	movl %esp,%ebp
//main part
	movl 8(%ebp),%esi
	movl $cop2,%edi
	movl lengthS,%ecx
loopf4:
	movl %ecx, ptr
	lodsb
	cmpb $49,%al
	jb f4end
		cmpb $57,%al
		ja f4end
			addb $48 ,%al
			stosb 
			jmp f4endend
			

	f4end:
		stosb
		jmp f4endend
	f4endend:
	movl ptr,%ecx
	loop loopf4
//end of main part


#printstring
	pushl $strstr3
	call printf
	addl $4,%esp
	
	movl $cop2,%esi
	movl lengthS,%ecx
typing333:
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
	loop typing333

	pushl $ennd
	call printf
	addl $4,%esp

#end of printstring




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

	pushl $ennd
	call printf
	addl $4,%esp

#end of printstring
	

//check svoistvo
	movl $1,flag
	movl $0,%eax	
	pushl $mytext
	call checksv
	addl $4, %esp
	pushl flag
	pushl $cheker
	call printf
	addl $8,%esp
	
//end of checking svoistvo
	movl flag,%eax
	cmpl $0,%eax
	je  rule2
		pushl $mytext
		call letsrule1
		addl $4,%esp
		jmp eenndd
//flag=0 rule 2
rule2:
	pushl	$mytext
	call  letsrule2
	addl $4,%esp
	jmp eenndd
	
eenndd:
//epilog
	movl    $0,%eax
	movl	%ebp, %esp
	popl	%ebp

ret
