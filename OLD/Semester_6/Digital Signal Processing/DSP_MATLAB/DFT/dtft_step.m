% dtft_step.m
% Calculates the DFT and DTFT of N step input samples
% The first and last M-points are one.
% - In one-sided signals all other points are zero
% - In symmetric inputs also the last M points are ones
% Applications: dft.doc slide 8, slide 10
% J.R. 23.06.03 
N = input( 'Number of points in input sequence = ');
M = input('Max-index for ones = ');
n = 0 : N-1;
x = zeros(1,N);
x(1 : M+1) = ones(1,M+1);
Type = input('One-Sided (1) or symmetric (0) input? Enter (0/1)');
if (Type == 0)
  x(N-M : N) = ones(1,M+1);
end

subplot(3,2,1)
stem(n, x); grid
title ('Input sequence')
xlabel('n'); ylabel('x[n]')

X = fft(x,N);

subplot(3,2,2)
stem(n, abs(X)); grid
title ('DFT-Output')
xlabel('n'); ylabel('|(X[k]|')

[X,W] = dtft (x,N); % call the dtft function

subplot(3,2,3)
plot(W/2/pi, abs(X)); grid
title ('DTFT-Output')
xlabel('\omega/2*\pi'); ylabel('|(X[\omega]|')

subplot(3,2,4)
plot(W/2/pi, real(X)); grid
xlabel('\omega/2*\pi'); ylabel('Re(X(\omega))')

subplot(3,2,5)
plot(W/2/pi, imag(X)); grid
xlabel('\omega/2*\pi'); ylabel('Im(X(\omega))')
