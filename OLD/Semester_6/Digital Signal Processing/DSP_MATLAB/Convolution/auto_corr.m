% auto_corr.m
% version 14.8.03 / rch
% Computation of autocorrelation sequence for signal detection
%
L = 128;                  % Length of input signal
n = 0:L-1;
Omega=2*pi/L;
x1 = sin(5 * Omega * n);  % sin-signal 
x2 = randn(1,L);          % generate random sequence
x=  x1 + x2;
subplot(2,1,1);
stem(n,x);
title('Noisy input signal');

r = conv(x,fliplr(x));    % Autocorrelation

subplot(2,1,2);
k = (-length(r)/2) : length(r)/2-1;
stem(k,r);
title('Autocorrelation sequence');
xlabel('Lag index');
ylabel('Amplitude');
