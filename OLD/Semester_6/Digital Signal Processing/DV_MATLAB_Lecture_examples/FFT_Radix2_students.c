// FILE 1:

/*****************************************************
* FFT_Radix2_students.c
* US : 08. Aug 2005/ 24-Apr-06
* 
* Description:
* ============
* This program demonstrates the FFT for MSVC

*****************************************************/
#include <stdio.h>
#include <math.h>
//-------------------------------------------------------------------------
// FFT_Radix2.c variables:
#define N 8
short x_br[N];
short x[2*N]; // Xr + j*Xi = x[0] + j*x[1] ...
short w_r[N/2], w_i[N/2];
	
//-------------------------------------------------------------------------

// External functions:
extern void butterfly(short *p_xa, short *p_xb, short w1, short w2);
extern void radix2(int , short x[], short w_r[], short w_i[]);


//Global variables:
short int count=0;

short i;
double pi = 3.1415926536;

void main()
{
	for (i=0;i<N;i++)
		x_br[i] = 0;
	for (i=0;i<2*N;i++)
		x[i] = 0;
	for (i=0;i<N;i++) {
//		x_br[i] = (short) rand()/32767;//sin(2*pi*2*i/N);
//		x_br[i] = (short) (2048 * sin(2*pi*2*i/N)+sin(2*pi*1*i/N));
//		x_br[i] = (short) ( 2048 * cos(2*pi*1*i/N) + 2048 * sin(2*pi*3*i/N) );
//		x_br[i] = (short) (8192 * cos(2*pi*1*i/N) )+ (short) (8192 * sin(2*pi*1*i/N));
		x_br[i] = (short) (8192 * sin(2*pi*2*i/N) );
	}
	x[0] = x_br[0];
	x[2] = x_br[4];
	x[4] = x_br[2];
	x[6] = x_br[6];
	x[8] = x_br[1];
	x[10] = x_br[5];
	x[12] = x_br[3];
	x[14] = x_br[7];


	for (i=0;i<N/2;i++) {
		w_r[i] = (short) (-32768 * cos(2*pi*i/N));
		w_i[i] = (short) (-32768 * sin(2*pi*i/N));
	}


	radix2(8, x, w_r, w_i);	
}