% us_freq_measure.m
%
% called from us_MAIN_freq_measure.m
%
% DSP_FFT.doc, slide 21
% US 31-Aug-04

freq = get(h,'value');
freq=freq*Fs/2;

% generate sinus signal with phase 0.37, use new freq. from slider !!
sig = sin(2*pi*freq/Fs*t+0.37);

noise = 2*(rand(size(sig))-0.5); % US generate a noise-vector of same length
x = ampl_signal*sig + ampl_noise*noise; % overlap scaled signal with dominant noise

subplot(4,1,1);
plot(t,x),grid %Plot the sine wave input
title('Noisy audio-input');
xlabel('Index'); ylabel('x(n)');

window = hamming(N);
window = blackman(N);
window = chebwin(N,60);
disp('chebwin has been applied');
x = x.*window; % Array multiplication: Noisy samples with Hamming-window

subplot(4,1,2)
plot(t,x),grid %Plot the windowed wave input
title('Windowed data');
xlabel('Index'); ylabel('x(n)');

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
xlabel(['input freq is ',num2str(freq)]); ylabel('abs(X(f))');

 