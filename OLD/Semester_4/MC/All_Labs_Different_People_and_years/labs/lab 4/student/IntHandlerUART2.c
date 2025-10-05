#include "lm3s9b92.h"
#include "Int_handler.h"
#include "stdio.h"

void IntHandlerUART2(void){
	static int i = 0;	//index for the buffer

	if (UART2_MIS_R & (1 << 4)){
		UART2_ICR_R |= (1 << 4);
		if (i < 10){
			buffer[i] = UART2_DR_R;
			i++;
		}
		else {
			i = 0;
			buffer[i] = UART2_DR_R;
			i++;
		}
	}
}
/*		if (UART2_FR_R & (1 << 4)) // wait for Rx FIFO not empty
		{
			if (n == 10){		//avoid null pointer exception
				n = 0;
			}
			buffer[n] = UART2_DR_R; // read byte from UART2 data register
			if (buffer[n] == 0x04) {// break loop if "EOT" received
				buffer[n] = 0x00; // console input for EOT = Strg+D
				break; // replace last element by \0 to terminate string
			}
			n++; // increment buffer index
			printf("%s\n", buffer);
		}

*/
