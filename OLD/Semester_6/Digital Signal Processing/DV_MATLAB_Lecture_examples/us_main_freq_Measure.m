% us_MAIN_freq_measure.m, with slider
%
% calls "us_freq_measure.m"
%
% DSP_FFT.doc, slide 21
% US 31-Aug-04
clear
close('all');
figure(1);

disp(' N=256; % Try with N=32,64 (without noise); and with 128, 256, 1024 with noise');
N = inputs('N=256, try with N=32,64 (without noise); \n and with 128, 256, 1024 with noise',256);

ampl_signal = inputs('signal amplitude (0 if no noise desired)',0.33);
ampl_noise  = inputs('noise amplitude (0 if no noise desired)',0.66);

t = (0:N-1)';
% generate sinus signal with phase 0.37
Fs=8192;
freq=1000;
sig = sin(2*pi*freq/Fs*t+0.37);

noise = 2*(randn(size(sig))-0.5); % US generate a noise-vector of same length
x = ampl_signal*sig + ampl_noise*noise; % overlap scaled signal with dominant noise
% sound(x); % Output both channels to speakers
% wavwrite(x,FS,NBITS,'noisy.wav'); % save noisy-file on disk

subplot(4,1,1);
plot(t,x),grid %Plot the sine wave input
title('Noisy audio-input');
xlabel('Index'); ylabel('x(n)');

window = hamming(N);
x = x.*window; % Array multiplication: Noisy samples with Hamming-window

subplot(4,1,2)
plot(t,x),grid %Plot the windowed wave input
title('Windowed data');
xlabel('Index'); ylabel('x(n)');

% NO, US, 2-D, takes much time
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
plot(n2*Fs/N2,abs(X(n2+1))),grid %Plot the FFT magnitude
title('FFT Abs-Values');
xlabel('Frequency [Hz]'); ylabel('abs(X(f))');

h=uicontrol('style','slider','callback','us_freq_measure');


 