//-----------------------------------------------------------
// Digital Signal Processing  Lab
// Testprogram read/write
//
// AIC23 version
//
// Filename : get_started.c
//
// Author Svg 8-Jan-07
//
// version 1 : modified 27-Nov-08, Kup
// version 2 : 31-Jan-10, JR


//#define SIMULATOR

// for usage of input MIC_IN and output HEADPHONE with DC coupling:
//#define MIC_IN





//-----------------------------------------------------------
// Digital Signal Processing  Lab
// FFT implementation in fixed-point arithmetic
//
// Filename : FFT64_Analyzer.c
//
// Author Svg 31. Aug 2005
// Modified by: Marco Casagrande- Julius Rauscher 25. Apr 2017
//
// Description:
// This program computes an 8-point FFT
//
// version 1 : checked 31.Aug. 05
// version 2 : adapted to DSK6713, Kup 25.10.06
// version 3 : adapted to DSK6713_MONET, Kup 01.03.07
// version 4 : adapted to DSK6713 board (AIC23), Kup 19.01.09

#include <stdio.h>
#include <math.h>
#include "dsk6713_aic23.h"		//codec-DSK support file
#include "dsk6713.h"		//codec-DSK support file
#include "C6713dskinit.h"

#define N 64


void fft_readix2();


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
	Uint32 fs=DSK6713_AIC23_FREQ_44KHZ;     //for sampling frequency
	//Uint32 fs;            			     //for sampling frequency

// two buffers for input and output samples with two counters
	short int inBuf_L[BUFLEN];
	short int inBuf_R[BUFLEN];
	short int count_INT=0;

	union {
		Uint32 both;
		short channel[2];
	} AIC23_data;


interrupt void intser_McBSP1()
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input data

// buffer monitoring input signal, reset count if BUFLEN is reached,
// then input buffer is full
	inBuf_L[count_INT] = AIC23_data.channel[LEFT];
	inBuf_R[count_INT] = AIC23_data.channel[RIGHT];

// buffer full ??
	count_INT++;
    if (count_INT >= BUFLEN)
    	count_INT = 0;

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





//set sampling rate
//	Uint32 fs = DSK6713_AIC23_FREQ_8KHZ;

	int N_FFT;
// in_buf contains data from ADC to be FFT-transformed


// x[2*N] contains the bit-reversed values of in_buf:
// x[2*N] data are stored as follows:
//      Xr + j*Xi = x[0] + j*x[1]
	short x[2*N]; // data are stored as follows: Xr + j*Xi = x[0] + j*x[1] ...

// out_buf contains the SQUARED spektrum :
// spektrum[0] = Xr[0]^2 + Xi[0]^2
	int out_buf[N];

// the wk's coefficients (cos() values and sin() values)
	short w_r[N/2], w_i[N/2]; // the real coeffs are in w_r[], imag coefs in w_i[]
	short i, j;

// Pi = 4*atan(1), computed in main()
	double pi;

// the bit-reversed values for N=64 !!
	// ---------------------------------------------------
	short index[] = {0, 32, 16, 48, 8, 40, 24, 56, 4, 36, 20, 52, 12, 44, 28, 60, 2, 34, 18, 50, 10, 42, 26, 58, 6, 38, 22, 54, 14, 46, 30, 62, 1, 33, 17, 49, 9, 41, 25, 57, 5, 37, 21, 53, 13, 45, 29, 61, 3, 35, 19, 51, 11, 43, 27, 59, 7, 39, 23, 55, 15, 47, 31, 63};
	// ---------------------------------------------------

	void radix2(int, short *x, short *w_r, short *w_i);   // prototype


void fft_readix2() {

			// use ext. function comm_intr() for interrupts

	pi = 4*atan(1.);
// set N
	N_FFT = N;


//----------------------------------------------------------------------
// copy input buffer bit-reversed (!!) to FFT buffer x[2*N]
	for (i=0; i<N; i++)
		x[2*i] = inBuf_L[ index[i] ];


// generate twiddle coefficients:
// Note : the cosine values have a NEGATIVE sign !!!!!
	for (i=0;i<N/2;i++) {
		w_r[i] = (short) (-32768 * cos(2*pi*i/N));
		w_i[i] = (short) (-32768 * sin(2*pi*i/N));
	}

// carry out the N-point FFT on array x[2*N] IN PLACE
	radix2(N_FFT, x, w_r, w_i);

// compute the SQUARE of the spectrum, result is in out_buf
    for (i=0;i<N;i++)
    	out_buf[i]= x[2*i] * x[2*i] + x[2*i+1] * x[2*i+1];


}

