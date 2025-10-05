////////////////////////////////////////////////////////////////
//	MC_Lab3_Part2
//	Participants: Kulakov Mykhailo
//				  Svhets  Volodymyr
//			      Jeonghyun Son
////////////////////////////////////////////////////////////////
#include "tm4c1294ncpdt.h"
#include "stdio.h"
#define Ulsb 1.220703 //mV

void configSys()
{
	int waitcycle = 0;

	//Enable Port M
	SYSCTL_RCGCGPIO_R |= 0x800;	    				// Port M clock ini
    while ((SYSCTL_PRGPIO_R & 0x800) == 0);			// Port M ready ?
	GPIO_PORTM_DEN_R = 0xFF; //PM(7:0) port enable
	GPIO_PORTM_DIR_R = 0xFF;  //PM(7:0) symbols output of the chip

	//enable Port L 7-digit display
	SYSCTL_RCGCGPIO_R |= 1<<10;//activate port L
	while((SYSCTL_RCGCGPIO_R & 1<<10) == 0); //wait until port L is activated
	GPIO_PORTL_DEN_R  = 0x03; //enable first 2 bits only
	GPIO_PORTL_DIR_R  = 0x03; //set the first 2 to 1(means as output from the chip)

	//Enable Port D
	SYSCTL_RCGCGPIO_R |= 1<<3;//activate port D
	while((SYSCTL_RCGCGPIO_R & 1<<3) == 0); //wait until port D is activated
	GPIO_PORTD_AHB_DEN_R  = 0x02; //enable second bit only
	GPIO_PORTD_AHB_DIR_R  = ~(0x02); //set the second bit to 0(means as input to the chip)

	//internal A/D converter PE(0)
	SYSCTL_RCGCGPIO_R |= (1<<4);		//activate Port E
	while (!(SYSCTL_PRGPIO_R & 0x10));	//Read

	SYSCTL_RCGCADC_R |= (1<<0); // ADC0 digital block
	while(!(SYSCTL_PRADC_R & 0x01)); // Ready ?
	// configure AIN3 (= PE(0)) as analog input
	GPIO_PORTE_AHB_AFSEL_R |=0x01; // PE0 Alternative Pin Function enable
	GPIO_PORTE_AHB_DEN_R &= ~0x01; // PE0 disable digital IO
	GPIO_PORTE_AHB_AMSEL_R |= 0x01; // PE0 enable analog function
	GPIO_PORTE_AHB_DIR_R &= ~0x01; // Allow Input PE0

// ADC0_SS0 configuration
ADC0_ACTSS_R &= ~0x0F; // disable all 4 sequencers of ADC0

//### magic code #####
SYSCTL_PLLFREQ0_R |= (1<<23); // PLL Power
while (!(SYSCTL_PLLSTAT_R & 0x01)); // until PLL has locked
ADC0_CC_R |= 0x01; waitcycle++; // PIOSC for ADC sampling clock
SYSCTL_PLLFREQ0_R &= ~(1<<23); // PLL Power off
//### end of magic code ####

ADC0_SSMUX0_R |= 0x00000003; // sequencer 0, channel AIN3
ADC0_SSCTL0_R |= 0x00000002; // END0 set, sequence length = 1
ADC0_ACTSS_R |= 0x01; // enable sequencer 0 ADC0
}


//------------ADC0_InSeq0------------
// Analog to digital conversion
// Input: none
// Output: 12-bit result of ADC conversion
unsigned long ADC0_InSeq0(void)
{
	unsigned long data;
	ADC0_PSSI_R |= 0x01; // Start ADC0
	// wait for FIFO "NON EMPTY"
	while(ADC0_SSFSTAT0_R & 0x000000100); // - exit when FULL bit = 1
// Take from FIFO
data =(unsigned long)(ADC0_SSFIFO0_R * Ulsb + 0.5);
return data;
}

//display voltage value at the 4-digit display
void display()
{
	unsigned long total =  ADC0_InSeq0();
	unsigned long lasthalf = 0;
		int waiter = 0;
		//display last 2 digits


		lasthalf = total % 100;
		GPIO_PORTM_DATA_R = (unsigned long)(((lasthalf/10)<<4) | (lasthalf % 10));
		waiter++;
		GPIO_PORTL_DATA_R |= 0x01; //enable 1
		waiter++;
		GPIO_PORTL_DATA_R = 0x00;
		//display first 2 digits
		GPIO_PORTM_DATA_R = 0x00;
		waiter++;

		total /= 100;
		GPIO_PORTM_DATA_R = (unsigned long)(((total/10)<<4) | (total % 10));
		waiter++;
		GPIO_PORTL_DATA_R |= 0x02;
		waiter++;
		GPIO_PORTL_DATA_R = 0x00;
		waiter++;
		GPIO_PORTM_DATA_R = 0x00;
		waiter++;
}

void main()
{
	int i = 0;

	configSys();
	while(1)
	{
		GPIO_PORTD_AHB_DATA_R |= 0x02; //stop
		GPIO_PORTD_AHB_DATA_R = 0x00; //start
		display();
		//for(i = 0; i < 1000000; i++)
		//{}
	}

}
