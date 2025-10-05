//int_handler.h
#include "bitmap.h"

#define TRUE 1
#define FALSE 0
#define DISPLAYLENGTH 60
#define BUFFERLENGTH 10

void IntPortPHandler(void);
void IntHandlerUART2 (void);
void setMap(void);

extern unsigned char Inverted;
extern char text[BUFFERLENGTH];
extern unsigned char map[DISPLAYLENGTH];
extern short charCount;
