// A set of tests for drawme lib that can be build independently.
#include <stdio.h>
#include "drawme.h"

int test_1() {
	double arr_1d_x[5] = {1, 2, 3, 4, 5};
	double arr_1d_y[5] = {1, 2, 3, 4, 5};
	const unsigned int len = 5;
	DM_plot_1d(arr_1d_x, arr_1d_y, len, "Test 1", 0);
	DM_plot_1d(arr_1d_x, arr_1d_y, len, "Test 1", 1);
	return 0;
}

int main() {
	int err = 0;
	printf("TEST_1: START\n");
	err = test_1();
	if (err)
		printf("TEST_1: FAILED\n");
	else
		printf("TEST_1: SUCCEED\n");

	return 0;
}
