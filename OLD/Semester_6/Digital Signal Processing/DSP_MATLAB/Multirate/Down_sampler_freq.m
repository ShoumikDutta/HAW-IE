% Down_Sampler_freq.m
clf;
% Effect of Down-sampling in the Frequency Domain
freq = [0 0.42 0.48 1]; mag = [0 1 0 0];
% Use fir2 to create a bandlimited input sequence
x = fir2(101, freq, mag);
% Evaluate and plot the input spectrum
[Xz, w] = freqz(x, 1, 512);
subplot(2,1,1);
plot(w/pi, abs(Xz)); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Input Spectrum');
% Generate the down-sampled sequence
M = input('Type in the down-sampling factor = ');
y = x([1: M: length(x)]);
% Evaluate and plot the output spectrum
[Yz, w] = freqz(y, 1, 512);
subplot(2,1,2);
plot(w/pi, abs(Yz)); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Output Spectrum');
