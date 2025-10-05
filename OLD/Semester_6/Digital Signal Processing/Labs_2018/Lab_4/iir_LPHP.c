//-----------------------------------------------------------
// Digital Signal Processing  Lab
// Testprogram read/write
//
// AIC23 version
//
// Filename : get_started.c
// Authors: Mohammad Adnan, Ievgenii Nudga, 11.06.2018
//
// Author Svg 8-Jan-07
//
// version 1 : modified 27-Nov-08, Kup
// version 2 : 31-Jan-10, JR
//#define SIMULATOR
// for usage of input MIC_IN and output HEADPHONE with DC coupling: 
//#define MIC_IN

#include "c6713dskinit.h"		//codec-DSK support file
#include "dsk6713.h"
#include <math.h>				//math library
#include "IIR_ellip_LP.h"
#include "IIR_LP_ellip_cheby1.h"
#include "IIR_ellip_HP.h"

#define LEFT 1
#define RIGHT 0
#define BUFLEN 1000

//  external beim DSK-Board, hier zu deklarieren für Simulator:
#ifdef SIMULATOR
	MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#else
	extern MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#endif

	static Uint32 CODECEventId;
	Uint32 fs=DSK6713_AIC23_FREQ_8KHZ;     //for sampling frequency
	//Uint32 fs;            			     //for sampling frequency

	short int x_n_el, x_n_cheb1;
	short int i, y_n_el, y_n_cheb1;

	//int T1_el[NO_OF_ROWS_LP_ELLIP], T2_el[NO_OF_ROWS_LP_ELLIP], accu32_el;
	int T1_el[NO_OF_ROWS_LP_ELLIP], T2_el[NO_OF_ROWS_LP_ELLIP],  T3_el[NO_OF_ROWS_LP_ELLIP], T4_el[NO_OF_ROWS_LP_ELLIP] , accu32_el;
	int T1_cheb1[NO_OF_ROWS_CHEBY1], T2_cheb1[NO_OF_ROWS_CHEBY1],  T3_cheb1[NO_OF_ROWS_CHEBY1], T4_cheb1[NO_OF_ROWS_CHEBY1],accu32_ch1;


	int switch_filters = 1;
	// int switch_filters = 2;

	union {
		Uint32 both; 
		short channel[2];
	} AIC23_data;

	void ellip_LP()
	{
		for(i = 0; i < NO_OF_ROWS_LP_ELLIP; i++)
		{
			accu32_el = sos_iir_lp_ellip[6*i+0] * x_n_el + T1_el[i];
			y_n_el = (short) (accu32_el >> 15);
			T1_el[i] = sos_iir_lp_ellip[6*i+1] * x_n_el - sos_iir_lp_ellip[6*i+4]*y_n_el + T2_el[i];
			T2_el[i] = sos_iir_lp_ellip[6*i+2] * x_n_el - sos_iir_lp_ellip[6*i+5]*y_n_el;
			x_n_el = y_n_el;
		}
		AIC23_data.channel[LEFT] = y_n_el;
	}

	void ellip_HP()
	{
		for(i = 0; i < NO_OF_ROWS_HP_ELLIP; i++)
		{
			accu32_el = sos_iir_hp_ellip[6*i+0] * x_n_el + T1_el[i];
			y_n_el = (short) (accu32_el >> 15);
			T1_el[i] = sos_iir_hp_ellip[6*i+1] * x_n_el - sos_iir_hp_ellip[6*i+4]*y_n_el + T2_el[i];
			T2_el[i] = sos_iir_hp_ellip[6*i+2] * x_n_el - sos_iir_hp_ellip[6*i+5]*y_n_el;
			x_n_el = y_n_el;
		}
		AIC23_data.channel[LEFT] = y_n_el;
	}


	void cheb1_LP()
	{
		for(i = 0; i < NO_OF_ROWS_CHEBY1; i++)
		{
			accu32_ch1 = sos_iir_lp_cheby1[6*i+0] * x_n_cheb1 + T1_cheb1[i];
			y_n_cheb1 = (short) (accu32_ch1 >> 15);
			T1_cheb1[i] = sos_iir_lp_cheby1[6*i+1] * x_n_cheb1 - sos_iir_lp_cheby1[6*i+4]*y_n_cheb1 + T2_cheb1[i];
			T2_cheb1[i] = sos_iir_lp_cheby1[6*i+2] * x_n_cheb1 - sos_iir_lp_cheby1[6*i+5]*y_n_cheb1;
			x_n_cheb1 = y_n_cheb1;
		}
		AIC23_data.channel[RIGHT] = y_n_cheb1;
	}
	void ellip_LP_2T()
	{
		for(i = 0; i < NO_OF_ROWS_LP_ELLIP; i++)
		{
			accu32_el = sos_iir_lp_ellip[6*i+0] * x_n_el + T1_el[i];
			y_n_el = (short) (accu32_el >> 15);
			T1_el[i] = T3_el[i];
			T3_el[i] = sos_iir_lp_ellip[6*i+1] * x_n_el - sos_iir_lp_ellip[6*i+4]*y_n_el + T2_el[i];
			T2_el[i] = T4_el[i];
			T4_el[i] = sos_iir_lp_ellip[6*i+2] * x_n_el - sos_iir_lp_ellip[6*i+5]*y_n_el;
			x_n_el = y_n_el;
		}
		AIC23_data.channel[LEFT] = y_n_el;
	}

