#include "inc/lm3s9b92.h"
 #include "int_handler.h"

void IntPortEHandler(void) 
{ 

GPIO_PORTE_ICR_R |= 0x0001; // clear interrupt source 

 if (GPIO_PORTE_DATA_R & 0x0001) // 
 { // check if switch is on or off 
	 if(swap == off){
		 swap = on;
	 }else{
		 swap = off;
	 }
 } 
}

