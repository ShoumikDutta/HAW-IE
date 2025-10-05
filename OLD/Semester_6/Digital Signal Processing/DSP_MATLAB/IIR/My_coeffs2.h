/* IIR-Filter Project: My_coeffs2.h */
/* IIR-Filter spec: Fs= 8000, Filter-Type: LP, Approximation: CHEB1 */
/* Passband [Hz] 1950, Stopband [Hz] 3000, Passband-Ripple 1.000000e-02dB, Stopband-Attenuation 40dB */
#define STAGES 3 // Number of 2nd order stages  
/* Scale factor used: 32768 */
short b[STAGES][3]={   // bi0, bi1, bi2 
{     868,     1736,      868},
{   32768,    65536,    32768},
{   32768,    65536,    32768},
};
short a[STAGES][2]={   // ai1, ai2 
{  -12929,     2879},
{   -3125,    11445},
{    6766,    24450},
};
