/* IIR-Filter Project: test1.h */
/* IIR-Filter spec: Fs= 8000, Filter-Type: BS, Approximation: ELLIP */
/* Passband [Hz] 1500 1800, Stopband [Hz] 1600 1700, Passband-Ripple 1dB, Stopband-Attenuation= 60dB */
#define STAGES 4 // Number of 2nd order stages  
/* Scale factor used: 32767 */
int b[STAGES][3]={   // bi0, bi1, bi2 
{   19531,    -9900,    19531},
{   41080,   -23802,    41080},
{   20816,    -9524,    20816},
{   45077,   -28265,    45077},
};
int a[STAGES][2]={   // ai1, ai2 
{   -6141,    24963},
{  -24642,    25577},
{  -10127,    31776},
{  -24498,    31837},
};
