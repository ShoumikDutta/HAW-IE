#include <stdio.h>
#include <lm3s9b92.h> // Header file for Stellaris micro controller


//--------------------------------------------------------------
void main ()
{
	SYSCTL_RCGC2_R=(1<<3) | (1<<8); // Clock port D +Port E 


	GPIO_PORTD_DEN_R=0x0F; // PD(3:0) enable
	GPIO_PORTD_DIR_R=0x0F; // PD(3:0) output



	GPIOPORTJ_DEN_R=0x0F;  // PD(3:0) enable
	GPIO_PORTJ_DIR_R=0x00; // PE(0) input

}
//---------------------------------------------------------------

char arr[4] [4] = {	{'1','2','3','F'},
					{'4','5','6','E'},
					{'7','8','9','D'},
					{'A','0','B','c'},
										};	
// Defining the characters of keypad inside a 
//   2D array for an access during
//	the for nested loops and present them via printf

//----------------------------------------------------------------

while(1)

{	
	for (i=0;i<4;i++) // For loop columbs

		{
			GPIO_PORTD_DATA_R=0x0F ^ (1u<<i); // Bit i(th) of Port D will be set to null .
											  

				for (k=0;k<4;k++) // For loop Rows

					{
						if(!(GPIO_PORTJ_DATA_R & (1u<<k))) // If K(th) bit of port J is null then,
														
							
						{
							printf("%c\n",arr[k][j]; //it prints the character which is pressed on keypad

					
					 	}


					}


		}


}

//-----------------------------------------------------------------


system("pause");

return 0 ;


