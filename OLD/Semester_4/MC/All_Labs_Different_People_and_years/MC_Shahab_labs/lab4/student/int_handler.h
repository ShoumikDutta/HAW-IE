#ifndef SYSTICKHANDLER_H_

#define SYSTICKHANDLER_H_

#define on 1 // switch is on (high or low )

#define off 0

void IntPortEHandler(void);

extern  volatile unsigned char swap; // switch function

#endif
