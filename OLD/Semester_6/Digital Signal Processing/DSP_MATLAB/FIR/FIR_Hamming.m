% FIR_Hamming.m
% Calculation of an FIR Filter using Hamming window.
% generates coeff.h file for C-code include
% Author: J. R 16.01.03; Source: N. Dahnoun

close all;
clear all;

fs = input(' Enter Sample frequency /Hz ');
fc = input(' Enter Cut-off frequency /Hz ');
N = input(' Enter ODD number of taps (coefficients) ');
% So the filter order (number of delay elements) is N-1
fcn = fc/fs;			% Normalise cut-off frequency
n = -((N-1)/2):((N-1)/2); % works fine for odd N	
n = n+(n==0)*eps; 			% avoiding division by zero

[h] = sin(n*2*pi*fcn)./(n*pi);		% generate sequence of ideal coefficients
[w] = 0.54 + 0.46*cos(2*pi*n/N);	% generate Hamming window function
d = h.*w;				% window the ideal coefficients
d2 = d.*2^15;				% coefficients in Q15-Format

[g,f] = freqz(d,1,512,fs);		% transform into frequency domain for plotting

figure(1)
plot(f,20*log10(abs(g)));		% plot transfer function
axis([0  fs/2 -70 10]);
title('Ideal Transfer Function');	

figure(2);
stem(d2);				% plot coefficient values
xlabel('Coefficient number');
ylabel ('Value');
title('Truncated Impulse Response');

r = input('Normalize Q15 coefficients power to 1 ? (y/n) ','s');
if r == 'y'
   factor = 32767. / sum(d2);
else
   factor = 1.;
end
d3 = d2 * factor;

filnam = fopen('fir_coeff.h', 'w');		% generate include-file
fprintf(filnam,'/* FIR-Filter spec: fs = %d, fc = %d, N = %d */\n', fs, fc, N);
fprintf(filnam,'#define N %d\n', N);
fprintf(filnam,'short h[N]={\n');
j = 0;
for i= 1:N;
   fprintf(filnam,' %8.0f', d3(i));
   j = j + 1;
   if j >7
      fprintf(filnam, '\n');
      j = 0;
   end
end
fprintf(filnam,'}\n');
fclose(filnam);

figure(3)
freqz(d,1,512,fs);		% use freqz to plot magnitude and phase response
axis([0  fs/2 -100 10]); 
title('Magnitude and Phase Response');	
