% IIR_LP.m
% LP-filter design using "manual" bilinear z-transform
% Example from N.Dahnoun to be used in module 12, slide 15

Fs = input('Sample Frequency / Hz: ');
Fc = input('Cutoff Frequency / Hz: ');
a   = tan(pi*Fc/Fs)
b   = (1 + 2^0.5*a + (a*a))
b00 = (a*a)/b
b01 = 2*b00
b02 = b00
a01 = 2*(a^2 -1)/b
a02 = (1 + a^2 - (2^0.5)*a)/b

bb  = [b00 b01 b02] * 32767;
aa  = [1 a01 a02] * 32767;

figure(1)
freqz(bb,aa,512,Fs)

fid = fopen('C:\TEMP\IIR_coef_Q15.h', 'wt');
    fprintf(fid,'b0=%5.0f,  b1=%5.0f,  b2=%5.0f\n',bb);
    fprintf(fid,'a0=%5.0f,  a1=%5.0f,  a2=%5.0f\n',aa);
fclose(fid);








