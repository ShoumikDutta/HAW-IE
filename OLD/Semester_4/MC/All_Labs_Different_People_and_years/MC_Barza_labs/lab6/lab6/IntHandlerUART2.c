#include "inc/lm3s9b92.h"
#include "int_UART2handler.h"// #define CLOCKWISE / COUNTERCLOCKWISE
#include "stdio.h"


void IntHandlerUART2(void){
	if(UART2_MIS_R & (1<<4)){
		UART2_ICR_R |=(1<<4);
		gucRxChar = UART2_DR_R;
		gucNewData = 1;

	}
	//printf("Content of Data Buffer \n%c\n",gucRxChar);
}
