%---------------------------------------------------------------------------
% wave_fft.m
% Calculates a 1024 pt fft from a wave-file
% The audio data will be superpositioned with noise.
% A Hamming window is applied _BEFORE_ zeropadding.
% J.R.02.07.03
% U.S. corrections marked with US, 31.8.04

clear
disp(' N=256; % Try with N=32,64 (without noise); and with 128, 256, 1024 with noise');
N = inputs('N=256, try with N=32,64 (without noise); \n and with 128, 256, 1024 with noise',256);
% But note that 1024 points really need computation time!
% NO, US, matrix xz below was 2-D !!

ampl_noise = inputs('noise amplitude (0 if no noise desired)',0.66);
n = 0:N-1;
[wav,FS,NBITS]=wavread('1200_500Hz.wav',N);
l_ch = wav(:,1); % Use left channel only
%noise = rand(size(l_ch)); % generate a noise-vector of same length
noise = 2*(rand(size(l_ch))-0.5); % US generate a noise-vector of same length
%x = l_ch; % without noise
x = 0.33*l_ch + ampl_noise*noise; % overlap scaled signal with dominant noise
% sound(x); % Output both channels to speakers
% wavwrite(x,FS,NBITS,'noisy.wav'); % save noisy-file on disk

close('all');
figure(1);
subplot(4,1,1)
plot(n,x),grid %Plot the wave input
title('Noisy audio-input');
xlabel('Index'); ylabel('x(n)');

window = hamming(N);
x = x.*window; % Array multiplication: Noisy samples with Hamming-window

subplot(4,1,2)
plot(n,x),grid %Plot the windowed wave input
title('Windowed data');
xlabel('Index'); ylabel('x(n)');

% NO, US, 2-D, takes much time
%xz = zeros(4*N-1); % create zeropadding matrix for 
xz = zeros(4*N-1,1); % create zeropadding matrix for 
xz(1:N) = x; % load input samples to the first N samples 

subplot(4,1,3)
plot(1:4*N-1,xz),grid %Plot the windowed and zero-padded wave input
title('Windowed data with padding');
xlabel('Index'); ylabel('x(n)');

N2 = length(xz);
n2 = 0:N2/2-1; % FFT-output ranges from 0 to N/2 (which is pi)
X = fft(xz); % Do the FFT

subplot(4,1,4)
plot(n2*FS/N2,abs(X(n2+1))),grid %Plot the FFT magnitude
title('FFT Abs-Values');
xlabel('Frequency [Hz]'); ylabel('abs(X(f))');