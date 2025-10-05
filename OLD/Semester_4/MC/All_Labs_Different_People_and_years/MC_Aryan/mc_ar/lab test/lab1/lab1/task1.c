#include<stdio.h>
#include<stdlib.h>
#include<Windows.h>
void main (){
		int y,x=1;
		char input;
		int row,column;
		char res;
		int Y[4]={1.};
		int test[4][4];
		char  keyboard[4][4]={{'1','2','3','F'},
						{'4','5','6','E'},
						{'7','8','9','D'},	
						{'A','0','B','C'}};
	
	for(row=0;row<4;row++)
		{
			for(column=0;column<4;column++){
				test[row][row]=0;
			test[row][column+1]=1;
			}
		}
	printf("\n");
	printf("press your luck button\n ");
	printf("\n");
	printf("		X(1)	X(2)	 X(3)   X(4) ");
	printf("\n");

			for(row=0;row<4;row++)
		{
			printf("	y(%d)",row+1);
			for(column=0;column<4;column++){
				printf("	%c   ",res=keyboard[row][column]);		
			}
			printf("\n");	}
			printf("\n");
				while(1){
		for(row=0;row<4;row++)
		
		{
				printf("-------------------------------------------------------------\n");
		printf("				X(%d)=0\n",row+1);
		
			
			for(column=0;column<4;column++){
				if(test[column][row]==0){
					fflush(stdin);
					input=getchar();
					for(y=0;y<4;y++){
					
					if(keyboard[y][row]==input)

					{
							Y[y]=0;
							printf("y(%d)=0",y+1);
							printf("\n");
							printf("input number is %c\n",input);}
					}
						}		

			}
			Sleep(3000);
	}
	}	
		system("pause");
}



