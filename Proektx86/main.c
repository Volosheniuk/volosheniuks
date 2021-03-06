#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define first_esp 1000
#define max_vars 100
#define max_str 100
#define max_commands 100
#define is !strcmp

typedef char byte;

long regs[5];
FILE* file;
int yourcommandflag;//flag parsera 
byte stack[first_esp+1];
int init_file(char* filename) {
	file = fopen(filename,"r");
	if (file==NULL) return 13;
	else regs[4] = (long)(stack+first_esp);
           return 0;
}
long* reg(char* str) {//eax,ebx,ecx,edx,esp
	switch(str[1]) {
		case 'a' : return regs ;
		case 'b' : return regs + 1;
		case 'c' : return regs + 2;
		case 'd' : return regs + 3;
		case 's' : return regs + 4;
	}
	return regs;
}

// stack :



void pushl(long a) {//regs + 4 === reg("esp")
	if(regs[4] - 4 < 0) {
		printf("error : stack overflow\n");
		return;
	}
	regs[4]-=4;
	*(long*)(regs[4]) = a;
}
long popl() {
	if(regs[4] + 4 > (long)stack + first_esp) {
		printf("error : stack corrupted\n");
		return -1;
	}
	regs[4] += 4;
	return *((long*)(regs[4]-4));
}

//data :
char* names[max_vars];
byte* pointers[max_vars];//pointers - massiv dannuh: name[0] == "myint", *pointers[0] == 1234, sizes[0] == sizeof(int)
int   sizes[max_vars];
int   isstring[max_vars] = {0};//0---esli ne stroka , 1--stroka
int last = 0;//kolichestvo data

int size_of(char* type_name) {
	if(is(type_name,"int")) {
		return sizeof(int);
	}
	if(is(type_name,"float")) {
		return sizeof(float);
	}
	if(is(type_name,"byte")) {
		return sizeof(byte);
	}
	if(is(type_name,"short")) {
		return sizeof(short);
	}
	if(is(type_name,"long")) {
		return sizeof(long);
	}
	return -1;
}
//
void specifier(char* type_name, char* dest ) {
	if(is(type_name,"int")) {
		memcpy(dest,"%d",3);return;
	}
	if(is(type_name,"float")) {
		memcpy(dest,"%g",3);return;
	}
	if(is(type_name,"byte")) {
		memcpy(dest,"%hhd",5);return;
	}
	if(is(type_name,"short")) {
		memcpy(dest,"%hd",4);return;
	}
	if(is(type_name,"long")) {
		memcpy(dest,"%ld",4);return;
	}
	memcpy(dest,"%d",3);
}
//
void bind_space(char* name, int length) {
	if(last == max_vars) return;
	names[last] = (char*)malloc(strlen(name));
	memcpy(names[last],name,strlen(name)+1);
	pointers[last] = (byte*)malloc(length);
	sizes[last] = length;
	last++;
}

void bind_with_value(char* name, byte* value, int length) {
	bind_space(name,length);
	memcpy(pointers[last-1],value,length);
}
void bind_string(char* name, char* str) {
	if(last < max_vars) isstring[last] = 1;
	bind_with_value(name,str,strlen(str)+1);

}
void bind_typed(char* name,void* value,  int len) {
	bind_with_value(name, (byte*)value, len);
}
//scanning after .data
int read_var() {
	char name[100];
	int len;
	char type[100];
	char spec[10];
	byte* pt;
	fscanf(file,"%s",name);
	if(is(name,".text")) {
		return -1;
	}
	len = strlen(name);
	name[--len] = 0;//obrezem dvoietochie

	fscanf(file,"%s",type);
	if(is(type+1,"space")) {
		int len2;
		fscanf(file, "%d",&len2);
		bind_space(name,len2);
		return 0;
	}
	if(is(type+1,"string")) {
		char str[max_str + 1];
		fscanf(file, "%s",&str);
		str[strlen(str)-1] = 0;
		bind_string(name,str+1);
		return 0;
	}

	pt = (byte*)malloc(size_of(type+1));

	specifier(type+1,spec);
	fscanf(file,spec,pt);
	bind_typed(name,pt,size_of(type+1));
	//printf("%s %d",names[last-1],*(int*)pointers[last-1]);
	return 0;
}

