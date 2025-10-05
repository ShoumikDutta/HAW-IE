/*------------------------------------------------------------------------------------
MC Lab Project
Walter Keyes
Ievgenii Nudga
 *------------------------------------------------------------------------------------
 */

#include "tm4c1294ncpdt.h"
#include "stdio.h"
#include "int_handler.h"

unsigned char Inverted = FALSE;
short charCount = 0;

unsigned char map[DISPLAYLENGTH];
unsigned char tmpTxt[DISPLAYLENGTH];
char text[BUFFERLENGTH];

void timerWait(unsigned short usec) {
	TIMER0_TAILR_R = (unsigned long) 25/4 * usec  - 0.5;
	TIMER0_CTL_R |= 0x01;
	while((TIMER0_RIS_R & 0x01)==0x00);
	TIMER0_ICR_R |= 0x01;
	TIMER0_CTL_R &= ~0x01;
}

void timerConfig(void) {
	SYSCTL_RCGCTIMER_R = 0x01;
	while(SYSCTL_RCGCTIMER_R != 0x01);

	TIMER0_CTL_R &= ~0x0001;
	TIMER0_CFG_R = 0x4;
	TIMER0_TAMR_R = 0x02;
	TIMER0_TAPR_R = 4-1;
}

void configUART(void) {
	// switch over to main quartz oscillator at 25MHz
	 // clear MOSC power down, high oscillator range setting, and no crystal present setting
	 SYSCTL_MOSCCTL_R &= ~(SYSCTL_MOSCCTL_OSCRNG | SYSCTL_MOSCCTL_PWRDN |SYSCTL_MOSCCTL_NOXTAL);
	 SYSCTL_MOSCCTL_R |= SYSCTL_MOSCCTL_OSCRNG;                             // increase the drive strength for MOSC
	 SYSCTL_RSCLKCFG_R = SYSCTL_RSCLKCFG_OSCSRC_MOSC;                    // set the main oscillator as main clock source

	SYSCTL_RCGCGPIO_R |= (1 << 3);	//CLK to GPIO port D
	while(!(SYSCTL_PRGPIO_R & (1<<3)));

	GPIO_PORTD_AHB_DEN_R |= 0x10;	//Enable D4
	GPIO_PORTD_AHB_AFSEL_R |= 0x10;	//Alternate funtion for D4
	GPIO_PORTD_AHB_PCTL_R |= 0x00010000; //Select UART2 receiver function

	SYSCTL_RCGCUART_R |= 0x4;		//CLK to UART2
	while(!(SYSCTL_PRUART_R & 0x4));

	UART2_CTL_R &= ~0x01; //disable UART for config

	UART2_IBRD_R = 13;	//Baud rate div
	UART2_FBRD_R = 36;	//Baud rate div fractional

	UART2_LCRH_R |= 0x60;	//Line control 8N1

	UART2_CTL_R |= 0x201;	//Enable receiver

	// UART2 interrupts
	UART2_ICR_R = 0xE7FF;               // clear all interrupts
	UART2_IM_R = 1<<4;                  // activate UART2 Rx interrupts
	NVIC_EN1_R |= 1<<(33-32);           // enable UART2 IRQ in NVIC(IRQ 33)
}

void configPortP()
{
	SYSCTL_RCGCGPIO_R |= (1<<13);
	while(!(SYSCTL_PRGPIO_R & (1<<13)));  //ready?

	GPIO_PORTP_DEN_R |= (1<<0); // enable pins
	GPIO_PORTP_DIR_R &= ~(1<<0); // PortP(0) input

	GPIO_PORTP_IS_R &= ~0x01; // sense to "edge-sensitive"
	GPIO_PORTP_IBE_R &= ~0x01; // trigger set to "single edge"
	GPIO_PORTP_IEV_R |= 0x01; // interrupt event to rising edge
	GPIO_PORTP_ICR_R |= 0x01; // clear interrupt PORTP(0)
	GPIO_PORTP_IM_R |= 0x01; // unmask PORTP(0) = S1

	NVIC_EN2_R |= (1<<12); // enable PortP interrupt in NVIC
}

void configPendulum(void) {
	SYSCTL_RCGCGPIO_R |= (1<<11 | 1<<10); // Ports M,L
	while ((SYSCTL_PRGPIO_R & (1<<11 | 1<<10)) == 0);

	//Pendulum LEDs
	GPIO_PORTM_DIR_R = 0xFF;
	GPIO_PORTM_DEN_R = 0xFF;

	//Pendulum R/L
	GPIO_PORTL_DIR_R = ~0x01;
	GPIO_PORTL_DEN_R = 0x01;

}

void displayText(int RL) {
	int i;
	if(Inverted) {
		GPIO_PORTM_DATA_R = 0xFF;
	} else {
		GPIO_PORTM_DATA_R = 0x00;
	}
	timerWait(9000);
	if(RL == 1){
		for(i = 0; i < DISPLAYLENGTH; i++) {
			if(Inverted) {
				GPIO_PORTM_DATA_R = ~map[i];
			} else {
				GPIO_PORTM_DATA_R = map[i];
			}

			timerWait(700);
		}
	} else {
		for(i = DISPLAYLENGTH - 1; i >= 0; i--) {
			if(Inverted) {
				GPIO_PORTM_DATA_R = ~map[i];
			} else {
				GPIO_PORTM_DATA_R = map[i];
			}
			timerWait(700);
		}
	}
	GPIO_PORTM_DATA_R = 0x00;
}

int main(void)
{
	configPendulum();
	configUART();
	configPortP();
	timerConfig();

	unsigned int previousRL = (GPIO_PORTL_DATA_R & 0x01);
	while(1){
		if(previousRL != GPIO_PORTL_DATA_R & 0x01) {
			if(previousRL == 0x00) {
				previousRL = 0x01;
			}  else {
				previousRL = 0x00;
			}
			displayText(previousRL);
		}

	}
}
