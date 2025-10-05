#include "lm3s9b92.h"
#include "Int_handler.h"
#include "stdio.h"

void IntHandlerPortH(void){
GPIO_PORTH_ICR_R |= 0x80;	//clear interrupt flag
	if (isInverted == NORMAL){
		isInverted = INVERTED;
	}

	else
		isInverted = NORMAL;

}
