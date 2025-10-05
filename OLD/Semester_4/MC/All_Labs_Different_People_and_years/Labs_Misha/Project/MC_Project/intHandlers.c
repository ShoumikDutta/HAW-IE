/*
 * intHandlers.c
 *
 *  Created on: 14.06.2017
 *      Author: mpp
 */
#include "tm4c1294ncpdt.h" // register names (macros)
#include "intHandlers.h"
#include "stdio.h"
// handler reads UART6 Rx FIFO and prints character
void IntHandlerUART6(void)
{
	if (UART6_MIS_R & (1<<4)) // check whether UART6 Rx interrupt
	{
		UART6_ICR_R |=(1<<4); // clear interrupt
		gucRxChar = UART6_DR_R; // read byte from UART6 data register
		gucNewData = 1;
	}
}

// PAUSE button interrupt handler
void IntPortK0Handler(void)
{
	GPIO_PORTK_ICR_R |= 0x0001; // clear interrupt source E0

	if ((GPIO_PORTK_DATA_R & 0x0001) && !buttonPausePressed) // button1 was pressed - first time(pause game)
	{
		buttonPausePressed = 1;
	}
	else if(((GPIO_PORTK_DATA_R & 0x0001) && buttonPausePressed)) // button1 was pressed - second time(continue game)
	{
		buttonPausePressed = 0;
	}
}


// END GAME button interrupt handler
void IntPortD0Handler(void)
{
	GPIO_PORTD_AHB_ICR_R |= 0x0001; // clear interrupt source D0

	if ((GPIO_PORTD_AHB_DATA_R & 0x0001) && !endGame) // button2 was pressed - first time(end game)
	{
		endGame = 1;
		startNewGame = 0;
	}
	else if(((GPIO_PORTD_AHB_DATA_R & 0x0001) && endGame)) //button2 was pressed - second time(start new game)
	{
		endGame = 1;
		startNewGame = 1;
	}
}
