% Ex_VIII_2.m
% Example VIII 2)
% Interpolator /Decimator sequence with subsequent filter
%
% Note that the spectrum of the exercise description should be bandlimited to 0.5
% because otherwise decimation by 10 would cause detoriation!
clf;
freq = [0 0.1 0.1+eps 0.5 1]; mag = [0 1 1 0 0]; % Set spectrum
x = fir2(511, freq, mag); % and use fir2 to create a bandlimited input sequence
% Evaluate and plot the input spectrum
[X, w] = freqz(x, 1, 512);
subplot(5,1,1);
%stem([0:length(x)-1],x);
plot(w/pi, abs(X)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Input spectrum');

v1=up_sample(x,5);
[V1, w] = freqz(v1, 1, 512);
subplot(5,1,2);
%stem([0:length(v1)-1],v1);
plot(w/pi, abs(V1)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Upsampling by 5');

v2=down_sample(v1,5);
[V2, w] = freqz(v2, 1, 512);
subplot(5,1,3);
%stem([0:length(v2)-1],v2);
plot(w/pi, abs(V2)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Down-Sampling by 5');

v3=down_sample(v2,2);
[V3, w] = freqz(v3, 1, 512);
subplot(5,1,4);
%stem([0:length(v2)-1],v3);
plot(w/pi, abs(V3)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Down-Sampling by 2');

v4=up_sample(v3,2);
[V4, w] = freqz(v4, 1, 512);
subplot(5,1,5);
%stem([0:length(v2)-1],v3);
plot(w/pi, abs(V4)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Spectrum after Upsampling by 2');