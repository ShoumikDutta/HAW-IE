//---------------------------------------------------------------------
//--  File      bitrev.c
//
// bit-reversal routine, N_FFT_stages 3,4,5,.. 10 for 1024 length
//
// short bitrev(short in, N_FFT_stages);
//
// 16-Feb-12 : NOTE, we use N_FFT_stages, NOT N_FFT as 2nd parameter !!
short bitrev(short in, short N_FFT_stages)
{
	short in1=in, in2;
	short out=0;
	short kx;
	for (kx=0;kx<N_FFT_stages;kx++)
	{
		in2 = (in1/2);
		out=out*2+(in1-2*in2);
		in1=in2;
	}
	return out;
}
