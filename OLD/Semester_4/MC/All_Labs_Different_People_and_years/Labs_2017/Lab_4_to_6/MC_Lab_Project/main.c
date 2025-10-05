/*------------------------------------------------------------------------------------
MC Lab Project
Walter Keyes
Ganesh Simha Reddy Pucha
Ievgenii Nudga
 *------------------------------------------------------------------------------------
 */

#include "tm4c1294ncpdt.h"
#include "stdio.h"
#include "bitmap.h"

#define displayLength 60

unsigned char map[displayLength];
unsigned char tmpTxt[displayLength];
char * text[10];

void timerWait(unsigned short usec) {
	TIMER0_TAILR_R = (unsigned long) 16/3 * usec  - 0.5;
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
	TIMER0_TAPR_R = 3-1;
}

void configGPIO(void) {
	SYSCTL_RCGCGPIO_R |= (1<<11 | 1<<10 | 1<<3 | 1<<13); // Ports M,L,D,P
	while ((SYSCTL_PRGPIO_R & (1<<11 | 1<<10 | 1<<3 | 1<<13)) ==0);

	//Pendulum LEDs
	GPIO_PORTM_DIR_R = 0xFF;
	GPIO_PORTM_DEN_R = 0xFF;

	//Pendulum R/L
	GPIO_PORTL_DIR_R = ~0x01;
	GPIO_PORTL_DEN_R = 0x01;

	//UART
	GPIO_PORTD_AHB_DIR_R = ~0x01;
	GPIO_PORTD_AHB_DEN_R = 0x00;

	//Button
	GPIO_PORTP_DIR_R = ~0x01;
	GPIO_PORTP_DEN_R = 0x00;
}

void displayText(int RL) {
	int i;
	GPIO_PORTM_DATA_R = 0x00;
	timerWait(6200);
	if(RL == 1){
		for(i = 0; i < displayLength; i++) {
			GPIO_PORTM_DATA_R = tmpTxt[i];
			timerWait(800);
		}
	} else {
		for(i = displayLength - 1; i >= 0; i--) {
			GPIO_PORTM_DATA_R = tmpTxt[i];
			timerWait(800);
		}
	}
	GPIO_PORTM_DATA_R = 0x00;
}

void setMap() {
	int i = 0;
	for(i = 0; i < 10; i++) {
		int j = 0;
		for(j = 0; j < 5; j++) {
			map[6 * i + j] = bitmap[(int)text[i] - 32][j];
		}
		map[6 * i + 5] = 0x00;
	}
}

int main(void)
{
	configGPIO();
	timerConfig();

	int i;
	for(i = 0; i < 10; i++) {
		text[i] = (char)(91+i); //
	}

	setMap();

	for(i = 0; i < displayLength; i++) {
		tmpTxt[i] = map[i];
	}
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
