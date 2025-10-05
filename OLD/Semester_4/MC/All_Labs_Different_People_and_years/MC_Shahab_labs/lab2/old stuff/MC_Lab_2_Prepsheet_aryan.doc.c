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
	TIMER0_TAPR_R = 3; 				//prescale (best would be 2.44) IN ADDITION: TIMER0_TAPR_R = 30; for a whole swing cyle 120 ms
	TIMER0_TAILR_R = 50176 -1;		//set reload value IN ADDITION: TIMER0_TAILR_R = 64000 -1; for a whole swing cyle 120 ms
	TIMER0_TAMATCHR_R = 25088 -1;	//set match value IN ADDITION: TIMER0_TAMATCHR_R = 32000 -1; for a whole swing cycle 120 ms
	TIMER0_CTR_R = 0x0001;			//start timer
}

int main(){
	int edgeSemsorTemp = 0;	

	SYSCTL_RCGC2_R = (1<<3);	//clock D
	GPIO_PORTD_DEN_R |= 0x01;	//enable D(0)
	GPIO_PORTD_DIR_R |= 0x00;	//Port D(0) as input

	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);		//f=16 MHz
	
	timerConfig();													//see function
	
	while(1){
		if((GPIO_DATAD_R & 0x01) == 1){								//right
		
			
			
			
		}
		
		if(!((GPIO_DATAD_R & 0x01) == 1)){							//left

			
			
			
		}
		TIMER0_ICR_R |= (1<<4); 								//clear match flag
		TIMER0_ICR_R |= (1<<0);									//clear time-out flag
	}
	

}
