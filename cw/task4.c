#include <stdio.h>
#include <math.h>

int main() {
int ind = 0;
double src[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
double dst[10] = {0, };
#pragma omp parallel
{
#pragma omp for
for (ind = 0; ind < 10; ind++)
{
	int x=100500;
	printf("%d",x);
	printf(" %d", ind);
	dst[ind] = pow(src[ind], 2.0f);
}
}
printf("\n");
for (ind = 0; ind < 10; ind++)
printf("%lf ", dst[ind]);
printf("\n");
return 0;
}
