////////////////////////////////////////////////////////////////
//	MC_Lab3
//	Participants: Kulakov Mykhailo
//				  Shvets  Volodymyr
//			      Jeonghyun Son
////////////////////////////////////////////////////////////////
#include "tm4c1294ncpdt.h"
#include "stdio.h"
#define Ulsb 19.53125 //mV


//make a delay of usec(up to 10ms) - probably the max value of the timer should be changed
void timerWait(unsigned short usec)
{
// configure Timer 0
	SYSCTL_RCGCTIMER_R |= (1<<0); // timer 0
	while(!(SYSCTL_PRTIMER_R & (1<<0))); // wait for timer 0 activation
	TIMER0_CTL_R &= ~0x0001; // disable Timer 0
	TIMER0_CFG_R = 0x04; // 2 x 16-bit mode

	// compare mode, down, periodic: TAMR=0x2 -no match value
	TIMER0_TAMR_R |= 1<<1; //last 8 bits: 0000 0010
						   //4th bit = counts down, 2nd bit = 0x02 - periodic
	long pre = 3;//ceil((fCPU / pow(2.0, 16)) * 0.01); //prescaler Tmax = 10ms

	TIMER0_TAPR_R = pre - 1;
	TIMER0_TAILR_R = 16/pre * usec - 1; // probably needs also rounding //ceil((fCPU / pre) * (double)usec * pow(10.0, -6)) - 1; //load value
	TIMER0_CTL_R |= 0x0001; //start TImer0A

	while(!(TIMER0_RIS_R & 0x0001)); //flag set when 0x0000 reached(time-out)
	TIMER0_ICR_R |= 0x01; //clear TIMER0_RIS_R(0) bit
	TIMER0_CTL_R &= ~0x0001; //disable the Timer0A

}

void configSys()
{
	//Enable Port M
	SYSCTL_RCGCGPIO_R |= 0x800;	    				// Port M clock ini
    while ((SYSCTL_PRGPIO_R & 0x800) == 0);			// Port M ready ?
	GPIO_PORTM_DEN_R = 0xFF; //PM(7:0) port enable
	GPIO_PORTM_DIR_R = 0xFF;  //PM(7:0) symbols output of the chip

	//enable Port L 7-digit display
	SYSCTL_RCGCGPIO_R |= 1<<10;//activate port L
	while((SYSCTL_RCGCGPIO_R & 1<<10) == 0); //wait until port L is activated
	GPIO_PORTL_DEN_R  = 0x07; //enable first 3 bits only
	GPIO_PORTL_DIR_R  = 0x07; //set the first 3 to 1(means as output from the chip)

	//Enable Port D
	SYSCTL_RCGCGPIO_R |= 1<<3;//activate port D
	while((SYSCTL_RCGCGPIO_R & 1<<3) == 0); //wait until port D is activated
	GPIO_PORTD_AHB_DEN_R  = 0x03; //enable first 2 bits only
	GPIO_PORTD_AHB_DIR_R  = ~(0x03); //set the first 2 to 0(means as input to the chip)

	//Enable Port K
	SYSCTL_RCGCGPIO_R |= 1<<9;//activate port K
	while((SYSCTL_RCGCGPIO_R & 1<<9) == 0); //wait until port K is activated
	GPIO_PORTK_DEN_R  = 0xFF; //enable all bits PK(7:0)
	GPIO_PORTK_DIR_R  = 0xFF; //set the PK(7:0) to the output of the chip

}

void displayValue(int SAR)
{
	unsigned long total, lasthalf;
	int waiter = 0;
	//display last 2 digits

	total=(int)(SAR * Ulsb);
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
	unsigned long SAR;

	configSys();

	while(1)
	{
		GPIO_PORTL_DATA_R &= ~(1<<2); //trigger pulse set to 0

		while((GPIO_PORTD_AHB_DATA_R & 0x02));//wait until the button is released

		GPIO_PORTL_DATA_R |= (1<<2); //trigger pulse set to 1
		SAR = 0x00;

		for(i = 7; i >= 0; i--)
		{
			SAR |= (1 << i);
			GPIO_PORTK_DATA_R = SAR;
			timerWait(300); //wait 30usec to stabilize Uout

			if(!(GPIO_PORTD_AHB_DATA_R & 0x01)) //comparator
			{
				SAR &= ~(1 << i);
			}
		}

		displayValue(SAR);
	}
}


