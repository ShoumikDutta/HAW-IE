% hanning.m
% Demonstratres the construction of the Hanning Window
% hann contains a  Hann window of length K
% The hann-window is embedded into a zero-sequence of length N
% refs.: DSP-dft.doc, slide 22, M.Meyer p. 165, Grünigen p. 131
% J.R. 26.06.03 
% 
N=128;            % length of window
n=0:N-1;          % input sequence
K=16;
k=0:K-1;
hann =0.5*(1-cos(2*pi*k/(K-1)));
x=zeros(1,N);
x(N/2-K/2:N/2+K/2-1) = hann;

subplot(2,1,1)
stem(n, x); grid
title ('Input sequence')
xlabel('n'); ylabel('Amplitude')

X = fft(x); % Do the FFT
X = fftshift(X); % swap left and right part to force the peak into the middle

subplot(2,1,2)
plot(n, 20*log(abs(X))); grid
axis([0 N-1 -80 40]);
title ('Output sequence')
xlabel('\Omega'); ylabel('|X(\Omega)|')

