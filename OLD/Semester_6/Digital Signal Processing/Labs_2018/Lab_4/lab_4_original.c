//-----------------------------------------------------------
// Digital Signal Processing Lab
// Testprogram read/write
//
// AIC23 version
//
// Filename : iir_LPHP.c
//
// Author Kulakov M, 11.05.2018
//
// version 1 : modified 27-Nov-08, Kup
// version 2 : 31-Jan-10, JR
//#define SIMULATOR
// for usage of input MIC_IN and output HEADPHONE with DC coupling:
//#define MIC_IN

#include "c6713dskinit.h" //codec-DSK support file
#include "dsk6713.h"
#include <math.h> //math library
#include "IIR_LP_ellip.h"
#include "IIR_LP_ellip_2T.h"
#include "IIR_HP_ellip.h"
#include "IIR_LP_cheb.h"

#define LEFT 1
#define RIGHT 0
#define BUFLEN 2

// external beim DSK-Board, hier zu deklarieren fⁿr Simulator:
#ifdef SIMULATOR
	MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#else
	extern MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#endif
	static Uint32 CODECEventId;
	Uint32 fs=DSK6713_AIC23_FREQ_8KHZ; //for sampling frequency
	//Uint32 fs; //for sampling frequency
// two buffers for input and output samples with two counters
short int inBuf_L[BUFLEN];
short int inBuf_L_cheb[BUFLEN];
short int inBuf_L_HP[BUFLEN];
short int inBuf_L_2T[BUFLEN];
short int inBuf_R[BUFLEN];
short int count=0, y_n = 0, y_n_cheb = 0, y_n_HP = 0, y_n_2T = 0;

int T1[2] = {0,0}, T2[2] = {0,0}, accu32;
int T1_cheb[3] = {0,0,0}, T2_cheb[3] = {0,0,0}, accu32_cheb;
int T1_HP[2] = {0,0}, T2_HP[2] = {0,0}, accu32_HP;
int T1_2T[2] = {0,0}, T2_2T[2] = {0,0}, T3_2T[2] = {0,0}, T4_2T[2] = {0,0}, accu32_2T;

int switch_filters = 2;

union
{
	Uint32 both;
	short channel[2];
} AIC23_data;

void elliptic_LP()
{
	//Elliptic filter
	for(count = 0; count < BUFLEN; count++)
	{
		accu32 = num_IIR_LP[3*count] * inBuf_L[0] + T1[count];
		y_n = (short) (accu32 >> 15);
		T1[count] = num_IIR_LP[3*count+1] * inBuf_L[0] - den_IIR_LP[2*count+0]*y_n + T2[count];
		T2[count] = num_IIR_LP[3*count+2] * inBuf_L[0] - den_IIR_LP[2*count+1]*y_n;
		inBuf_L[0] = y_n;
	}
	AIC23_data.channel[LEFT] = y_n;
}

void elliptic_LP_2T()
{
//Elliptic filter with 2T delays
	for(count = 0; count < BUFLEN; count++) 
	{
		accu32_2T = num_IIR_LP_2T[5*count] * inBuf_L_2T[0] + T1_2T[count];
		y_n_2T = (short) (accu32_2T >> 15);
		T1_2T[count] = num_IIR_LP_2T[5*count+1] * inBuf_L_2T[0] - den_IIR_LP_2T[4*count+0]*y_n_2T + T2_2T[count];
		T2_2T[count] = num_IIR_LP_2T[5*count+2] * inBuf_L_2T[0] - den_IIR_LP_2T[4*count+1]*y_n_2T + T3_2T[count];
		T3_2T[count] = num_IIR_LP_2T[5*count+3] * inBuf_L_2T[0] - den_IIR_LP_2T[4*count+2]*y_n_2T + T4_2T[count];
		T4_2T[count] = num_IIR_LP_2T[5*count+4] * inBuf_L_2T[0] - den_IIR_LP_2T[4*count+3]*y_n_2T;
		inBuf_L_2T[0] = y_n_2T;
	}
	AIC23_data.channel[RIGHT] = y_n_2T;
}
void elliptic_HP()
{
	//Elliptic filter
	for(count = 0; count < BUFLEN; count++)
	{
		accu32_HP = num_IIR_HP[3*count] * inBuf_L_HP[0] + T1_HP[count];
		y_n_HP = (short) (accu32_HP >> 15);
		T1_HP[count] = num_IIR_HP[3*count+1] * inBuf_L_HP[0] - den_IIR_HP[2*count+0]*y_n_HP + T2_HP[count];
		T2_HP[count] = num_IIR_HP[3*count+2] * inBuf_L_HP[0] - den_IIR_HP[2*count+1]*y_n_HP;
		inBuf_L_HP[0] = y_n_HP;
	}
	AIC23_data.channel[RIGHT] = y_n_HP;
}

void chebychev_LP()
{
	//Chebychev 1st order filter
	for(count = 0; count < BUFLEN + 1; count++)
	{
		accu32_cheb = num_IIR_LP_cheb[3*count] * inBuf_L_cheb[0] + T1_cheb[count];
		y_n_cheb = (short) (accu32_cheb >> 15);
		T1_cheb[count] = num_IIR_LP_cheb[3*count+1] * inBuf_L_cheb[0] - den_IIR_LP_cheb[2*count+0]*y_n_cheb + T2_cheb[count];
		T2_cheb[count] = num_IIR_LP_cheb[3*count+2] * inBuf_L_cheb[0] - den_IIR_LP_cheb[2*count+1]*y_n_cheb;
		inBuf_L_cheb[0] = y_n_cheb;
	}
	AIC23_data.channel[RIGHT] = y_n_cheb;
}

interrupt void intser_McBSP1()
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input
	data
	// buffer monitoring input signal, reset count if BUFLEN is reached,
	// then input buffer is full
	inBuf_L[0] = AIC23_data.channel[LEFT];
	inBuf_L_cheb[0] = AIC23_data.channel[LEFT];
	inBuf_L_HP[0] = AIC23_data.channel[LEFT];
	inBuf_L_2T[0] = AIC23_data.channel[LEFT];
	inBuf_R[count] = AIC23_data.channel[RIGHT];
	if(switch_filters == 0)
	{
		elliptic_LP();
		chebychev_LP();
	}
	else if (switch_filters == 1)
	{
		elliptic_LP();
		elliptic_HP();
	} else if (switch_filters == 2)
	{
		elliptic_LP();
		elliptic_LP_2T();
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
	#else // Nur fⁿr Simulator:
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