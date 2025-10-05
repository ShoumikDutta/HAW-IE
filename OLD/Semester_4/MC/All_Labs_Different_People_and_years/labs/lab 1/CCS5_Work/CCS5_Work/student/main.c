/*---------------------------------------------------------------------------------------
 * Testprogram:  PortD and J Leds on/off
 * 	             Print "MP-Labor" on console
 *                                                                          Prosch 8/2013
 *---------------------------------------------------------------------------------------
*/
#define  PART_LM3S9B92

#include "lm3s9b92.h"
#include "stdio.h"

void wait(void){
	int tmp;
	for(tmp=0;tmp<1000000;tmp++);
}
int main(void)
{	// Port  Clock Gating Control
	 SYSCTL_RCGC2_R |= SYSCTL_RCGC2_GPIOD;
	 wait();

	 // Set direction
	 GPIO_PORTD_DIR_R = 0xFF;

	 // Digital enable
	 GPIO_PORTD_DEN_R = 0xFF;

	 // Ports on/off
	 while(1){
		GPIO_PORTD_DATA_R=0xFF;
		wait();
		GPIO_PORTD_DATA_R =0x00;
		wait();
		printf("MP-Labor\n");

	 }
}
