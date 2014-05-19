#include <stdio.h>
#include "drawme.h"




double proverka(double x){
if (x >= -0.5 && x <= 0.5) {
return 1;
}
return 0;
};
//globl data
const double Cx = 1;
const double k = 0.5;

int N, M;
double x[100] = {0};
double mas2[100] = {0};
double mas1[100] = {0};
double prproizv[100] = {0};
double proizv[100] = {0};
double h, top;
//end of globl


int main(){


N=50;
h = 2.0 / N;
top = (k * h) / Cx;

M = 2.0 / (Cx * top)+1;

int i;


for (i = 0; i < N; i++) {
  x[i] = (i * h) - 1;
mas2[i] = mas1[i] = proverka (x[i]);
        };


double A, B, C, D;

int j = 0;

while (j < M) {

for (i = 1; i < N; i++) {
	D = mas2[i];	
	C = proizv[i];
	A = (((prproizv[i-1] - C)/h) + 2 * (mas1[i-1] - D + C * h)/(h*h))/h;
	B = (mas1[i-1] - D + C * h)/(h*h) + A*h;

	mas2[i] = A * (-Cx*top) * (-Cx*top) * (-Cx*top) + B * (-Cx*top) * (-Cx*top) + C * (-Cx*top) + D;
	proizv[i] = 3 * A * (-Cx*top) * (-Cx*top) + 2 * B * (-Cx*top) + C;
};


    
        D = mas2[0];
        C = proizv[0];
        A = (((prproizv[N - 1] - C)/h) + 2 * (mas1[N-1] - D + C * h)/(h*h))/h;
        B = (mas1[N-1] - D + C * h)/(h*h) + A*h;
	mas2[0] = A * (-Cx*top) * (-Cx*top) * (-Cx*top) + B * (-Cx*top) * (-Cx*top) + C * (-Cx*top) + D;
       	proizv[0] = 3 * A * (-Cx*top) * (-Cx*top) + 2 * B * (-Cx*top) + C;


        for (i = 0; i < N; i++){
                mas1[i] = mas2[i];
		prproizv[i] = proizv[i];
        }
	 DM_plot_1d(x, mas2, N, "Test 1", 0);
	 DM_plot_1d(x, mas2, N, "Test 1", 1);
	j++;
}

//        DM_plot_1d(x, mas2, N, "Test 1", 0);
  //      DM_plot_1d(x, mas2, N, "Test 1", 1);

return 0;
}
