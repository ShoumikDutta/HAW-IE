/*---------------------------------------------------------------------------------------
 * Testprogram:  PortD Leds on/off
 * 	             Print "MP-Labor" on console
 *                                                                         - Prosch 3/2014
 *---------------------------------------------------------------------------------------
 */


#include "lm3s9b92.h"
#include "stdio.h"
#include "inc/hw_types.h"
#include "driverlib/sysctl.h"
#define BUFFERLENGTH 11
#define NORMAL 0
#define INVERTED 1

void sysConfig(void);
void timerConfig(void);
void timerWait(unsigned short usec);
void displayString( char buffer[]);

volatile unsigned char isInverted = NORMAL;
volatile char buffer[10] = {0};
char codedLetters[][5] = { {
		0x3F, 0x48, 0x88, 0x48, 0x3F },	//A
		{ 0xFF, 0x91, 0x91, 0x91, 0x6E },	//B
		{ 0x7E, 0x81, 0x81, 0x81, 0x42 },	//C
		{ 0xFF, 0x81, 0x81, 0x81, 0x7E },	//D
		{ 0xFF, 0x91, 0x91, 0x91, 0x81 },	//E
		{ 0xFF, 0x90, 0x90, 0x90, 0x80 },	//F
		{ 0x7E, 0x81, 0x81, 0x89, 0x4E },	//G
		{ 0xFF, 0x08, 0x08, 0x08, 0xFF },	//H
		{ 0x81, 0x81, 0xFF, 0x81, 0x81 },	//I
		{ 0x82, 0x81, 0xFE, 0x80, 0x80 },	//J
		{ 0xFF, 0x10, 0x10, 0x28, 0xC7 },	//K
		{ 0xFF, 0x01, 0x01, 0x01, 0x01 },	//L
		{ 0xFF, 0x40, 0x30, 0x40, 0xFF },	//M
		{ 0xFF, 0x60, 0x18, 0x06, 0xFF },	//N
		{ 0x7E, 0x81, 0x81, 0x81, 0x7E },	//O
		{ 0xFF, 0x88, 0x88, 0x88, 0x70 },	//P
		{ 0x7E, 0x81, 0x85, 0x7E, 0x01 },	//Q
		{ 0xFF, 0x88, 0x88, 0x88, 0x77 },	//R
		{ 0x62, 0x91, 0x91, 0x89, 0x46 },	//S
		{ 0x80, 0x80, 0xFF, 0x80, 0x80 },	//T
		{ 0xFE, 0x01, 0x01, 0x01, 0xFE },	//U
		{ 0xFE, 0x01, 0x02, 0x04, 0xF8 },	//V
		{ 0xFF, 0x02, 0x0C, 0x02, 0xFF },	//W
		{ 0xC7, 0x28, 0x10, 0x28, 0xC7 },	//X
		{ 0xF0, 0x08, 0x07, 0x08, 0xF0 },	//Y
		{ 0x83, 0x85, 0x89, 0x91, 0xE1 }	//Z
};

void wait(void){
	int tmp;
	for (tmp = 0; tmp < 10000; tmp++);
}

int main(void){

	//	char buffer[BUFFERLENGTH]; // Rx data buffer
	//	char buffer[] = { 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'V' };

	int i = 0;
	int flag = 0;
	int index = 0;		//index in the coded letters array
	int  j;
	int k = 0;
	int timerDelay = 2000;

	sysConfig();


	while (1) {
		if ((GPIO_PORTE_DATA_R & 0x01) == 0x01 && flag == 0){			//left edge detected

			i = 0;
			for (k = 0; k < 10; k++){

				if (buffer[k] == 0x00)				//if the end of the string is detected - break
					break;
				else if (buffer[k] < 0x41 && buffer[k]>0x5A){		//if it's not a capital letter
					GPIO_PORTD_DATA_R = 0X00;
					timerWait(timerDelay);

					GPIO_PORTD_DATA_R = 0X00;
				}
				else {

					index = buffer[k] - 0x41;		//calculates the respective letter code in the array of coded characters

					for (j = 0; j <= 5; j++){					//(i < actualBufferLength * 5 + actualBufferLength) for dynamic string

						if (j == 5)								//to print a blank space after each letter
							GPIO_PORTD_DATA_R = 0X00;
						else{
							GPIO_PORTD_DATA_R = codedLetters[index][j]; //getting 5 consequetive ints from the array to display 1 letter
						}
						if (i < 1){
							timerDelay = 1000;
						}
						else if (i >= 1 && i <= 5){

							timerDelay = 2500 - 150 * i;
						}

						else if (i > 43){
							timerDelay += 40;

						}

						else {				//middle characters
							timerDelay = 750;
						}
						i++;
						if (isInverted == INVERTED){					//if the inverting switch is pressed
							GPIO_PORTD_DATA_R = ~GPIO_PORTD_DATA_R;
						}
						timerWait(timerDelay);

						GPIO_PORTD_DATA_R = 0X00;
					}
				}

			}
			flag = 1;       //sets the flag to 1


		}
		if ((GPIO_PORTE_DATA_R & 0x01) == 0x00 && flag == 1){


			flag = 0;          //sets the flag to 0
		}
		//	displayString(buffer);
	}

}


