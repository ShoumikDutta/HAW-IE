#include "inc/lm3s9b92.h" // register names (macros)
#include "int_handler.h"
#include "stdio.h"

// handler reads uart2 rx fifo and prints character
	void inthandleruart2 (void){
int j = 0;
		if (UART2_MIS_R & (1<<4)) // check if uart2 rx interrupt
 {
	 

 UART2_ICR_R |=(1<<4); // clear interrupt
	while(j < BUFFERLENGTH) { // loop while buffer not full
			while(UART2_FR_R & (1<<4)) // wait for Rx FIFO not empty
				;
			buffer[j]=UART2_DR_R; // read byte from UART2 data register
			if (buffer[j] == 0x04) {// break loop if "EOT" received
				buffer[j]=0x00; // console input for EOT = Strg+D
				break; // replace last element by \0 to terminate string
			}
			j++; // increment buffer index
		}
 
	gucNewData = 1;
 }
}
