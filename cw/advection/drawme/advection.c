#include <stdio.h>
#define NMAX 16000
#include "drawme.h"	


//global
	double mas1[NMAX+1];
        double mas2[NMAX+1];
	double xmasx[50];
//end global


void ccopp(int k){
int q;
	for (q=0;q<=k;q++){
		mas1[q]=mas2[q];
	
	}
}

void changeme(int N,double hh,double cww){
	int j;
	double mmin;
	double a,b; double cx=1.0;
//main part of this problem
	for (j=0;j<N-1;j++){
		a = (mas1[j+1]-mas1[j])/hh;
		b = ( (-1.0 + (j+1)*hh)*mas1[j] - (-1.0 + j*hh)*mas1[j+1] )/hh;
		mas2[j+1] = a*(-1.0 + (j)*hh + cww*hh/1.0) + b;
		}
		a = ((mas1[0]-mas1[N]))/hh;
		b = ( (-1.0 + (N)*hh)*mas1[N] - (-1.0 + (N)*hh)*mas1[0] )/hh;
		mas2[0] = a*(-1.0 + N*hh +cww*hh/1.0) + b;	


}
int main(){
	double *p;
	int N;
	int counter;
	int cheker;
	N=50;
	double cw=0.5;
	double h=2.0/(double)N;
	
	//zabit nyliami
	int i;
	xmasx[0]=-1.02;
	for (i=1;i<N;i++)
		xmasx[i]=xmasx[i-1]+h;
	xmasx[i]=1.02;
	for (i=0;i<NMAX+1;i++){
		mas1[i]=0;
		mas2[i]=0;
	} 
	//nach uslov
	int h1=(int)(N/4);
	int h2=(int)(0.75*N);
	for (i=h1; i<=h2;i++)
		mas1[i]=1;

	int j;
	int M=10;//kolichestvo >>
	//>>
	p=&mas2[0];
	for (j=0;j<=500;j++){
		changeme(N,h,cw);
		ccopp(N);
		DM_plot_1d(xmasx, mas2, N, "Test 1", 0);
                DM_plot_1d(xmasx,mas2 , N, "Test 1", 1);


	}

return 0;
}
