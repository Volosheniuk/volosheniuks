#include <stdio.h>
#define NMAX 1500
#include "drawme.h"

double mymus[NMAX];//Ax^3+Bx^2+Cx+D=0
double mymus2[NMAX];
double proizv[NMAX];//3Ax^2+2Bx+C=0
double proizv2[NMAX];
double xmasx[100];
//vse masivy ot 1 N 

void swopme(int k){   //vuzov swopme(N);
	int i;
	for (i=1;i<=k;i++){
		mymus[i]=mymus2[i];
		proizv[i]=proizv2[i];
	}
}
int main(){
int N=100;
double step=2.0/(double)N;
double dx=0.5*step;
//zabit xmasx
int i;
xmasx[0]=-1.0;
for(i=1;i<N;i++)
	xmasx[i]=xmasx[i-1]+step;
xmasx[i]=1.02;
//zapolnenie 0

for(i=0;i<=NMAX;i++){
	mymus[i]=0;
	mymus2[i]=0;
	proizv[i]=0;
	proizv2[i]=0;
}
//nachalo zadanie function
for(i=N/4;i<=(N-N/4);i++){
	mymus[i]=1.0;
}
float a;
float b;
float c;
float d;
int kolichestvoshag=200;
//main part of program
int j;
for (j=1;j<=kolichestvoshag;j++){
	//perviy element
	d=mymus[N];
	c=proizv[N];
	a=(proizv[1]*step+2*d+c*step-2*mymus[1])/(step*step*step);
        b=(mymus[1]-c*step-d-a*step*step*step)/(step*step);
	mymus2[1]=a*dx*dx*dx+b*dx*dx+c*dx+d;
	proizv2[1]=3*a*dx*dx+2*b*dx+c;


	//izmenenie mymus2;proizv2;
	for (i=1;i<N;i++){
		//poisk a,b,c,d
		  d=mymus[i];
		  c=proizv[i];
		  a=(proizv[i+1]*step+2*d+c*step-2*mymus[i+1])/(step*step*step);
		  b=(mymus[i+1]-c*step-d-a*step*step*step)/(step*step);
		  mymus2[i+1]=a*dx*dx*dx+b*dx*dx+c*dx+d;
		  proizv2[i+1]=3*a*dx*dx+2*b*dx+c;
	}
	//canvas mymus2;
		DM_plot_1d(xmasx, mymus2, N, "Test 1", 0);
		DM_plot_1d(xmasx, mymus2, N, "Test 1", 1);
	swopme(N);
}
	


	return 0;

}