int find(char* name) {
	int i;
	for(i = 0; i < last; i++) {
		if(is(name,names[i])) {
			return i;
		}
	}
	return -1;
}
void* ram_get(char* name) {
	int index = find(name);
	if(index < 0) return 0;
	return pointers[index];
}


//ydalit probel s kontsa stroki
void erase_spaces(char* str) {
	int begin = 0;
	int end = strlen(str);
	int i;
	while(str[begin] == ' ' || str[begin] == '\t') {
		begin++;
	}
	if(begin == end) {str[0] = 0;return;}
	while(str[end-1] == ' ' || str[end-1] == '\t') {
		end--;
	}
	for(i = begin; i < end; i++) str[i-begin] = str[i];
	str[end-begin] = 0;
}
char* commands[max_commands];
int i_commands = 0;
//komanda v main movl arg
char* mark_names[max_commands];//imena metok
int   mark_before[max_commands];//kyda nygno pereiti po metke
int i_marks = 0;
//0 : is empty line, 1 is mark, 2 is command

int findmark(char* mark) {//find nomer metki
	int i = 0;
	while( i < i_commands && !is(mark,commands[i])) i++;
	return i;
}
int type(char* line) {//tip stroki 1--metka, 2 komanda  0---erynda
	if(line[strlen(line)-1] == ':') return 1;
	else if(line[0] >= 'a' && line[0] <='z' ) return 2;
	else return 0;
}
void parse_main_into_commands() {///otdelenie komand i metok
	while(!feof(file)) {
		char line[200];
		fgets(line,sizeof(line),file);
		erase_spaces(line);//ydalit probel sleva sprava
		if(type(line) == 1) {//metka=1
			if(i_marks == max_commands) {
				printf("error : too much commands");
				return;
			}
			line[strlen(line)-1] = 0;//ydaliaem dvoietochie
			mark_names[i_marks] = (char*)malloc(strlen(line)+1);//imena metok
			memcpy(mark_names[i_marks],line,strlen(line)+1);
			mark_before[i_marks] = i_commands;//kyda nygno prygnut
			i_marks++;
		}
		if(type(line) == 2) {//read command
			if(i_commands == max_commands) {
				printf("error : too much commands");
				return;
			}
			commands[i_commands] = (char*)malloc(strlen(line)+1);
			memcpy(commands[i_commands],line,strlen(line)+1);
			i_commands++;
		}
	}
}

