#include <stdio.h>






int sum1(int *a, int n);
float sum2(float *f, int n);


int main(){
int i; int n = 7;
int *a = (int *)malloc(n*sizeof(int));
float *f = (float *)malloc(n*sizeof(float));
	
	
	for (i=0; i<7; i++)
		scanf("%d", &a[i]);
	
	
	
	for (i=0; i<7; i++)
		scanf("%f", &f[i]);
	printf("%d\n", sum1(a, n));
	printf("%.2f\n",sum2(f, n));

return 0;
}