void sysConfig(void){
	//configure sysem clock and systick timer, 16Mhz, ext. XTAL

	SysCtlClockSet(SYSCTL_SYSDIV_12_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_16MHZ);

	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);
	wait();
	// Port  Clock Gating Control
	SYSCTL_RCGC2_R |= SYSCTL_RCGC2_GPIOD;
	wait();

	SYSCTL_RCGC2_R = (1 << 3) | (1 << 4) | (1<<6) | (1<<7);		//ports D,E,G,H
	wait();

	//	SYSCTL_RCGC2_R |= 0x00000040; // switch on clock for Port G
	//	wait();						 // wait for clock to stabilize

	GPIO_PORTG_DEN_R |= 0x01; // PG(0) digital I/O enable
	GPIO_PORTG_DIR_R &= ~0x01; // PG(0) input
	GPIO_PORTG_AFSEL_R |= 0x001; // PG(0) alternate function
	GPIO_PORTG_PCTL_R |= 0x00000001; // PG(0) alternate function is U2Rx
	SYSCTL_RCGC1_R |= 0x00000004;// switch on clock for UART2
	wait();						// short delay for stable clock

	UART2_CTL_R &= ~0x0001; // disable UART2 for configuration
	UART2_IBRD_R = 8; // set DIVINT of BRD (bitrate 115200bit/s)
	UART2_FBRD_R = 44; // set DIVFRAC of BRD
	UART2_LCRH_R = 0x00000060; // serial format 8N1
	UART2_CTL_R |= 0x0001; // start UART2

	//UART2 interrupts
	UART2_ICR_R = 0xE7FF;	//clear all interrupts
	UART2_IM_R = 1 << 4;	//activate Uart2 RX



	timerConfig();
	GPIO_PORTD_DEN_R |= 0xFF; 		// PD (7:0) enabled
	GPIO_PORTD_DIR_R |= 0xFF;		// PD (7:0) output


	GPIO_PORTE_DEN_R |= 0x01; 		// PE (0) enabled
	GPIO_PORTE_DIR_R &= ~0x01;		// PE (0) input, PE (7) input for switch

	GPIO_PORTH_DEN_R |= 0x80; 		// PH (0) enabled
	GPIO_PORTH_DIR_R &= ~0x80;		// PH (7) input for switch

	// PH (7) interrupt for switch
	GPIO_PORTH_IS_R &= ~0x01;	//interrupt edge sensitive
	GPIO_PORTH_IBE_R |= 0x01;	//trigger set to both edges
	GPIO_PORTH_ICR_R |= 0x80;	//clear interrupt PH(7)
	GPIO_PORTH_IM_R |= 0x80;	//unmask PE7
	NVIC_EN1_R = 1 << (32-32);		//enable PH IRQ in NVIC (int#32, Vec#48)

	NVIC_EN1_R = 1 << (33 - 32);	//enable UART2 IRQ IN NVIC (IRQ 33)
}

void timerConfig(void){

	SYSCTL_RCGC1_R |= (1 << 16);	 //Enable timer0A
	wait();
	TIMER0_CTL_R &= ~0X0001;	 //disable timer0A

	TIMER0_CFG_R = 0X04;		//CONFIGURE timer0 in 16bit mode

	TIMER0_TAMR_R |= 0x02;		//count down, no match enabled, periodic
	TIMER0_TAPR_R |= 3 - 1;		//Pre= (0.01*16*10^6/2^16)-1

}

void timerWait(unsigned short usec){

	TIMER0_TAILR_R = (unsigned long)(usec * 16 / 3); //Calculates ILV from usec
	TIMER0_CTL_R |= 0x0001;			//Enable timer0A


	while ((TIMER0_RIS_R & (1 << 0)) == 0x00);		//reads the timeout flag

	TIMER0_ICR_R = 0x01;		//clears interupt flag
	TIMER0_CTL_R &= ~0X0001;



}

void displayString( char buffer[]){
	int flag = 0;
	int index = 0;		//index in the coded letters array
	int i = 0, j;
	int k = 0;
	int timerDelay = 2000;					//timer delay in usec

	if ((GPIO_PORTE_DATA_R & 0x01) == 0x01 && flag == 0){			//left edge detected

		i = 0;
		for (k = 0; k < 10; k++){

			if (buffer[k] == 0x00)				//if the end of the string is detected - break
				break;
			else if (buffer[k] < 0x41 && buffer[k]>0x5A){		//if it's not a capital letter
				GPIO_PORTD_DATA_R = 0X00;
			}
			else {

				index = buffer[k] - 0x41;		//calculates the respective letter code in the array of coded characters

				for (j = 0; j <= 5; j++){					//(i < actualBufferLength * 5 + actualBufferLength) for dynamic string

					if (j == 5)								//to print a blank space after each letter
						GPIO_PORTD_DATA_R = 0X00;
					else{
						GPIO_PORTD_DATA_R = codedLetters[index][j]; //getting 5 consequetive ints from the array to display 1 letter
					}
					if (i < 1){
						timerDelay = 1000;
					}
					else if (i >= 1 && i <= 5){

						timerDelay = 2500 - 150 * i;
					}

					else if (i > 43){
						timerDelay += 40;

					}

					else {				//middle characters
						timerDelay = 750;
					}
					i++;
					if (isInverted == INVERTED){					//if the inverting switch is pressed
						GPIO_PORTD_DATA_R = ~GPIO_PORTD_DATA_R;
					}
					timerWait(timerDelay);

					GPIO_PORTD_DATA_R = 0X00;
				}
			}

		}
		flag = 1;       //sets the flag to 1


	}
	if ((GPIO_PORTE_DATA_R & 0x01) == 0x00 && flag == 1){

		flag = 0;          //sets the flag to 0
	}



}

