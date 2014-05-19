//about program:
//Vhod: masiv chisl  1 chislo --kolichestvo elementov
//Vuvod: 1) masiv 2)summa chisel  3)yest li 14 v masive  4) odinakovi li dva masiva 
//
 .data 
 mymas1:
 	.space 100
mymas2:
	.space 100
readchislo:
	.string "%d"
prob:
	.string " "
N:
	.space 4
cop:
	.space 4
wrightanswer:
	.string "summa=%d\n"
endline:
	.string "\n"
stryes:
	.string "14 is in the mas\n"
strno:
	.string "14 is not in the mas\n"
ansans1:
	.string "N\n"
ansans2:
	.string "Y\n"

.globl main 


main:
//prolog

	pushl	%ebp
	movl	%esp, %ebp


//read masiv
//1--read colichestvo elementiv
     //N--kolichestvo elementiv massiva

	pushl $N
	pushl $readchislo
	call scanf
	addl $8, %esp

//2  read mass
	
	movl N, %ecx
	movl $mymas2, %edi
//here is usage of stosl

readmas:
	pushl %ecx
	pushl $cop
	pushl $readchislo
	call scanf
	addl $8,%esp
	popl %ecx
	movl cop, %eax
	stosl
	
	
	loop readmas
//

	movl $mymas2,%esi
	movl N,%ecx

//here is usage of lodsl
	movl $0,%edx

summas:
	lodsl
	addl %eax,%edx

	loop summas

//wright answer1
	pushl %edx
	pushl $wrightanswer
	call printf
	addl $8,%esp
//copy mymas2 to mymas1 usage rep movsl
	movl  $mymas2,%esi
	movl  $mymas1,%edi
	movl  N,%ecx
	rep movsl
//copy checking
	movl N,%ecx
	movl $mymas1,%esi
wrightmas1:
     //
	lodsl
	pushl %ecx
	pushl %eax
	pushl $readchislo
	call printf
	addl $8,%esp
	popl %ecx
	pushl %ecx
	pushl $prob
	call printf
	addl $4,%esp
	popl %ecx
     //
	loop wrightmas1
	
	pushl $endline
	call printf
	addl $4,%esp

//change mymas2 to {5,5.....}
	movl N,%ecx
	movl $mymas2,%edi
changemas2:
    //
	movl $5,%eax
	stosl
    //
    	loop changemas2

//here is using of scas   here we are seaching for 14 in mas
	movl $14,%eax
	movl N,%ecx
	inc %ecx
	movl $mymas1,%edi
        repne scasl
	cmp $0,%ecx
	je ans0
  		jmp ansyes

ans0:
	pushl $strno
	call printf
	addl $4,%esp
	jmp go
ansyes:
	pushl $stryes
	call printf
	addl $4,%esp
	jmp go
go:
// here is using of cmps
       movl $mymas1,%esi
       movl $mymas1,%edi
       movl N, %ecx
       
       repne cmpsl

       cmp $0,%ecx
       je go2
     	  pushl $ansans2
	  call printf
	  addl $4,%esp
	  jmp gogo
	

//answer
go2:
	pushl $ansans1
	call printf 
	addl $4,%esp
	 jmp gogo
gogo:
//epilog
	movl $0,%eax
	movl	%ebp, %esp
	popl	%ebp
	ret



