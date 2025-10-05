#ifndef SYSTICKHANDLER_H_

#define SYSTICKHANDLER_H_

#define on 1 // switch is on (high or low )

#define off 0

void IntPortEHandler(void);
void inthandleruart2 (void);

extern  volatile unsigned char swap; // switch function
extern  volatile unsigned char gucNewData; 
//extern  volatile unsigned char gucRxChar; 
extern  volatile unsigned char buffer[BUFFERLENGTH]; 



#endif
