/*---------------------------------------------------------------------------------------
 * Testprogram:  PortD Leds on/off
 * 	             Print "MP-Labor" on console
 *                                                                          Prosch 3/2014
 *---------------------------------------------------------------------------------------
*/

#define PART_LM3S9B92

#include "lm3s9b92.h"
#include "stdio.h"
#include "font.h"
#define TIME 100



void wait(void){
	int tmp;
	for(tmp=0;tmp<TIME;tmp++);
}

void timerConfig(float temp) {
	TIMER0_CTL_R &= ~0x0001; 	// disable Timer 0
	TIMER0_CFG_R = 0x04; 		// 2 x 16-bit mode
	TIMER0_TAMR_R = 0x02; 		// periodic mode + we do not need match value
	TIMER0_TAPR_R = 13-1; 		// prescaler PR= ceil(16M/2^16)*0.05)-1
								// we choose random value tmax = 0.05
	TIMER0_TAPR_R = 12* temp-1;//(16000000*temp/2^16)-1;
}


void function timerWait(unsigned short usec) {
timerConfig();
TIMER0_TAILR_R = ((usec/1000000)*16000000)/12 - 1; // ILR = (16MHz*usec)/12 -1
TIMER0_CTL_R |= 0x0001; //enable Timer 0
while((TIMER0_RIS_R & (1<<0))==0) ; // waits time-out

//TIMER0_ICR_R |= 0x01;  // IF DOES NOT WORK, UNCOMMENT THIS LINE AND COMMENT LINE ABOVE
}


int main(void)
{
	int final = {0x00, 0x00, 0xFF, 0x99, 0xA5, 0x63, 0x00, 0xFE, 0x11, 0x11, 0xFE,
				 0x00, 0xFF, 0x18, 0x24, 0xC3, 0x00, 0x7F, 0x80, 0x80, 0x80, 0x7F}
	
	
	char temp_state = 0;
	
	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);
	wait();
	
	SYSCTL_RCGC2_R |= 0x00000008;		// clock port D
	SYSCTL_RCGC2_R |= 0x00000100;
	SYSCTL_RCGC2_R |= (1<<3);
	SYSCTL_RCGC2_R |= (1<<2);
	SYSCTL_RCGC1_R |= (1<<16);
	
	wait(); 							// wait for port D activation
	GPIO_PORTD_DEN_R |= 0xFF; 			// PD(0) enable
	GPIO_PORTD_DIR_R |= 0xFF;			// PD(0) output

	GPIO_PORTJ_DEN_R |= 0x01; 			// PD(0) enable
	GPIO_PORTJ_DIR_R |= 0x00;		// PD(0) output
	
	SYSCTL_RCGC2_R |= (1<<2);
	SYSCTL_RCGC2_R |= (1<<3); 

	
	GPIO_PORTD_DEN_R = 0x01; 
	GPIO_PORTD_DIR_R = 0x00; 
	
	GPIO_PORTJ_DEN_R = 0x7F; 
	GPIO_PORTJ_DIR_R = 0x7F; 

	wait();

//	SYSCTL_RCGC1_R |= (1<<16);			//if borders are not visible uncomment this line
	

while (1) {
	int i=0;

	while ((GPIO_PORTD_DATA_R & 0x01 )!= 0x00) {
		timerWait(10000);
			
		for(i=0; i<4;i++){
			GPIO_PORTJ_DATA_R = final[i];
		}
		timerWait(8000);
		GPIO_PORTJ_DATA_R = 0x00;
		
		for(int i=4; i<11;i++){
			GPIO_PORTJ_DATA_R = final[i];
		}
		timerWait(8000);
		GPIO_PORTJ_DATA_R = 0x00;
		
		for(int i=11; i<15;i++){
			GPIO_PORTJ_DATA_R = final[i];
		}
		timerWait(8000);
		GPIO_PORTJ_DATA_R = 0x00;
		
		break;
	}


	while ((GPIO_PORTD_DATA_R & 0x01 )= 0x00) {
		timerWait(10000);
		
		for(i=14; i>10;i--){
			GPIO_PORTJ_DATA_R = final[i];
		}
		timerWait(8000);
		GPIO_PORTJ_DATA_R = 0x00;
		
		for(i=10; i>4;i--){
			GPIO_PORTJ_DATA_R = final[i];
		}
		timerWait(8000);
		GPIO_PORTJ_DATA_R = 0x00;
		
		for(i=4; i>-1;i--){
			GPIO_PORTJ_DATA_R = final[i];
		}
		timerWait(8000);
		GPIO_PORTJ_DATA_R = 0x00;
		
		break;
	}	
}
