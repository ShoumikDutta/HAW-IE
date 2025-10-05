////////////////////////////////////////////////////////////////
//	MC_Lab2
//	Participants: Kulakov Mykhailo
//				  Svhets  Volodymyr
////////////////////////////////////////////////////////////////
#include "tm4c1294ncpdt.h"
#include "stdio.h"


unsigned char symbols[] =  {0x00, 0x7F, 0x90, 0x90, 0x90, 0x7F,
						 0x00, 0xFF, 0x90, 0x90, 0x90, 0xF0,
						 0x00, 0xFF, 0x90, 0x90, 0x90, 0xF0,
						 0x00, 0xFF, 0x01, 0x01, 0x01, 0x01,
						 0x00, 0xFF, 0x91, 0x91, 0x91, 0x91, 0x00}; //APPLE

#define AR_SIZE  sizeof(symbols)/sizeof(symbols[0])
#define DELAY 4000
#define SMALL_DELAY 1800

//should represent TimerA0 settings -compare, count down, no capture
void timerConfig()
{
	// configure Timer 0
	SYSCTL_RCGCTIMER_R |= (1<<0); // timer 0
	while(!(SYSCTL_PRTIMER_R & (1<<0))); // wait for timer 0 activation
	TIMER0_CTL_R &= ~0x0001; // disable Timer 0
	TIMER0_CFG_R = 0x04; // 2 x 16-bit mode

	// compare mode, down, periodic: TAMR=0x2 -no match value
	TIMER0_TAMR_R |= 1<<1; //last 8 bits: 0000 0010
						   //4th bit = counts down, 2nd bit = 0x02 - periodic

}

//make a delay of usec(up to 10ms) - check if the problem is here?
void timerWait(unsigned short usec)
{
	timerConfig();

	long pre = 3;//ceil((fCPU / pow(2.0, 16)) * 0.01); //prescaler Tmax = 10ms

	TIMER0_TAPR_R = pre - 1;
	TIMER0_TAILR_R = 16/pre * usec - 1; //0.5? probably needs also rounding //ceil((fCPU / pre) * (double)usec * pow(10.0, -6)) - 1; //load value
	TIMER0_CTL_R |= 0x0001; //start TImer0A

	while(!(TIMER0_RIS_R & 0x0001)); //flag set when 0x0000 reached(time-out)
	TIMER0_ICR_R |= 0x01; //clear TIMER0_RIS_R(0) bit
	TIMER0_CTL_R &= ~0x0001; //disable the Timer0A

}

void main()
{

	// Port  Clock Gating Control
	SYSCTL_RCGCGPIO_R |= 0x800;	    				// Port M clock ini
    while ((SYSCTL_PRGPIO_R & 0x00000800) == 0);		// Port M ready ?

    // Digital enable
	GPIO_PORTM_DEN_R = 0xFF; //M(7:0) port enable
    // Set direction
	GPIO_PORTM_DIR_R = 0xFF;  //(7:0) symbols output of the chip

	//Lab2 task 1 - catch rising & falling edges
	SYSCTL_RCGCGPIO_R |= 1<<10;//activate port L
	while((SYSCTL_RCGCGPIO_R & 1<<10) == 0); //wait until port L is activated
	GPIO_PORTL_DEN_R  = 0x01; //enable first bit only
	GPIO_PORTL_DIR_R  = ~(1<<0); //set the first to 0(means as input to chip)

	char edgeDetection = 0;
    int i = 0;

	timerConfig();

	while(1)
	{
		//left(rising) edge
		if((GPIO_PORTL_DATA_R & 0x01) && !edgeDetection)
		{
			edgeDetection = 1;
			timerWait(DELAY);

			for(i = 0; i < AR_SIZE; i++)
			{
				GPIO_PORTM_DATA_R = symbols[i];
				timerWait(SMALL_DELAY);
			}
		}
		else if(!(GPIO_PORTL_DATA_R & 0x01) && edgeDetection)
		{
			edgeDetection = 0;
			timerWait(DELAY);
				for(i = AR_SIZE - 1; i >=0; i--)
						{
							GPIO_PORTM_DATA_R = symbols[i];
							timerWait(SMALL_DELAY);
						}
		}
	}
}


