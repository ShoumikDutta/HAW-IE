//-----------------------------------------------------------
// Digital Signal Processing  Lab
// FFT implementation in fixed-point arithmetic
//
// Filename : radix2.c
//
// Author Svg 31. Aug 2005
//
// Description:
// This function computes an 8-point FFT 
// stages is 3 !!!
// If DO_PRINT is enabled, the loop counters are displayed
//
// version 1 : checked 31.Aug. 05

#include <stdio.h>
extern void butterfly(short *p_xa, short *p_xb, short w1, short w2);

// We have x[2*N] data to be FFT-transformed
// x[0] is real, x[1] is imag sample. 
// For a real-valued sequence, imag samples are zero 

// For N=8: stages = 3.
// Stage 1, k=0: num_groups = 4 = N/2, numBFY_per_group = 1, BF_Span=1, BLK_Step = 2
// Stage 2, k=1: num_groups = 2 = N/4, numBFY_per_group = 2, BF_Span=2, BLK_Step = 4
// Stage 1, k=2: num_groups = 1 = N/8, numBFY_per_group = 4, BF_Span=4, BLK_Step = 8

void radix2(int N_FFT, short x[], short w_r[], short w_i[]){
	short k=0, t=0, j=0, stages;

	short BF_Span=1, BLK_Step=2;

	short *p_xa, *p_xb;
	short num_groups = N_FFT/2, numBFY_per_group = 1;
	short xb_ofs, x_step;
	short y_ofs;

// Number of stages is ld(N) = log10(N)/log10(2). 
// For N=8, stages = 3.
	stages = 3;
	
//---------- The (outer) k-loop is across THE STAGES ---------------
	for (k = 0; k < stages; k++){	
//---------- The middle) t-loop is across THE GROUPs ---------------
		for (t = 0; t < num_groups; t++) { 
// p_xa: ptr to UPPER butterfly input, real value
			p_xa = x; 
// current span, *2 because real and imag values are in ONE array x[2*N]
			xb_ofs = 2*BF_Span; 
// p_xb: ptr to LOWER butterfly input, real value
			p_xb = x + xb_ofs ;

// x_step : the distance to the NEXT butterfly in THIS stage, multiplied 
//          by loop variable "t"
// again *2 because real and imag values are in ONE array x[2*N]
 			x_step = t * 2*BLK_Step; 
 			
// adapt p_xa and p_xb according to the number of butterflies per group
			p_xa += x_step;
			p_xb += x_step;

//---------- The (inner) j-loop is across THE BUTTERFLIES ----------
			for (j=0; j < numBFY_per_group; j++){
				y_ofs = j*num_groups;
				butterfly( p_xa, p_xb, w_r[0 + y_ofs], w_i[0 + y_ofs]);
// adapt index
				p_xa  += 2;
				p_xb  += 2;
			} // j-loop ends

		} // t-loop ends

// update parameters
		num_groups >>= 1;
		numBFY_per_group <<= 1;
		BLK_Step <<= 1;
		BF_Span  <<= 1;

	} // k-loop ends
	for (i=0;i<2*N;i+=2) 
		if (x[i+1] < 0)
			printf("%3d %10hd - j%10hd\n", i, x[i], -x[i+1]);
		else
			printf("%3d %10hd + j%10hd\n", i, x[i], x[i+1]);
/*
*/
} // end of radix2-function
