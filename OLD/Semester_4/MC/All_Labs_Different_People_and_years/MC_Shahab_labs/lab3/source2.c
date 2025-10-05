//2.2.1 interner AD-Converter

#include "inc/lm3s9b92.h"
#include "stdio.h"
#define ULSB = 0.48828125;

void wait(){
	for(int i = 0; i< 100; i+)
}

void configSys(){
	// configure AIN0 (=PG(7)) as analog input
	SYSCTL_RCGC2_R |= (1<<4); // PG (AIN0 to AIN2 belong to Port E)
	SYSCTL_RCGC0_R |= (1<<16); // ADC0
	wait();
	GPIO_PORTE_DEN_R |=0x02;		//Enable Port G(7) and G(2);
	GPIO_PORTE_AFSEL_R |= 0x80;		// Alternating
	GPIO_PORTE_DEN_R &= ~0x80; 		// PE7 disable digital IO
	GPIO_PORTE_DIR_R &= ~0x80;		// Setting the direction
	GPIO_PORTE_AMSEL_R |= 0x80; 	// PE7 enable analog function
}

void display(){
	
}

void main(void)
{
		configSys();
		while(1)
		{
			GPIO_PORTE_DATA_R=0x04;
			GPIO_PORTE_DATA_R=0x00;
			display();
		}
}

