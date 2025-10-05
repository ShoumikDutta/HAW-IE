#include "inc/lm3s9b92.h"
#include <stdio.h>
#include<stdlib.h>
#include "inc/hw_types.h" // required for SysCtlClockSet
#include "driverlib/sysctl.h" // required for SysCtlClockSet
#include "int_handler.h" // #define CLOCKWISE / COUNTERCLOCKWISE
volatile unsigned char swap =off; /* global variables */
volatile unsigned char gucNewData = off;
//volatile unsigned char gucRxChar = off;
volatile unsigned char char buffer[BUFFERLENGTH]; // Rx data buffer
#define BUFFERLENGTH 10


//-----------------------------------------TIMER CONFIG ----------------------------------------------------------
timerconfig(void ){
	int waitCycle=0;

	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);// activate main oscillator at 16 MHz w/ external XTAL
	waitCycle++;
	SYSCTL_RCGC1_R |=(1<<16);
	waitCycle++;
	TIMER0_CTL_R &= ~0x0001; // disable Timer 0A
	TIMER0_CFG_R = 0x04; // 2 x 16-bit mode
	TIMER0_TAMR_R = 0x21; //oneshot mode + match enable+countdown
	TIMER0_TAPR_R = 15-1;//prescalar =(t*16MH)/65536
	//TIMER0_TAILR_R= 2000;//loadvalue =(16*0.5)\123
	TIMER0_TAMATCHR_R = 32785-1; //matchregister value (16Mhz*5ms)/2.44 THIS MATCH VALUE IS AFTER 5  MS //not

}
//--------------------------------------------SET THE TIMER ------------------------------------------
void timerWait(int time){
	TIMER0_TAILR_R=time*16/15-1;
}
//------------------------------------------GPIO PORT CONFIG ------------------------------------
portconfig(void){
	int waitCycle=0;

	SYSCTL_RCGC2_R |= ((1 << 3) | (1 << 8)); // enabling clock for Port D  & J
	waitCycle++;
	GPIO_PORTD_DEN_R = 0x01;    // Enabling Port D
	GPIO_PORTD_DIR_R = 0x00;    // set bits D(0) of Port D as input
	GPIO_PORTJ_DEN_R = 0xFF;      // Enabling Port J
	GPIO_PORTJ_DIR_R = 0xFF;     // set bits 0 to 7of Port J as output


}






//------------------------------------UART CONFIG --------------------------------------------------
uartconfig(void){
	int waitCycle=0;
	// activate main quartz oscillator at 16MHz
	SYSCTL_RCC_R = ((SYSCTL_RCC_R | 0x00000540) & ~0x000002B1);
	waitCycle++;
	// initialize Port G
	SYSCTL_RCGC2_R |= 0x00000040; // switch on clock for Port G
	waitCycle++; // wait for clock to stabilize
	GPIO_PORTG_DEN_R |= 0x01; // PG(0) digital I/O enable
	GPIO_PORTG_DIR_R &= ~0x01; // PG(0) input
	GPIO_PORTG_AFSEL_R |= 0x001; // PG(0) alternate function
	GPIO_PORTG_PCTL_R |= 0x00000001; // PG(0) alternate function is U2Rx}
	 // initialize UART2
	SYSCTL_RCGC1_R |= 0x00000004;// switch on clock for UART2
	waitCycle++; // short delay for stable clock
	UART2_CTL_R &= ~0x0001; // disable UART2 for configuration
	// initialize bitrate of 115200 bit per second
	UART2_IBRD_R = 8; // set DIVINT of BRD (bitrate 115200bit/s)
	UART2_FBRD_R = 44; // set DIVFRAC of BRD
	 // initialize protocol options
	UART2_LCRH_R = 0x00000060; // serial format 8N1
	UART2_CTL_R |= 0x0001; // start UART2
	 // UART2 interrupts
	UART2_ICR_R = 0xE7FF; // clear all interrupts
	UART2_IM_R = 1<<4; // activate UART2 Rx
	NVIC_EN1_R |= 1<<(33-32); // enable UART2 IRQ in NVIC(IRQ 33)


}

