//IntPortPHandler

#include "tm4c1294ncpdt.h"
#include "int_handler.h"


void IntPortPHandler(void)
{
	GPIO_PORTP_ICR_R |= (1<<0);
	if(Inverted)
	{
		Inverted = 0;
	}
	else
	{
		Inverted = 1;
	}
}

void IntHandlerUART2 (void){



	if (UART2_MIS_R & (1<<4))      // check whether UART2 Rx interrupt
	{
		//UART2_ICR_R |=(1<<4);      // clear interrupt


		while(~UART2_FR_R & 0x10) {
			text[charCount] = UART2_DR_R;
			if(text[charCount] == 0x0D) {
				int i;
				for(i = charCount; i < BUFFERLENGTH; i++) {
					text[i] = 0;
				}
				charCount = 0;
				setMap();
				break;
			}
			charCount++;
			if(charCount == BUFFERLENGTH) {
				charCount = 0;
				setMap();
			}
		}
	}
}

void setMap() {
	int i = 0;
	for(i = 0; i < 10; i++) {
		int j = 0;
		for(j = 0; j < 5; j++) {
			map[6 * i + j] = bitmap[(int)text[i]][j];
		}
		map[6 * i + 5] = 0x00;
	}
}
