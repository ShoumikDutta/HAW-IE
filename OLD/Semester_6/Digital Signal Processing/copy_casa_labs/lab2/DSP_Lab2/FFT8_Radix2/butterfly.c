//-----------------------------------------------------------
// Digital Signal Processing  Lab
// FIR implementation in fixed-point arithmetic
//
// Filename : butterfly.c
//
// Author Svg 31. Aug 2005
//
// Description:
// This program computes the butterfly output signals IN PLACE
//
// *p_xa points to upper node of input, real part : x1
// *p_xb points to lower node of input, real part : x2
// *(p_xa+1) points to upper node of input, imag part : y1
// *(p_xb+1) points to lower node of input, imag part : y2
//
// Note : the cosine values are NEGATIVE !
//		w1 = -real(wk), w2 = imag(wk)
//
// version 1 : checked 31.Aug. 05
void butterfly(short *p_xa, short *p_xb, short w1, short w2){
	int xout_r1_temp;
	int xout_i1_temp;
	int xout_r2_temp;
	int xout_i2_temp;
	xout_r1_temp = (  *p_xa    << 15 ) - *p_xb * w1 - *(p_xb+1) * w2 ; // upper node, real part
	xout_i1_temp = (  *(p_xa+1)<< 15 ) + *p_xb * w2 - *(p_xb+1) * w1 ; // upper node, imaginary part
	xout_r2_temp = (  *p_xa    << 15 ) + *p_xb * w1 + *(p_xb+1) * w2 ; // lower node, real part
	xout_i2_temp = (  *(p_xa+1)<< 15 ) - *p_xb * w2 + *(p_xb+1) * w1 ; // lower node, imaginary part

	*p_xa     = (short) (xout_r1_temp>>16); //write four results back IN-PLACE
	*(p_xa+1) = (short) (xout_i1_temp>>16);
	*p_xb     = (short) (xout_r2_temp>>16);
	*(p_xb+1) = (short) (xout_i2_temp>>16);
}

