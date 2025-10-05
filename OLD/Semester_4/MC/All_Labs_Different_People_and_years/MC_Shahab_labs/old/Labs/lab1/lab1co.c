#include <stdlib.h>
#include <lm3s9b92.h>
#include <stdio.h>

void main(void) {
	SYSCTL_RCGC2_R = (1<<3)|(1<<8);
	GPIO_PORTD_DEN_R=0x0F;//enable bits 0 to 3 of Port D
	GPIO_PORTD_DIR_R=0x0F;//set bits 0 to 3 of Port D as outputs

	GPIO_PORTJ_DEN_R=0x0F;//enable bits 0 to 3 of Port J
	GPIO_PORTJ_DIR_R=0x00;//set bits 0 to 3 of Port J as inputs

//-------------------------------------------------------------------------------------------------------------------------------------------------

	//create the array with all the characters of the keypad:
	char ar[4][4]={ {'1','2','3','F'},
					{'4','5','6','E'},
					{'7','8','9','D'},
					{'A','0','B','C'},
										};
	int i,j; // i is the counter for rows; j is the counter for columns


//-------------------------------------------------------------------------------------------------------------------------------------------------


//GPIO_PORTD_DATA_R=0x0F;	//set bits 0 to 3 of output Port D to "1" so that later we can check when one of them will become "0"

	while(1)
	{

		for(j=0;j<4;j++)//loop through the columns
		{
			GPIO_PORTD_DATA_R=0x0F^(1u<<j);//set bit j of Port D to 0 (1u is 1)
			wait();
			for(i=0;i<4;i++)//loop through the rows
			{
				if(!(GPIO_PORTJ_DATA_R & (1u << i)))//if bit i of Port J is 0, the expression will evaluate to true
				{
					printf("%c\n",ar[i][j]); // print the character in the terminal
				}
			}
		}
	}

}

system("pause");

return 0;
