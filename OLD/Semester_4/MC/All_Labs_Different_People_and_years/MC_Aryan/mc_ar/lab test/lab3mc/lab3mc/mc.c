#include <stdio.h>
#include<stdlib.h>

void main (){

 int  input =2894;
 int i;
 int n=10;
 int temp =0;
 int temp1;
	int split[4];
	for(i=3;i>=0;i--){
	split[i]=input%10;

	input=input/n;
	 

	}

	
for(i=0;i<4;i++){
	printf("%d ",split[i]);
	
	

	}
printf("\n");

	system("pause");

}