//---------------------------------------CONFIG PORT E FOR INTERRUPT---------------------------------
void configPortE(void) // PE(0):in
 {
	int waitCycle=0;
SYSCTL_RCGC2_R |= (1<<4); // activate PORTE clock
 waitCycle++;
GPIO_PORTE_DEN_R |= 0x0001; // enable pins E(0)
GPIO_PORTE_DIR_R |= 0x0000; //set to input
GPIO_PORTE_IS_R &= ~0x01; // interrupt sense to "edge-sensitive"
GPIO_PORTE_IBE_R &= ~0x01; // interrupt trigger set to "single edge"
GPIO_PORTE_IEV_R |= 0x01; // interrupt event to rising edge
GPIO_PORTE_ICR_R |= 0x01; // clear interrupt PORTE(0)
GPIO_PORTE_IM_R |= 0x01; // unmask PORTE(0) = S1
NVIC_EN0_R |= (1<<4); // enable PortE interrupt (Int#4/Vec#20) in NVIC
}
//------------------------------------------------MAIN--------------------------------------------------------

void main(void){
	//char buffer[BUFFERLENGTH]; // Rx data buffer
	int waitCycle=0;
	int j=0; // buffer index
	char shift[50]={0.};
	char matrix[26][6]={{'A',0xFE,0x11,0x11,0xFE,0x00} ,
	{'B',0xFF,0x81,0x99,0x66,0x00},
	{'C',0x7E,0x81,0x81,0x42,0x00},
	{'D',0xFF,0x81,0x81,0x7E,0x00},
	{'E',0xFF,0x85,0x85,0x81,0x00} ,
	{'F',0xFF,0x90,0x90,0x80,0x00},
	{'G',0xFF,0x81,0x89,0x8F,0x00},
	{'H',0xFF,0x08,0x08,0xFF,0x00},
	{'I',0x00,0x81,0xFF,0x81,0x00},
	{'J',0x02,0x81,0xFF,0x80,0x00},
	{'K',0xFF,0x24,0x42,0x81,0x00},
	{'L',0xFF,0x01,0x01,0x01,0x00},
	{'M',0xFF,0x40,0x20,0x40,0xFF},
	{'N',0xFF,0x60,0x18,0x06,0xFF},
	{'O',0x7E,0x81,0x81,0x7E,0x00},
	{'P',0xFF,0x90,0x90,0x60,0x00},
	{'Q',0x7E,0x81,0x85,0x7E,0x01},
	{'R',0xFF,0x98,0x94,0x62,0x01},
	{'S',0x71,0x89,0x89,0x86,0x00},
	{'T',0x80,0xFF,0x80,0x80,0x00},
	{'U',0xFE,0x01,0x01,0xFF,0x00},
	{'V',0xE0,0x1C,0x03,0x1C,0xE0},
	{'W',0xFF,0x02,0x04,0x02,0xFF},
	{'X',0xE7,0x18,0x18,0xE7,0x00},
	{'Y',0xE3,0x76,0x1C,0xF8,0x00},
	{'Z',0x87,0x89,0x91,0xE1,0x00},
	};
	int i ;
	int k ;
	char temp=0;
	int delay[50]={500,1400,1400,1400,1400,1000,1000,1100,1100,1100 /*10*/,1100,1100,1100,1100,1100,1100,1100,1100,1100,1100 /*20*/,700,700,700,700,700 /*||*/,700,700,700,700,700 /*30*/,800,800,800,800,800,800,800,800,800,800 /*40*/,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000 /*50*/};

	portconfig();
	timerconfig();
	uartconfig();
	configPortE();





	while(1) {
		if (gucNewData) {
		gucNewData = 0;
		printf("Content of Data Buffer \n%s\n",buffer);
	fflush(stdout);



	for(i=0;i < BUFFERLENGTH;i++){
		for (j=0;j<26;j++){
			if(matrix[j][0]==buffer[i]){
				for (k=0;k<5;k++){
					shift[k+i*5]=matrix[j][k+1];

				}

			}
		}
	}



	
		if((GPIO_PORTD_DATA_R &0x01)> temp){//we are on the right side


			for (i=0;i<50;i++) {
				if (swap == 0){
				GPIO_PORTJ_DATA_R=shift[i];
				timerWait(delay[i]);
				TIMER0_CTL_R |= 0x0001; // enable Timer 0A
				while((TIMER0_RIS_R & (1<<0))==0);
				TIMER0_ICR_R|= (1<<0);
			}
			else {


									GPIO_PORTJ_DATA_R=~shift[i];
									timerWait(delay[i]);
									TIMER0_CTL_R |= 0x0001; // enable Timer 0A
									while((TIMER0_RIS_R & (1<<0))==0);
									TIMER0_ICR_R|= (1<<0);
				}
			}
		}
	}
}
}


