#include <stdio.h>
#include "inc\lm3s9b92.h"

#define TMIN 1.875e-7  				//shortest time of a microcontroller step

//a function that waits the us time written in the main function.
void timerWait(unsigned short usec){
	int value;
	
	TIMER0_CTL_R &= ~0x0001;		//disable Timer 0
	value = (usec / TMIN) +1;		//calculates the number of Tmin steps of the counter -- Tmin is one clock cycle of the MC
	TIMER0_TAILR_R = value;			//sets the reload value to the calculated number
	TIMER0_CTR_R = 0x0001;			//start timer
	
	if((TIMER0_RIS_R & (1<<4))==0){	//when timeout-flag is reaced:
	
	TIMER0_ICR_R |= (1<<4); 		//clear match flag
	TIMER0_ICR_R |= (1<<0);			//clear time-out flag
	TIMER0_CTL_R &= ~0x0001;		//disable Timer 0
	TIMER0_TAILR_R = 50176;			//reset reload value to the original
	TIMER0_CTR_R = 0x0001;			//start timer again
	}
}

void timerConfig(void){
	SYSCTL_RCGC1_R |= (1<<16);		//activate Timer 0
	timerWait(10);					//waits 10 micro seconds -- see funtion
	TIMER0_CTL_R &= ~0x0001;		//disable Timer 0
	TIMER0_CFG_R = 0x04;			//2x 16-bit MOde
	TIMER0_TAMR_R = 0x22;			//periodic mode + match enable
	TIMER0_TACDIR_R = 0;			//count direction: down
	TIMER0_TAPR_R = 3; 				//prescale (best would be 2.44) with 3: Tmax = 12.288 ms
	TIMER0_TAILR_R = 50176;			//set reload value --> 65536 - [(12.288ms - 10ms) / (12.288ms/65536)]
	TIMER0_TAMATCHR_R = 25088;		//set match value (5ms)
	TIMER0_CTR_R = 0x0001;			//start timer
}

int main(){
	int edgeSemsorTemp = 0;											//edge sensor, that is high or low
	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);		//f=16 MHz
	
	timerConfig();													//see function
	
	while(1){
		if((GPIO_DATAD_R & 0x01) && edgeSemsorTemp == 0){			//rising edge
			edgeSemsorTemp = 1;
			
			
			
		}
		
		if(!(GPIO_DATAD_R & 0x01) && edgeSemsorTemp == 1){			//falling edge
			edgeSemsorTemp = 0;
			TIMER0_ICR_R |= (1<<4); 								//clear match flag
			TIMER0_ICR_R |= (1<<0);									//clear time-out flag
			
			
			
		}
	}
	

}
