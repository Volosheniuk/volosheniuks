#include <stdio.h>
#define NMAX 16000
#include "drawme.h"	
#include "math.h"


//global
	double mas1[NMAX+1];
        double mas2[NMAX+1];
	double xmasx[51];
	double mascopy[NMAX+1];
	double e1mas[NMAX+1];
	double e2mas[NMAX+1];
	double e1=0.0;
	double e2=0.0;
	double e11=0.0;
	double e22=0.0;
//end global


void ccopp(int k){
int q;
	for (q=0;q<=k;q++){
		mas1[q]=mas2[q];
	
	}
}

void changeme(int N,double hh,double cww){
	int j;
	double a,b; 
//main part of this problem
	for (j=1;j<N;j++){
		a = (mas1[j+1]-mas1[j])/hh;
		b = ( (-1.0 + (j+1)*hh)*mas1[j] - (-1.0 + j*hh)*mas1[j+1] )/hh;
		mas2[j+1] = fabs( a*(-1.0 + (j)*hh + cww*hh/1.0) + b);
		}
	a = ((mas1[0]-mas1[N]))/hh;
	b = ( (-1.0 + (N)*hh)*mas1[N] - (-1.0 + (N)*hh)*mas1[0] )/hh;
	mas2[1] = fabs(a*(-1.0 + N*hh +cww*hh/1.0) + b);	


}
/************************************/
void copmymas(int t){
int q;
for(q=0;q<=t;q++){
	mascopy[q]=mas1[q];
}
}
/************************************/
void copmymas2(int t){
int q;
for (q=0;q<=t;q++){
	e1mas[q]=fabs(mas1[q]-mascopy[q]);
}
}
/***********************************/

void printe1e2(int t, double h1,int z){
double coppp=0.0;
int i;
if (z==0){
	for(i=0;i<=t;i++){
		if (  e1mas[i]>coppp   )
			coppp=e1mas[i];
	}
	e1=coppp;
	e2=0.0;
	for (i=0;i<=t;i++){
		e2=e2+h1*e1mas[i];
	}
	
	printf("for step=%lf   e1=%lf   e2=%lf \n",h1,e1,e2);
};
if (z==1){
	 for(i=0;i<=t;i++){
	 	if (  e1mas[i]>coppp   )
		 	coppp=e1mas[i];
	}
	e11=coppp;
	e22=0.0;
	for (i=0;i<=t;i++){
		e22=e22+h1*e1mas[i];
	}
	printf("for step=%lf   e1=%lf   e2=%lf \n",h1,e11,e22);


}
}




/***********************************/


int main(){
int flag=0;

for (flag=0;flag<2;flag++){
	
	double *p;
	int N;
	if (flag==0) N=25;
	else N=50;
	double cw=0.5;
	double h=2.0/(double)N;
	
	//zabit nyliami
	int i;
	xmasx[0]=-1.0;
	for (i=1;i<=N;i++)
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
	copmymas(N);
	int j;
	int M=10;//kolichestvo >>
	//>>
	p=&mas2[0];
	for (j=0;j<=N;j++){
		changeme(N,h,cw);
		ccopp(N);
	//	DM_plot_1d(xmasx, mas2, N, "Test 1", 0);
          //      DM_plot_1d(xmasx,mas2 , N, "Test 1", 1);


	}
	copmymas2(N);
	printe1e2(N,h,flag);
}
//	printf("REZALT=%f\n",log10l(2)/(log10l(e1/e11))  ); 
return 0;
}
