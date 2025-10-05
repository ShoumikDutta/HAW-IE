/*****************************************************
  FFT_LAB_Analyser_Radix2_starter_version_NFFT_8.c
 
  US 29-Feb-2011

  This is the starter version for Lab 2 IE6 SP.

  Description:
  ============
  This program demonstrates the FFT TI CCS.
  The routine FFT is called in main() ONCE.
  
  An important requirement for cfftr2_dit.sa is CORRECT data alignment..  
  The pragmas used below make sure that data are aligned correctly
  in memory. 
  

*****************************************************/

//#define SIM

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "c6713dskinit.h"		//codec-DSK support file
#include "dsk6713_aic23.h"
#include "dsk6713.h"
Uint32 fs=DSK6713_AIC23_FREQ_8KHZ; //set sampling rate

//-------------------------------------------------------------------------
#define N_FFT 8
#define LEFT 1
#define RIGHT 0

float x1[2*N_FFT];
float w[N_FFT];
#pragma DATA_ALIGN(w, 2*sizeof(float))   //align w on boundary 
#pragma DATA_ALIGN(x1, 2*sizeof(float))	//align input x1 on boundary
//------------ prototypes -------------------------------------------------------------
short bitrev(short in, short N_FFT_stages);
void cfftr2_dit( float *x, const float *w, short N);

//Global variables:
	short i;
	short j;
	short indx;
	double PI;
	short index[N_FFT];
	short FFT_sample_count = 0;
	float out_buf[N_FFT];
	float float_scale = 0;
	short count_INT = 0;

#ifdef SIM
// provide for simulator
interrupt void intser_McBSP1() 
{
}
#else
	extern MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
	static Uint32 CODECEventId;
	
union {
	Uint32 both; 
	short channel[2];
} AIC23_data;

interrupt void intser_McBSP1() 
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); // input data
	MCBSP_write(DSK6713_AIC23_DATAHANDLE, AIC23_data.both); // output 32 bit LEFT and RIGHT
	return;
}
#endif

void main()
{
// calculate PI
	PI = 4 * atan(1);
	float_scale = (32768.*32768.* N_FFT);

#ifndef SIM
	IRQ_globalDisable();           	//disable interrupts
	DSK6713_init();                 // call BSL to init DSK-EMIF,PLL
#endif
// generate bit-reversed indicees, log10(N_FFT)/log10(2) is number of stages
	for (i=0;i<N_FFT;i++)
		index[i] = bitrev(i, log10(N_FFT)/log10(2));

// generate signel with 8 sampels, MUST BE in normal order !!
	for (i=0;i<N_FFT;i++) {
		x1[2*i] = (float) ( 8192 * cos(2*PI*2*i/N_FFT) );//+ 
		x1[2*i+1] = 0;
	}

// generate twiddle factors, MUST BE bit-reversed, sin() must be POSITIVE  !!
	j=0;
	for (i=0;i<N_FFT/2;i++) {
		w[index[j]  ] = (float)  +cos(2*PI*i/N_FFT);
		w[index[j]+1] = (float)  +sin(2*PI*i/N_FFT); // +sin() is CORRECT !!
		j++;
	}

// calculate FFT via assembler routine
	cfftr2_dit( x1, w, N_FFT);
	j=0;
    for (i=0;i<2*N_FFT;i+=2) 
    {
		indx = 2*index[j];
	 	out_buf[j]= (	(x1[indx]   * x1[indx] + 
	 					 x1[indx+1] * x1[indx+1])) / float_scale;
	 	j++;
	}

#ifndef SIM
// handle(pointer) to codec
	hAIC23_handle=DSK6713_AIC23_openCodec(0, &config);
	DSK6713_AIC23_setFreq(hAIC23_handle, fs);  //set sample rate

//interface 32 bits to AIC23
	MCBSP_config(DSK6713_AIC23_DATAHANDLE,&AIC23CfgData);

//start data channel 
	MCBSP_start(DSK6713_AIC23_DATAHANDLE, MCBSP_XMIT_START | MCBSP_RCV_START |
		MCBSP_SRGR_START | MCBSP_SRGR_FRAMESYNC, 220);

	CODECEventId= MCBSP_getXmtEventId(DSK6713_AIC23_DATAHANDLE);//McBSP1 Xmit
	IRQ_map(CODECEventId, 5);		//map McBSP1 Xmit to INT5
	IRQ_reset(CODECEventId);    	//reset codec INT5
	IRQ_globalEnable();       		//globally enable interrupts
	IRQ_nmiEnable();          		//enable NMI interrupt
	IRQ_enable(CODECEventId);		//enable CODEC eventXmit INT5
	IRQ_set(CODECEventId);			//manually start the first interrupt
#endif

//--------------------------------------------------------------------------  		
// put your code for buffer handling of spectrum analyser into while(1)-loop
	while(1)
	{
  	} // end of while(1) loop ...
//--------------------------------------------------------------  		

} // end of main()
