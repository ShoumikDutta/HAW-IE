//-----------------------------------------------------------
// Digital Signal Processing  Lab
// FFT implementation in fixed-point arithmetic
//
// Filename : FFT8_Radix2.c
//
// Author Svg 31. Aug 2005
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
#include "C6713dskinit.h"

#define N 8

//set sampling rate
//	Uint32 fs = DSK6713_AIC23_FREQ_8KHZ;	

	int N_FFT;
// in_buf contains data from ADC to be FFT-transformed
	short in_buf[N]; 

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

// the bit-reversed values for N=8 !!
	short index[] = {0, 4, 2, 6, 1, 5, 3, 7};

	void radix2(int, short *x, short *w_r, short *w_i);   // prototype

/****************************************************************************/
 
void main() {

	DSK6713_init(); // init DSK6713 without interrupts!
			// use ext. function comm_intr() for interrupts

	pi = 4*atan(1.);
// set N
	N_FFT = N;
	
// clear input buffer in_buf[N]
	for (i=0;i<N;i++)
		in_buf[i] = 0;
// clear FFT input buffer x[2*N]		
	for (i=0;i<2*N;i++)
		x[i] = 0;

// generate data to be FFT-transformed in input buffer
	in_buf[0] =  10000;
	in_buf[1] =     0;
	in_buf[2] = -10000;
	in_buf[3] =     0;
	in_buf[4] =  10000;
	in_buf[5] =     0;
	in_buf[6] = -10000;
	in_buf[7] =     0;

//----------------------------------------------------------------------
// copy input buffer bit-reversed (!!) to FFT buffer x[2*N]
// x[0,2,4,...] contains in_buf[] data, x[1,3,5,...] imag data are zero !
	for (i=0; i<N; i++)
		x[2*i] = in_buf[ index[i] ];

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
	
// print the SQUARE of the spectrum
	j = 0;
	for (i=0;i<2*N;i+=2) {
		if (x[i+1] < 0)
//			printf("|X(%2d)| : %10d, %10hd - j%10hd\n", i, out_buf[j], x[i], -x[i+1]);
			printf("%3d %8hd - j%8hd\n", i/2, x[i], -x[i+1]);

		else
//			printf("|X(%2d)| : %10d, %10hd + j%10hd\n", i, out_buf[j], x[i], x[i+1]);
			printf("%3d %8hd - j%8hd\n", i/2, x[i], -x[i+1]);
		j++;
	}
}
