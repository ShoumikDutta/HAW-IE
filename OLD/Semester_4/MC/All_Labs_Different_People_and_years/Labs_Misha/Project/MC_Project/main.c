////////////////////////////////////////////////////////////////
//	MC_Lab4_6
//	Participants: 	Kulakov Mykhailo
//			Jeonghyun Son
//		 	Svhets  Volodymyr
////////////////////////////////////////////////////////////////

#include "tm4c1294ncpdt.h" // register names (macros)
#include "intHandlers.h"
#include "stdio.h"
#include <stdlib.h> // For random(), RAND_MAX
//#include "inc/hw_types.h" // required by sysctl.h
//#include "driverlib/sysctl.h" // required for SysCtlClockFreqSet

// global variables
volatile unsigned char gucNewData = 0;
volatile unsigned char gucRxChar = 0;
volatile unsigned char buttonPausePressed = 0;
volatile unsigned char startNewGame = 0;
volatile unsigned char endGame = 0;


unsigned int timerDelays[] = {
62270,    51570,    39320,    33190,    29370,    26710,    24740,    23210,
21980,    20970,    20130,    19420,    18810,    18290,    17830,    17430,
17080,    16770,    16500,    16270,    16060,    15880,    15730,    15590,
15480,    15390,    15320,    15260,    15230,    15210,    15200,    15220,
15250,    15300,    15360,    15450,    15550,    15680,    15830,    16000,
16190,    16420,    16680,    16970,    17310,    17690,    18130,    18630,
19210,    19880,    20680,    21620,    22770,    24190,    25990,    28380,
31740,    36890,    46260,    62520
};

unsigned char symbols[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						   0x00, 0x00, 0x00, 0x00, 0x00, 0x00}; // 60 elements