interrupt void intser_McBSP1() 
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input data
// buffer monitoring input signal, reset count if BUFLEN is reached, 
// then input buffer is full
	x_n_el = AIC23_data.channel[LEFT];
	x_n_cheb1 = AIC23_data.channel[RIGHT];

	if(switch_filters == 1)
	{
		//ellip_LP();
		//cheb1_LP();
		//ellip_HP();
		ellip_LP_2T();
	}
	MCBSP_write(DSK6713_AIC23_DATAHANDLE, AIC23_data.both);   //output 32 bit data, LEFT and RIGHT 
	return;
}
///////////////////////////////////////////////////////////////////

void main()
{
	IRQ_globalDisable();           		//disable interrupts

#ifndef SIMULATOR
	DSK6713_init();                   	//call BSL to init DSK-EMIF,PLL)
#ifdef MIC_IN
	config.regs[4] = 0x14;
	config.regs[5] = 0x1;
#endif

	hAIC23_handle=DSK6713_AIC23_openCodec(0, &config);//handle(pointer) to codec
	DSK6713_AIC23_setFreq(hAIC23_handle, fs);  //set sample rate

#else	// Nur für Simulator:
    DSK6713_AIC23_DATAHANDLE= MCBSP_open(MCBSP_DEV1, MCBSP_OPEN_RESET);
#endif

	MCBSP_config(DSK6713_AIC23_DATAHANDLE,&AIC23CfgData);//interface 32 bits toAIC23

	MCBSP_start(DSK6713_AIC23_DATAHANDLE, MCBSP_XMIT_START | MCBSP_RCV_START |
		MCBSP_SRGR_START | MCBSP_SRGR_FRAMESYNC, 220);//start data channel again

	CODECEventId= MCBSP_getXmtEventId(DSK6713_AIC23_DATAHANDLE);//McBSP1 Xmit


	IRQ_map(CODECEventId, 5);			//map McBSP1 Xmit to INT5
	IRQ_reset(CODECEventId);    		//reset codec INT5
	IRQ_globalEnable();       			//globally enable interrupts
	IRQ_nmiEnable();          			//enable NMI interrupt
	IRQ_enable(CODECEventId);			//enable CODEC eventXmit INT5
	IRQ_set(CODECEventId);              //manually start the first interrupt


    while(1);                	        //infinite loop
}
 
