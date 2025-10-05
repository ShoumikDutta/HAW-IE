//2.1.3 Wägeverfahren

#include "inc/lm3s9b92.h"
#include "stdio.h"

void prewait(void){
	int i;
	for(i=0; i<100;i++);
}

void wait(unsigned short usec){
	TIMER0_TAILR_R = ((usec*10^-6)*(1/16000000));		//prescale to usec value
	TIMER0_CTL_R |= 0x0001; 							// enable Timer 0
	while((TIMER0_RIS_R&(1<<0))==0);					//wait for timeout flag	
	TIMER0_ICR_R=0x01;									//clear timeout flag
}

void configSys(void)
	{
		SYSCTL_RCGC2_R |= (1<<3)| (1<<6)| (1<<8)| (1<<4);        // clock PD-PG-PJ-PE
		prewait();
		SYSCTL_RCC_R =((SYSCTL_RCC_R |0x00000540)&~ 0x000002B1);
		//Port D
		GPIO_PORTD_DEN_R = 0xFF;		//enable all bits
		GPIO_PORTD_DIR_R = 0xFF; 		//set direction of all bits
		//Port G
		GPIO_PORTG_DEN_R = 0x03;
		GPIO_PORTG_DIR_R = 0x00;
		//Port E
		GPIO_PORTE_DEN_R |=0x07;
		GPIO_PORTE_DIR_R |=0x07;
		//Port J
		GPIO_PORTJ_DEN_R = 0xFF;
		GPIO_PORTJ_DIR_R = 0xFF;
		//timer configuration
		SYSCTL_RCGC1_R |= (1<<16);		//clock timer 0
		prewait();
		TIMER0_CTL_R &= ~0x0001; 		// disable Timer 0
		TIMER0_CFG_R = 0x04; 			// 2 x 16-bit mode
		TIMER0_TAMR_R = 0x01;			//one shot mode
		//TIMER0_TAILR_R = 480; 		//--> 30 µs
	}
	
void display(int value){
	int voltage,a,b; 
	voltage = (int)(value * 19.53125);				//exmp.: value = 10010101 -> voltage = 2910,....
	
	GPIO_PORTE_DATA_R= 0x02;			//Port E 1 enable
	a = voltage%1000;								// a = 2
	voltage -= a*1000;								//"rest" = 910
	b = voltage%100;								//b = 9
	voltage -= b*100;								//"rest" = 10
	GPIO_PORTJ_DATA_R = 0xab;						//=0x29			-->LED Display "29.."
	
	GPIO_PORTE_DATA_R= 0x01;			//Port E 0 enable
	a = voltage%10;									// a = 1;
	voltage -= a*10;								//rest = 0
	b = voltage%1;									// b = 0
	GPIO_PORTJ_DATA_R = 0xab;						//0x10			-->LED Display "2910"
}
	
int main(){
	int i,SAR;
	configSys();
	
	while(1){
		GPIO_PORTE_DATA_R = 0x04;				//Define TriggerPuls for Port E(2)
		GPIO_PORTE_DATA_R = 0x00;
		
		SAR = 0x80;								//MSB (10000000)
		if(GPIO_PORTG_DATA_R != 0x02){			//if Port G 1 is enable
			for(i=7; i>0; i--){					//go through all Bits
				GPIO_PORTD_DATA_R=SAR;  		//giving the value of BIT for PORTD

				wait(30); 						//giving enough time to Port D to get updated
				if(GPIO_PORTG_DATA_R & 0x01)    //Input comparison by comparator, if 1 (voltage less that U_E)
					SAR|=(1<<i-1); 				//set the i-1 th bit to 1
				else
				{
					SAR &=~(1<<i); 				//clear the i-th bit
					SAR |=(1<<i-1);				//set the i-1 th bit to 1
				}
			}
		}
		display(SAR);							//displays BIT on the LED Board
	}
}


