byte less = 0 ,equal = 0;
void cmpl(long a, long b) {
	less = a<b;
	equal = a==b;
}
int jif(char* ifstr) {
	if(is(ifstr,"jmp")) return 1;
	if(is(ifstr,"jb") || is(ifstr,"jl")) return less;
	if(is(ifstr,"ja") || is(ifstr,"jg")) return !less && !equal;
	if(is(ifstr,"je")) return equal;
	if(is(ifstr,"jne")) return !equal;
	if(is(ifstr,"jng") || is(ifstr,"jnb")) return less || equal;
	if(is(ifstr,"jna") || is(ifstr,"jnl")) return !less || equal;
}
void __exit() {
	printf("running complite!\n");
	return;
}
int isnum(char* op_name) {
	int i ;
	for(i = 0; i < strlen(op_name);i++)
		if(op_name[i] != '-' && ( op_name[i] > '9' || op_name[i] < '0')) return 0;
	return 1;
}
//before first space
int op_is_long = 0;
//vozraschaet ykazatel na to shto mu izmeniaem commandoy movl etc
long* get_op_by_name(char* op_name) {
	op_is_long = 0;
	if(op_name[0] == '%') {
		return reg(op_name+1);
	}
	if(op_name[0] == '(' && op_name[1] == '%') {
		char op_name_dirt[100];
		strcpy(op_name_dirt,op_name+2);
		op_name_dirt[strlen(op_name_dirt)-1] = 0;
		return ((long*)(*reg(op_name_dirt)));
	}
	if(op_name[0] == '$') {
		return (long*)(ram_get(op_name+1));
	}
	// 1(%ecx) ili -2(%eax)
	if(op_name[0] == '-' || (op_name[0] >= '0' && op_name[0] <= '9')) {
		char z[20];
		long k = 1;
		long shift;
		while(op_name[k] >= '0' && op_name[k] <= '9') k++;
		memcpy(z,op_name,k);
		z[k] = 0;
		sscanf(z,"%ld",&shift);
		while(!(op_name[k] >= 'a' && op_name[k] <='z')) k++;
		strcpy(z,op_name+k-1);
		z[strlen(z)-1] = 0;
		return (long*)(*reg(z)) + shift;
	}
}
long get_lop_by_name(char* op_name) {//dostat znachenie po nazvaniu operanda
	if(op_name[0]=='$' && isnum(op_name+1)) {
		long a;
		op_is_long = 1;//operand eto chislo
		sscanf(op_name+1,"%ld",&a);
		return a;
	}
	if(op_name[0] >= 'a' && op_name[0] <= 'z') {
		return (long)ram_get(op_name);
	}
	else return *get_op_by_name(op_name);
}
void split_into_two_ops(char* src, char* op1_name, char* op2_name) {//razbit stroky nadva operanda
	int k = 0;
	while(src[k] != ',') k++;
	memcpy(op1_name,src,k);
	op1_name[k] = 0;
	memcpy(op2_name,src+k+1,strlen(src+k+1)+1);
	erase_spaces(op1_name);
	erase_spaces(op2_name);
}
void process_commands() {//obrabotka  komand
	int current = 0;
	for(;current<i_commands;current++) {
		char com_name[100];//comands
		sscanf(commands[current],"%s",com_name);
		if(is(com_name,"exit") || is(com_name,"ret")) {
			__exit();
			return;
		}
		if(is(com_name,"pushl")) {
			char op_name[100];
			sscanf(commands[current]+strlen(com_name),"%s",op_name);
			pushl(get_lop_by_name(op_name));

			continue;
		}
		if(is(com_name,"popl")) {
			char op_name[100];
			long* ptr;
			sscanf(commands[current]+strlen(com_name),"%s",op_name);
			ptr = get_op_by_name(op_name);

			*ptr = popl();
			continue;
		}
		if(com_name[0] == 'j') {
			char buf[20],mark[30];
			sscanf(commands[current],"%s%s",buf,mark);
			if(jif(com_name))
				current = mark_before[findmark(mark)];
			continue;
		}
		if(is(com_name,"loop")) {
			char buf[20],mark[30];
			if(*reg("ecx") <= 0) continue;
			(*reg("ecx"))--;
			sscanf(commands[current],"%s%s",buf,mark);
			current = mark_before[findmark(mark)];
			continue;
		}
		if(is(com_name,"addl")) {
			char op1[30],op2[30];
			char op_name[100],buf[30];
			long ptr1,*ptr2;
			byte op1_is_long = 0;
			sscanf(commands[current]+strlen(com_name),"%s%s",op_name,buf);
			strcat(op_name,buf);
			split_into_two_ops(op_name,op1,op2);
			ptr1 = get_lop_by_name(op1);
			op1_is_long = op_is_long;
			ptr2 = get_op_by_name(op2);
			*ptr2 += ptr1;
			continue;
		}
		if(is(com_name,"movl")) {
			char op1[30],op2[30];
			char op_name[100],buf[30];
			long ptr1,*ptr2;
			byte op1_is_long = 0;
			sscanf(commands[current]+strlen(com_name),"%s%s",op_name,buf);
			strcat(op_name,buf);
			split_into_two_ops(op_name,op1,op2);
			ptr1 = get_lop_by_name(op1);
			op1_is_long = op_is_long;
			ptr2 = get_op_by_name(op2);

			*ptr2 = ptr1;
			continue;
		}
		if(is(com_name,"subl")) {
			char op1[30],op2[30];
			char op_name[100],buf[30];
			long ptr1,*ptr2;
			byte op1_is_long = 0;
			sscanf(commands[current]+strlen(com_name),"%s%s",op_name,buf);
			strcat(op_name,buf);
			split_into_two_ops(op_name,op1,op2);
			ptr1 = get_lop_by_name(op1);
			op1_is_long = op_is_long;
			ptr2 = get_op_by_name(op2);

			*ptr2 -= ptr1;
		}
	}
}

