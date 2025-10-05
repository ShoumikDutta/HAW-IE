% zeropadding.m
% Demonstartion der Eigenschaften des Zeropaddings bei euiner cos-Folge
% ref.: M. Werner S. 64
% J.R. 25.06.03 
% 
N=64;             % ursprüngliche Länge der Folge
n=0:N-1;          % length of input sequence
k=0:(N/2-1);      % length of output sequence
Omega=12.5*2*pi/N;% normalized signal frequency
x=cos(Omega*n);     

X = fft (x);

subplot(3,1,1)
plot(n, x); grid
title ('Input sequence')
xlabel('n'); ylabel('Amplitude')

subplot(3,1,2)
stem(k, abs(X(1:N/2))); grid
title ('Output sequence for L= 64')
xlabel('k'); ylabel('|X(k)|')

% Now with zeropadding:
N2=2*N;            % Double the length of the window
n=0:N2-1;          % length of input sequence
k=0:(N2/2-1);      % length of output sequence
x = [x , zeros(1,N)];

X = fft (x);

subplot(3,1,3)
stem(k, abs(X(1:N2/2))); grid
title ('Output sequence for L= 128')
xlabel('k'); ylabel('|X(k)|')




