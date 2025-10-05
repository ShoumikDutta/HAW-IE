/*
 * intHandlers.h
 *
 *  Created on: 14.06.2017
 *      Author: mpp
 */

#ifndef INTHANDLERS_H_
#define INTHANDLERS_H_

void IntHandlerUART6 (void);
void IntPortK0Handler (void);
void IntPortD0Handler (void);

// global variables
extern volatile unsigned char gucNewData;
extern volatile unsigned char gucRxChar;
extern volatile unsigned char buttonPausePressed;
extern volatile unsigned char startNewGame;
extern volatile unsigned char endGame;

#endif /* INTHANDLERS_H_ */