void parseyourscommand(){
	char str1[200];
	printf("hello, EmulatorX86 is working now,");
	printf("please, run your command!\n");
	printf("to open help file ,just type help!\n");
	while (1==yourcommandflag){
		fgets(str1,sizeof(str1),stdin);
		char comm[100];
		sscanf(str1,"%s",comm);
		if (is(comm,"run")){
			comm[0]=0;
			memcpy(str1,str1+3,strlen(str1+3)+1);
			erase_spaces(comm);
			sscanf(str1,"%s",comm);
			if (is(comm,"all")){
				 process_commands();

			}
			
		}
		else if (is(comm,"report")){
			/* will be  fixed and commited */				
			printf("you open report\n");

		}
		else if (is(comm,"about")){
			FILE* helpfile;
			helpfile=fopen("about.txt","r");
			char helpstr[1000];
			while(!feof(helpfile)){
				fgets(helpstr,sizeof(helpstr),helpfile);
				memcpy(helpstr,helpstr,sizeof(helpstr));
				printf("%s",helpstr);
			}
			fclose(helpfile);			
		}
		else if (is(comm,"show")){
			comm[0]=0;
			memcpy(str1,str1+4,strlen(str1+4)+1);
			erase_spaces(comm);
			sscanf(str1,"%s",comm);
			if (is(comm,"%eax")) printf(" EAX=%d\n",(int)(regs[0]));
			else if (is(comm,"%ebx")) printf("EBX=%d\n",(int)(regs[1]));
			else if (is(comm,"%ecx")) printf("ECX=%d\n",(int)(regs[2]));
			else if (is(comm,"%edx")) printf("EDX=%d\n",(int)(regs[3]));
			else if (is(comm,"%esp")) printf("ESP=%d\n",(int)(regs[4]));
			else{
				int j=0;
				int flagf=0;
				for (;j<last;j++){
					if (is(comm,names[j])) {
						if (1==isstring[j]) printf("%s=%s\n",names[j],pointers[j]);
						else printf("%s=%d\n",names[j],*(int*)pointers[j]);
						flagf=1;
						break;
					}
				}
			if (0==flagf) printf ("There is not %s in the as-ler file, try to rewrite!",comm);
			}
		}
		else if (is(comm,"change")){
			/*here will be part of change*/		
			printf("you open change\n");
		}
		else if (is(comm,"step")){
			/*here will be step */	
			printf("you open step\n");
		}
		else if (is(comm,"help")){
			FILE* helpfile;
			helpfile=fopen("help.txt","r");
			char helpstr[1000];
			while(!feof(helpfile)){
				fgets(helpstr,sizeof(helpstr),helpfile);
				memcpy(helpstr,helpstr,sizeof(helpstr));
				printf("%s",helpstr);
			}
			fclose(helpfile);
		}
		else if (is(comm,"exit")){
			int s=0;
			do{
			printf("Are you shure you want to exit ?(y/n)\n");
			s=getchar();
			if ((121==s)||(89==s)) {
				goto mmyex;
			}
			}
			while ((121==s)||(89==s)||(110==s)||(78==s));
		 
		}
		else printf ("There is no such command, try to open help!\n");
	
	str1[0]=0;
	}
	mmyex:
	 printf("good bye!\n");
}

int main() {
	int is_data = 0;
	int fl=13;
	char str[30],str2[30];
	char myf[30];
	
	while (fl==13){
		printf ("Please,wright the title of as-ler file\n");
		fgets(myf,sizeof(myf),stdin);
		myf[strlen(myf)-1]=0;
		fl=init_file(myf);
		if (13==fl) printf("There is no such file\n");
	}
	
	fscanf(file,"%s",str);
	if(is(str,".data"))
		while(read_var() + 1) ;
	fscanf(file,"%s%s",str,str2);
	
	parse_main_into_commands();
	yourcommandflag=1;
	parseyourscommand();
	getchar();
}


