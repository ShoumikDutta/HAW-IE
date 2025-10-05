% Ex_VIII_3.m
% Example VIII 3)
% Interpolator /Decimator sequence with subsequent filter
clf;
freq = [0 1/3 2/3 2/3+eps 1]; mag = [0 0 1 0 0]; % Set spectrum
%freq = [0 1/6 1/6+eps 1]; mag = [0 1 0 0]; % Set spectrum
x = fir2(511, freq, mag); % and use fir2 to create a bandlimited input sequence
% Evaluate and plot the input spectrum
[X, w] = freqz(x, 1, 512);
subplot(3,1,1);
%stem([0:length(x)-1],x);
plot(w/pi, abs(X)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Input spectrum');
v1=down_sample(x,3);
[V1, w] = freqz(v1, 1, 512);
subplot(3,1,2);
%stem([0:length(v1)-1],v1);
plot(w/pi, abs(V1)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Downsampling');
v2=up_sample(v1,3);
[V2, w] = freqz(v2, 1, 512);
subplot(3,1,3);
%stem([0:length(v2)-1],v2);
plot(w/pi, abs(V2)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Up-Sampling');
