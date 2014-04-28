#include <stdio.h>

	int main() {
	int ind = 0;
	int sum = 0; // shared variable.
	double src[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	#pragma omp parallel for
	for (ind = 0; ind < 10; ind++)
	{
	#pragma omp atomic 
		sum += src[ind];
	}
	printf("Sum: %d\n", sum);
	return 0;
}
