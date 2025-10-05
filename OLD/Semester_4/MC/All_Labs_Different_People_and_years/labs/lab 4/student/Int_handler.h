#define NORMAL  0
#define INVERTED 1

void IntHandlerUART2(void);
void IntHandlerPortH(void);

extern char buffer[10];
extern unsigned char isInverted;
