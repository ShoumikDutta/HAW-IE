
#include "inc/lm3s9b92.h"
#include <stdio.h>
#include "font.h"

#define BUFFERLENGTH 10
#define TIMER 1000
void timerConfig();
void timerWait(unsigned short Usec);
void wait();


void main(void)
{
	char buffer[BUFFERLENGTH]; 					// Rx data buffer
	int waitCycle=0;
	int i=0; 									// buffer index
												// activate main quartz oscillator at 16MHz
	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);


// from sw led
	timerConfig();
	SYSCTL_RCGC2_R = (1<<3)|(1<<4); // clock Port D and E
	wait();

	GPIO_PORTD_DEN_R |= 0xFF; // PD(0) enable (7:0)
	GPIO_PORTD_DIR_R |= 0xFF; // PD(0) output (7:0)

	GPIO_PORTE_DEN_R |= 0x01; // PD(0) enable (pin : 0)
	GPIO_PORTE_DIR_R |= 0x00; // PD(0) Input (pin : 0)

// end of sw led



	waitCycle++;
	// initialize Port G
	SYSCTL_RCGC2_R |= 0x00000040; 				// switch on clock for Port G
	waitCycle++; 								// wait for clock to stabilize
	GPIO_PORTG_DEN_R |= 0x01;					// PG(0) digital I/O enable
	GPIO_PORTG_DIR_R &=~ 0x01;
	GPIO_PORTG_AFSEL_R |= 0x001; 				// PG(0) alternate function
	GPIO_PORTG_PCTL_R |= 0x00000001; 			// PG(0) alternate function is U2Rx

	//UART
	SYSCTL_RCGC1_R |= 0x00000004;				// switch on clock for UART2
	waitCycle++; 							// short delay for stable clock
	UART2_CTL_R &= ~0x0001; 				// disable UART2 for configuration
	UART2_IBRD_R = 8; 							// set DIVINT of BRD
	UART2_FBRD_R = 44; 							// set DIVFRAC of BRD
	UART2_LCRH_R = 0x00000060;						 // serial format 7/O/2
	UART2_CTL_R |= 0x0001; 						// start UART2
	waitCycle++;


//delete
	while(1)
		{
			while((GPIO_PORTE_DATA_R & 0x01) != 0x01)
			{
			}
			// Left Margin
			for(i=0;i<30;i++)
			{
				GPIO_PORTD_DATA_R = hexarr[i];
				if (i < 4){
					timerWait(TIMER*3);
				}
				else{
					timerWait(TIMER);
				}
			}
			while((GPIO_PORTE_DATA_R&0x01) == 0x01)
			{
				GPIO_PORTD_DATA_R = 0x00;
			}
		}
// end of delete


	while(1)
	{
		while((GPIO_PORTE_DATA_R & 0x01) != 0x01)
		{
		}
		i=0;
		while(i < BUFFERLENGTH)	{			 	 // loop while buffer not full

			while(UART2_FR_R & (1<<4));			 // wait for Rx FIFO not empty
			buffer[i]=UART2_DR_R;				 // read byte from UART2 data register
			if(buffer[i]==0x04){
				buffer[i]=0x00;
				break;
			}
			i++; 								// increment buffer index
		}
		printf("Content of Data Buffer \n%s\n",buffer);
	}
}



void wait(void){
	int i =0;
	for (i =0;i < 1000; i++){
	}
}
void timerConfig(){
	SYSCTL_RCGC1_R |= (1<<16);
	wait();
	TIMER0_CTL_R &= ~0x0001; 	// disable Timer 0
	TIMER0_CFG_R = 0x04; 		// 2 x 16-bit mode
	TIMER0_TAMR_R = 0x01; 		// periodic mode + match enable
	TIMER0_TAPR_R = 3-1; 		// prescaler PR = ceil((16Mhz/2^16)*10ms)-1
}
void timerWait(unsigned short Usec){
	TIMER0_TAILR_R = ((16*Usec)/3)-1; 		// ((16Mhz*Usec)/PR)-1
	TIMER0_CTL_R |= 0x0001; 				//Enable the Timer
	while((TIMER0_RIS_R & (1<<0))==0)
	{ 										// wait until the flag set
	}
	TIMER0_ICR_R |= (1<<0); //clear the interrupt flag
	TIMER0_CTL_R &= ~0x0001; //Disable the Timer
}




















#include "lm3s9b92.h"
#include "stdio.h"
#define TIMER 1000
void timerConfig();
void timerWait(unsigned short Usec);
void wait();
int main(void)
{
	int i;
	unsigned long hexarr[30]={ 0xFF, 0x99, 0xA5, 0x63, 0x00, 0xFE, 0x11, 0x11, 0xFE,
			0x00, 0xFF, 0x18, 0x24, 0xC3, 0x00, 0x7F, 0x80, 0x80, 0x80, 0x7F
	};
	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);

	timerConfig();
	SYSCTL_RCGC2_R = (1<<3)|(1<<4); // clock Port D and E
	wait();

	GPIO_PORTD_DEN_R |= 0xFF; // PD(0) enable (7:0)
	GPIO_PORTD_DIR_R |= 0xFF; // PD(0) output (7:0)

	GPIO_PORTE_DEN_R |= 0x01; // PD(0) enable (pin : 0)
	GPIO_PORTE_DIR_R |= 0x00; // PD(0) Input (pin : 0)


	while(1)
	{
		while((GPIO_PORTE_DATA_R & 0x01) != 0x01)
		{
		}
		// Left Margin
		for(i=0;i<30;i++)
		{
			GPIO_PORTD_DATA_R = hexarr[i];
			if (i < 4){
				timerWait(TIMER*3);
			}
			else{
				timerWait(TIMER);
			}
		}
		while((GPIO_PORTE_DATA_R&0x01) == 0x01)
		{
			GPIO_PORTD_DATA_R = 0x00;
		}
	}
}
void wait(void){
	int i =0;
	for (i =0;i < 1000; i++){
	}
}
void timerConfig(){
	SYSCTL_RCGC1_R |= (1<<16);
	wait();
	TIMER0_CTL_R &= ~0x0001; // disable Timer 0
	TIMER0_CFG_R = 0x04; // 2 x 16-bit mode
	TIMER0_TAMR_R = 0x01; // periodic mode + match enable
	TIMER0_TAPR_R = 3-1; // prescaler PR = ceil((16Mhz/2^16)*10ms)-1
}
void timerWait(unsigned short Usec){
	TIMER0_TAILR_R = ((16*Usec)/3)-1; // ((16Mhz*Usec)/PR)-1
	TIMER0_CTL_R |= 0x0001; //Enable the Timer
	while((TIMER0_RIS_R & (1<<0))==0)
	{
		// wait until the flag set
	}
	TIMER0_ICR_R |= (1<<0); //clear the interrupt flag
	TIMER0_CTL_R &= ~0x0001; //Disable the Timer
}

