//-----------------------------------------------------------
// Digital Signal Processing Lab
// Testprogram read/write
//
// AIC23 version
//
// File: iir_LPHP.c
//
// Authors: Mohammad Adnan, Ievgenii Nudga, 11.06.2018
//
// version 1 : modified 27-Nov-08, Kup
// version 2 : 31-Jan-10, JR
//#define SIMULATOR
// for usage of input MIC_IN and output HEADPHONE with DC coupling:
//#define MIC_IN
#include "c6713dskinit.h" //codec-DSK support file
#include "dsk6713.h"
#include <math.h> //math library

#include "IIR_LP_el.h"
#include "IIR_LP_cheb1.h"

#define LEFT 1
#define RIGHT 0
#define BUFLEN 1000

#define N 2

// external beim DSK-Board, hier zu deklarieren fur Simulator:
#ifdef SIMULATOR
	MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#else
	extern MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#endif
	static Uint32 CODECEventId;
	Uint32 fs=DSK6713_AIC23_FREQ_8KHZ; //for sampling frequency
	//Uint32 fs; //for sampling frequency

short int x_n_el, x_n_cheb1;
short int i, y_n_el, y_n_cheb1;

int T1_el[2], T2_el[2], accu32_el; //2 - because we have two second-order sections (sos)
//for ellip we got in MATLAB a 4th-order IIR filter, so we have to split it into 2 sos
int T1_cheb1[3], T2_cheb1[3], accu32_ch1; //3 - because we have three second-order sections (sos)
//for cheb1 we got in MATLAB a 6th-order IIR filter, so we have to split it into 3 sos


int switch_filters = 1;
// int switch_filters = 2;
// int switch_filters = 3;

union
{
	Uint32 both;
	short channel[2];
} AIC23_data;

void ellip_LP()
{
	for(i = 0; i < N; i++)
	{
		accu32_el = num_IIR_LP_EL[3*i+0] * x_n_el + T1_el[i];
		y_n_el = (short) (accu32_el >> 15);
		T1_el[i] = num_IIR_LP_EL[3*i+1] * x_n_el - den_IIR_LP_EL[2*i+0]*y_n_el + T2_el[i];
		T2_el[i] = num_IIR_LP_EL[3*i+2] * x_n_el - den_IIR_LP_EL[2*i+1]*y_n_el;
		x_n_el = y_n_el;
	}
	AIC23_data.channel[LEFT] = y_n_el;
}


void cheb1_LP()
{
	for(i = 0; i < N + 1; i++)
	{
		accu32_ch1 = num_IIR_LP_CHEB1[3*i+0] * x_n_cheb1 + T1_cheb1[i];
		y_n_cheb1 = (short) (accu32_ch1 >> 15);
		T1_cheb1[i] = num_IIR_LP_CHEB1[3*i+1] * x_n_cheb1 - den_IIR_LP_CHEB1[2*i+0]*y_n_cheb1 + T2_cheb1[i];
		T2_cheb1[i] = num_IIR_LP_CHEB1[3*i+2] * x_n_cheb1 - den_IIR_LP_CHEB1[2*i+1]*y_n_cheb1;
		x_n_cheb1 = y_n_cheb1;
	}
	AIC23_data.channel[RIGHT] = y_n_cheb1;
}

interrupt void intser_McBSP1()
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input
	data
	// buffer monitoring input signal, reset count if BUFLEN is reached,
	// then input buffer is full
	x_n_el = AIC23_data.channel[LEFT];
	x_n_cheb1 = AIC23_data.channel[RIGHT];//maybe to the right?
	
	if(switch_filters == 1)
	{
		ellip_LP();
		cheb1_LP();
	}
	
	MCBSP_write(DSK6713_AIC23_DATAHANDLE, AIC23_data.both); //output 32 bit data, LEFT and RIGHT
	return;
}
///////////////////////////////////////////////////////////////////
void main()
{
	IRQ_globalDisable(); //disable interrupts
	#ifndef SIMULATOR
		DSK6713_init(); //call BSL to init DSKEMIF,PLL)
	#ifdef MIC_IN
		config.regs[4] = 0x14;
		config.regs[5] = 0x1;
	#endifhAIC23_handle=DSK6713_AIC23_openCodec(0,
		&config);//handle(pointer) to codec
		DSK6713_AIC23_setFreq(hAIC23_handle, fs); //set sample rate
	#else // Nur fur Simulator:
		DSK6713_AIC23_DATAHANDLE= MCBSP_open(MCBSP_DEV1, MCBSP_OPEN_RESET);
	#endif
		MCBSP_config(DSK6713_AIC23_DATAHANDLE,&AIC23CfgData);//interface 32 bits toAIC23
		
	MCBSP_start(DSK6713_AIC23_DATAHANDLE, MCBSP_XMIT_START | MCBSP_RCV_START | MCBSP_SRGR_START | MCBSP_SRGR_FRAMESYNC, 220);//start data channel again
	CODECEventId = MCBSP_getXmtEventId(DSK6713_AIC23_DATAHANDLE);//McBSP1 Xmit
	IRQ_map(CODECEventId, 5); //map McBSP1 Xmit to INT5
	IRQ_reset(CODECEventId); //reset codec INT5
	IRQ_globalEnable(); //globally enable interrupts
	IRQ_nmiEnable(); //enable NMI interrupt
	IRQ_enable(CODECEventId); //enable CODEC eventXmit INT5
	IRQ_set(CODECEventId); //manually start the first interrupt
	while(1); //infinite loop
}