unsigned char arrayOfObstacles[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
								/*	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									0x00, 0x00, 0x00, 0x00, 0x00, 0x00};*/

unsigned char lose[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
							 0x7E, 0x81, 0x8B, 0x4E, 0x00, //G
							 0x7F, 0xC8, 0xC8, 0x7F, 0x00, //A
							 0x7F, 0x7E, 0x80, 0x7F, 0x00, //M
							 0xFF, 0x91, 0x91, 0x91, 0x00, //E
							 0x00, 0x00,
							 0xFE, 0x81, 0x81, 0x7E, 0x00, //O
							 0xFC, 0x03, 0x03, 0xFC, 0x00, //V
							 0xFF, 0x91, 0x91, 0x91, 0x00, //E
							 0xFF, 0x90, 0x98, 0x67, 0x00, //R
						 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

unsigned char win[] ={0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0xF8, 0xF7, 0x01, 0xFE, 0xF7, 0xF8, 0x00,//W
						0x81, 0xFF, 0x81, 0x00,//I
						0xFF, 0xC0, 0x70, 0x0E, 0xFF, 0x00,//N
						0xFD, 0xFD, //!
						0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

unsigned char pause[] =  {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
							0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
							0xFF, 0x90, 0x90, 0x60, 0x00, //P
                            0x7F, 0x90, 0x90, 0x7F, 0x00, //A
                            0xFE, 0x01, 0x01, 0xFE, 0x00, //U
                            0x62, 0x91, 0x91, 0x5E, 0x00,//S
                            0xFF, 0x91, 0x91, 0x91, 0x00,//E
							0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
							0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};


#define AR_SIZE  sizeof(symbols)/sizeof(symbols[0])
#define AR_OBST_SIZE sizeof(arrayOfObstacles)/sizeof(arrayOfObstacles[0])
//#define DELAY 4000
//#define SMALL_DELAY 1800

int isGameWin = 0; // -1 - LOSE, 1 - WIN
//default ball coordinates
int ballPosX = 30;
int ballPosY = 4;

void UARTConfig()
{
	int waitCycle = 0; //just for short delay

	// switch over to main quartz oscillator at 25MHz
	 // clear MOSC power down, high oscillator range setting, and no crystal present setting
	 SYSCTL_MOSCCTL_R &= ~(SYSCTL_MOSCCTL_OSCRNG | SYSCTL_MOSCCTL_PWRDN |SYSCTL_MOSCCTL_NOXTAL);
	 SYSCTL_MOSCCTL_R |= SYSCTL_MOSCCTL_OSCRNG;                             // increase the drive strength for MOSC
	 SYSCTL_RSCLKCFG_R = SYSCTL_RSCLKCFG_OSCSRC_MOSC;                    // set the main oscillator as main clock source

	 //initialize Port P
	SYSCTL_RCGCGPIO_R |= (1 << 13);
	while(!(SYSCTL_PRGPIO_R & (1 << 13)));
	GPIO_PORTP_DEN_R |= 0x01; //PP(0)
	GPIO_PORTP_DIR_R &= ~0x01; //PP(0) as input
	GPIO_PORTP_AFSEL_R |= 0x01; //PP(0)
	GPIO_PORTP_PCTL_R |=  0x01; //0x01000000;

	//intialize UART6 8N1 115200 bitrate
	SYSCTL_RCGCUART_R |= (1<<6); //switch clock on for UART 6
	while(!(SYSCTL_PRUART_R & (1<<6)));
	UART6_CTL_R &= ~0x0001;
	UART6_IBRD_R = 13;//162;//6;
	UART6_FBRD_R = 36;//49;//50;
	UART6_LCRH_R |= 0x060; // serial format 8N1
	UART6_CTL_R |= 0x001; //start UART6(+enable section 'enabled' -need?)

	// UART6 interrupts
	UART6_ICR_R = 0xFFF; // clear all interrupts
	UART6_IM_R = 1<<4; // activate UART6 Rx interrupts
	NVIC_EN1_R |= 1<<(59-32); // enable UART6 IRQ in NVIC(IRQ 59)
}

//pause/cont game button config
void configPortK(void) // PK(0):in+irq
{
	SYSCTL_RCGCGPIO_R |= (1<<9);
	while((SYSCTL_RCGCGPIO_R & (1<<9)) == 0);

	GPIO_PORTK_DEN_R |= 0x0001; // enable pins
	GPIO_PORTK_DIR_R |= ~(0x0001); // PortK(0) input
	GPIO_PORTK_IS_R  &= ~0x01; // sense to "edge-sensitive"
	GPIO_PORTK_IBE_R &= ~0x01; // trigger set to "single edge"
	GPIO_PORTK_IEV_R |= 0x01; // interrupt event to rising edge
	GPIO_PORTK_ICR_R |= 0x01; // clear interrupt PORTK(0)
	GPIO_PORTK_IM_R |= 0x01; // unmask PORTK(0) = pause/cont game button
	NVIC_EN1_R |= (1<<(52 - 32)); // enable PortK interrupt (Int#52/Vec#68) in NVIC
}
//end/start game button config
void configPortD(void) // PD(0):in+irq
{
	SYSCTL_RCGCGPIO_R |= (1<<3);
	while((SYSCTL_RCGCGPIO_R & (1<<3)) == 0);

	GPIO_PORTD_AHB_DEN_R |= 0x0001; // enable pins
	GPIO_PORTD_AHB_DIR_R |= ~(0x0001); // PortD(0) input
	GPIO_PORTD_AHB_IS_R  &= ~0x01; // sense to "edge-sensitive"
	GPIO_PORTD_AHB_IBE_R &= ~0x01; // trigger set to "single edge"
	GPIO_PORTD_AHB_IEV_R |= 0x01; // interrupt event to rising edge
	GPIO_PORTD_AHB_ICR_R |= 0x01; // clear interrupt PORTD(0)
	GPIO_PORTD_AHB_IM_R |= 0x01; // unmask PORTD(0) = end/start game button
	NVIC_EN0_R |= (1<<3); // enable Portd interrupt (Int#3/Vec#19) in NVIC
}

void dataPortsConfig(void)
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
	GPIO_PORTM_DATA_R  = 0x00;
}

//should represent TimerA0 settings -compare, count down, no capture
void timerConfig()
{
	// configure Timer 0
	SYSCTL_RCGCTIMER_R |= (1<<0); // timer 0
	while(!(SYSCTL_PRTIMER_R & (1<<0))); // wait for timer 0 activation
	TIMER0_CTL_R &= ~0x0001; // disable Timer 0A
	TIMER0_CFG_R = 0x04; // 2 x 16-bit mode

	// compare mode, down, periodic: TAMR=0x2 -no match value
	TIMER0_TAMR_R |= 1<<1; //last 8 bits: 0000 0010 = 0x02
						   //4th bit = counts down, 2nd bit = 0x02 - periodic

}

//make a delay of usec(up to 10ms)
void timerWait(unsigned short usec)
{
	timerConfig();
	TIMER0_TAILR_R = usec - 1; //load value
	TIMER0_TAMATCH_R = usec/2 - 1; //match value
	TIMER0_CTL_R |= 0x0001; //start Timer0A

	//wait for match value
	while((TIMER0_RIS_R & (1<<4)) == 0);
	TIMER0_ICR_R |= (1<<4);
	GPIO_PORTM_DATA_R = 0x00;//turn off LED at the match value

	while(!(TIMER0_RIS_R & 0x0001)); //flag set when 0x0000 reached(time-out)
		TIMER0_ICR_R |= 0x01; //clear TIMER0_RIS_R(0) bit
		TIMER0_CTL_R &= ~0x0001; //disable the Timer0A
}

//generate obstacles
void generateObstacles()
{
	int i, x;
	for(i = 0; i < AR_OBST_SIZE; i++)
	{
	  x = rand() % 12;
	  switch(x){
		case 0:
		  	arrayOfObstacles[i] = 0x03;
			break;
		case 1:
		  	arrayOfObstacles[i] = 0x07;
			break;
		case 2:
		  	arrayOfObstacles[i] = 0x0F;
			break;
		case 3:
		  	arrayOfObstacles[i] = 0x1F;
			break;
		case 4:
		  	arrayOfObstacles[i] = 0x3F;
			break;
		case 5:
		  	arrayOfObstacles[i] = 0x7F;
			break;
		case 6:
		  	arrayOfObstacles[i] = 0x30;
			break;
		case 7:
		  	arrayOfObstacles[i] = 0x70;
			break;
		case 8:
		  	arrayOfObstacles[i] = 0xF0;
			break;
		case 9:
		  	arrayOfObstacles[i] = 0xF8;
			break;
		case 10:
		  	arrayOfObstacles[i] = 0xFC;
			break;
		case 11:
		  	arrayOfObstacles[i] = 0xFE;
			break;
	  }
	}
}

void showDisplay()
{
	//int tempDelay = 0;
	int i = 0;
	//timerWait(DELAY);


	for(i = 0; i < AR_SIZE; i++)
	{
		if(buttonPausePressed && (isGameWin == 0)) //PAUSE the game
		{
			GPIO_PORTM_DATA_R = pause[i];
		}else if(isGameWin == 1) // game WIN !
		{
			GPIO_PORTM_DATA_R = win[i];
		}else if(isGameWin == -1 || endGame) //GAME OVER
		{
			GPIO_PORTM_DATA_R = lose[i];
		}else
		{
			if(i == ballPosX)
			{
				GPIO_PORTM_DATA_R = symbols[i] | (1 << ballPosY);
			}
			else
			{
				GPIO_PORTM_DATA_R = symbols[i];
			}
		}

		timerWait(timerDelays[i]);
	}
}

//shit obstacle to the right
void swap(int i)
{
	int temp;
	if(i < AR_SIZE - 1 && symbols[i + 1] == 0x00)
	{
		temp = symbols[i];
		symbols[i] = symbols[i+1];
		symbols[i+1] = temp;
	}
}

void shiftObstacleAndBall(int i)
{
	//swap(ballPosition++);
	if(ballPosX < AR_SIZE - 1)
	{
		ballPosX++;
	}
	if(i < AR_SIZE - 2)
	{
		swap(i);
	}
}

void moveObstacles()
{
	int i = 0;
	//char temp;

	for(i = 0; i <= AR_SIZE - 2; i++)
	{
		if((i == ballPosX - 1) && symbols[i] && (symbols[i] & (1 << ballPosY)))
		{
				shiftObstacleAndBall(i++);
		}
		else if(symbols[i])
		{
			swap(i++);
		}
	}

	//if obstacle reaches the right edge and there is no ball in front, it disappears

	    if(symbols[AR_SIZE - 1])
		{
			symbols[AR_SIZE - 1] = 0x00;
		}
}

void moveBall()
{
	//char temp;

	switch(gucRxChar){
		case 'w': //'w' was pressed  - move ball up - correct
			if(ballPosY < 7)
			{
				ballPosY++;
			}
		  	break;

		case 's': //'s' was pressed - move ball down - ok
			if(ballPosY > 0)
			{
				ballPosY--;
			}
			break;

		case 'a': // 'a' was pressed  - move ball to the left
			if(ballPosX > 0)
			{
				if(!(symbols[ballPosX - 1] & (1 << ballPosY)))
				{
					ballPosX--;
				}
			}
			break;

		case 'd': // 'd' was pressed - move ball to the right
			if(ballPosX < AR_SIZE - 1)
			{
				if(!(symbols[ballPosX + 1] & (1 << ballPosY)))
				{
					ballPosX++;
				}
			}
			break;
	}
}

void checkGameWin()
{
	int i;
	char isEmpty = 1;

	for(i = 0; i < AR_SIZE; i++)
	{
		if(symbols[i])
		{
			isEmpty = 0;
		}
	}

	if(isEmpty)
	{
		isGameWin = 1;
		endGame = 1;
	}
}

void checkGameLose()
{
	if((ballPosX == AR_SIZE - 1) && (symbols[ballPosX - 1] & (1 << ballPosY)))
	{
		isGameWin = -1;
	}
}


void main()
{
	generateObstacles();
	UARTConfig();
	configPortK();
	configPortD();
	dataPortsConfig();

	char edgeDetection = 0;
    char speed = 1;
    char counter = 0;
	char obstaclesCounter = 0;
	char delayBetweenObstacles = 0;

 while(1)
 {
		//left(rising) edge - show display only
		if((GPIO_PORTL_DATA_R & 0x01) && !edgeDetection)
		{
			counter++;
			edgeDetection = 1;
			showDisplay();
		}
		//right edge  - game analysis
		else if(!(GPIO_PORTL_DATA_R & 0x01) && edgeDetection)
		{
			edgeDetection = 0;
			if(gucNewData)
			{
				gucNewData = 0;
				moveBall();
			}

			if(counter > speed)
			{
				if(!(buttonPausePressed || isGameWin == 1 || isGameWin == -1 || endGame))
				{
					counter = 0;
					if(delayBetweenObstacles++ == 5) //distance between obstacles
					{
						delayBetweenObstacles = 0;
						if(ballPosX == 0)
						{
							ballPosX++;
						}
						if(obstaclesCounter < AR_OBST_SIZE)
						{
							symbols[0] = arrayOfObstacles[obstaclesCounter++];
						}
					}
					moveObstacles();
					checkGameLose();
					checkGameWin();
				}
				else if(startNewGame)
				{
					int i;
					endGame = 0;
					isGameWin = 0;
					startNewGame = 0;
					for(i = 0; i < AR_SIZE; i++)
					{
						if(symbols[i])
						{
							symbols[i] = 0x00;
						}
					}
					generateObstacles();
					edgeDetection = 0;
					speed = 5;
					counter = 0;
					obstaclesCounter = 0;
					delayBetweenObstacles = 0;
					ballPosX = 30;
					ballPosY = 4;
				}
			}
		}

 }
}


