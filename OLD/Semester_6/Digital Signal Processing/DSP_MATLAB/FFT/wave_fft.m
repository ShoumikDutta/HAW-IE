% wave_fft.m
% Calculates a 1024 pt fft from a wave-file
% The audio data will be superpositioned with noise.
% A Hamming window is applied before zeropadding.
% J.R.02.07.03

N = 256; % Try with N=32,64 (without noise); and with 128, 256, 1024 with noise
% But note that 1024 points really need computation time!

n = 0:N-1;
[wav,FS,NBITS]=wavread('1200_500Hz.wav',N);
l_ch = wav(:,1); % Use left channel only
noise = rand(size(l_ch)); % generate a noise-vector of same length
%x = l_ch; % without noise
x = 0.33*l_ch + 0.66*noise; % overlap scaled signal with dominant noise
% sound(x); % Output both channels to speakers
% wavwrite(x,FS,NBITS,'noisy.wav'); % save noisy-file on disk

subplot(3,1,1)
plot(n,x) %Plot the wave input
title('Noisy audio-input');
xlabel('Index'); ylabel('x(n)');

window = hamming(N);
x = x.*window; % Array multiplication: Noisy samples with Hamming-window

subplot(3,1,2)
plot(n,x) %Plot the windowed wave input
title('Windowed data');
xlabel('Index'); ylabel('x(n)');

xz = zeros(4*N-1); % create zeropadding matrix for 
xz(1:N) = x; % load input samples to the first N samples 
N2 = length(xz);
n2 = 0:N2/2-1; % FFT-output ranges from 0 to N/2 (which is pi)

X = fft(xz); % Do the FFT

subplot(3,1,3)
plot(n2*FS/N2,abs(X(n2+1))) %Plot the FFT magnitude
title('FFT Abs-Values');
xlabel('Frequency [Hz]'); ylabel('abs(X(f))');


