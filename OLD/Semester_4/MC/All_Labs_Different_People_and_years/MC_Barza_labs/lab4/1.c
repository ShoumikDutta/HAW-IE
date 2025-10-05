 #include "inc/lm3s9b92.h"
#include <stdio.h>
#define BUFFERLENGTH 10
void main(void)
{
	char buffer[BUFFERLENGTH]; 					// Rx data buffer
	int waitCycle=0;
	int i=0; 									// buffer index
												// activate main quartz oscillator at 16MHz
	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);
	waitCycle++;
	// initialize Port G
	SYSCTL_RCGC2_R |= 0x00000040; 				// switch on clock for Port G
	waitCycle++; 								// wait for clock to stabilize
	GPIO_PORTG_DEN_R |= 0x03;					// PG(0) digital I/O enable
	GPIO_PORTG_DIR_R |= 0x02; 					// PG(0) input
	GPIO_PORTG_DIR_R &=~ 0x01;
	GPIO_PORTG_AFSEL_R |= 0x001; 				// PG(0) alternate function
	GPIO_PORTG_PCTL_R |= 0x00000001; 			// PG(0) alternate function is U2Rx
	
	//UART
	SYSCTL_RCGC1_R |= 0x00000004;				// switch on clock for UART2
	waitCycle++; 							// short delay for stable clock
	UART2_CTL_R &= ~0x0001; 				// disable UART2 for configuration
	UART2_IBRD_R = 8; 							// set DIVINT of BRD
	UART2_FBRD_R = 44; 							// set DIVFRAC of BRD
	UART2_LCRH_R = 0x0000004A;						 // serial format 7/O/2
	UART2_CTL_R |= 0x0001; 						// start UART2
	waitCycle++;

	while(1)
	{
		i=0;
		while(i < BUFFERLENGTH)	{			 	 // loop while buffer not full

			while(UART2_FR_R & (1<<4));			 // wait for Rx FIFO not empty
			buffer[i]=UART2_DR_R;
							// read byte from UART2 data register
			if(buffer[i]==0x04){
				buffer[i]=0x00;
				break;
			}
			i++; 								// increment buffer index
		}
		printf("Content of Data Buffer \n%s\n",buffer);
	}
}
