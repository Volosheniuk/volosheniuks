#include <stdio.h>
#define NMAX 16000
	
//global
	double mas1[NMAX+1];
        double mas2[NMAX+1];
//end global


void ccopp(int k){
int q;
	for (q=0;q<=k;q++){
		mas1[q]=mas2[q];
	
	}
}

void changeme(int k,double hh,double cww){
	int i;
	double mmin;
//main part of this problem
	for (i=0;i<k;i++){
		//
		if (mas1[i]>mas1[i+1]){  
			mmin=mas1[i+1];
			mas2[i+1]=mmin+(hh-cww)*(mas1[i]-mas1[i+1])/hh;
		}
		else{
			 mmin=mas1[i];
			 mas2[i+1]=mmin+(mas1[i+1]-mas1[i])*cww/hh;
		}

	}
	if (mas1[0]>mas2[k]) {  
                        mmin=mas2[k];
                        mas2[0]=mmin+(hh-cww)*(mas1[0]-mas2[k])/hh;
                }
	else{
		mmin=mas1[0];
		mas2[0]=mmin+(mas2[k]-mas1[0])*cww/hh;	
	}
	


}
int main(){
	double *p;
	int N;
	int counter;
	int cheker;
	N=10;
	double cw=0.5;
	double h=2.0/(double)N;
	//zabit nyliami
	int i;
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
	p=&mas1[0];
	for (j=0;j<=M;j++){
		changeme(N,h,cw);
		ccopp(N);
	}

return 0;
}
