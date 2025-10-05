#include "inc/lm3s9b92.h"
#include "int_handler.h" // #define CLOCKWISE / COUNTERCLOCKWISE
#include "stdio.h"

void IntPortDHandler(void) // IRQ number 4, vector number 20
{
	GPIO_PORTD_ICR_R = 0x0001;// clear interrupt source push button

	if(ucDirection){
		ucDirection = ~ucDirection;
	}
	else{
		ucDirection = ~CLOCKWISE;
	}
	printf("%d\n",ucDirection);

}
