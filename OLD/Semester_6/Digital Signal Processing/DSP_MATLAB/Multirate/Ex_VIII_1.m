% Ex_VIII_1.m
% Example VIII 1)
% Interpolator /Decimator sequence with subsequent filter
clf;
% Set asymmetric bandlimited spectrum (0..0.25)
freq = [0 0.06 0.06+eps 0.25 1]; mag = [0 1 1 0 0]; 
x = fir2(511, freq, mag); % and use fir2 to create a bandlimited input sequence
% Evaluate and plot the input spectrum
[X, w] = freqz(x, 1, 512);
subplot(2,1,1);
%stem([0:length(x)-1],x);
plot(w/pi, abs(X)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Bandlimited input spectrum');
v1=down_sample(x,4);
[V1, w] = freqz(v1, 1, 512);
subplot(2,1,2);
%stem([0:length(v1)-1],v1);
plot(w/pi, abs(V1)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Downsampling by 4');
