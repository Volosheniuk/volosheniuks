#include <stdio.h>

int main(){
int a,b; char z;
scanf("%d %d %c",&a,&b,&z);
switch (z){
   case '+' :
	{printf("%d\n",my_plus(b,a));break;}
   case'-':
	{printf("%d\n",my_minus(b,a));break;}
   case '*':
	{printf("%d\n",my_mult(b,a));break;}
   case '/':
	{printf("%d\n",my_div(b,a));break;}
   case 'i': 
	{printf("%d\n",my_inc(a,b));break;}
   case 'd': 
	{printf("%d\n",my_dec(a,b));break;}
 }
return 0;

}
