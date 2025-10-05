/* IIR-Filter Project: My_coeffs.h */
/* IIR-Filter spec: Fs= 8000, Filter-Type: LP, Approximation: CHEB1 */
/* Passband [Hz] 2000, Stopband [Hz] 3000, Passband-Ripple 1.000000e-02dB, Stopband-Attenuation 40dB */
#define STAGES 3 // Number of 2nd order stages  
float b[STAGES][3]={   // bi0, bi1, bi2 
{0.029926, 0.059852, 0.029926},
{1.000000, 2.000000, 1.000000},
{1.000000, 2.000000, 1.000000},
};
float a[STAGES][2]={   // ai1, ai2 
{-0.354750, 0.081145},
{-0.042496, 0.348421},
{0.273982, 0.747366},
};
