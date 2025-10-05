% leakage.m
% Demonstration of leakage
% ref.: DSP-dft.doc, slide 8
% J.R. 25.06.03 
% 
N=32;             % length of window
n=0:N-1;          % input sequence
k=0:(N/2-1);      % length of output sequence
Omega=8*2*pi/N;   % 8 kHz input frequency
x=sin(Omega*n);     

subplot(4,1,1)
plot(n, x); grid
title ('Input sequence')
xlabel('n'); ylabel('Amplitude')

X = fft (x);

subplot(4,1,2)
stem(k, abs(X(1:N/2))); grid
title ('Output sequence for f=8kHz')
xlabel('k'); ylabel('|X(k)|')

Omega=8.5*2*pi/N;  % 8.5 kHz input frequency
x=sin(Omega*n);     

X = fft (x);

subplot(4,1,3)
stem(k, abs(X(1:N/2))); grid
title ('Output sequence for f=8.5kHz')
xlabel('k'); ylabel('|X(k)|')

Omega=8.75*2*pi/N;  % 8.75 kHz input frequency
x=sin(Omega*n);

X = fft (x);

subplot(4,1,4)
stem(k, abs(X(1:N/2))); grid
title ('Output sequence for f=8.5kHz')
xlabel('k'); ylabel('|X(k)|')
