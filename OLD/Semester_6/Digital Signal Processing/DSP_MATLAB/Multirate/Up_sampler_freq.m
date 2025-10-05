% Up_Sampler_freq.m
clf;
% Effect of Up-sampling in the Frequency Domain
freq = [0 0.45 0.5 1]; mag = [0 1 0 0];
% Use fir2 to create a bandlimited input sequence
x = fir2(99, freq, mag);
% Evaluate and plot the input spectrum
[Xz, w] = freqz(x, 1, 512);
subplot(2,1,1);
plot(w/pi, abs(Xz)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Input Spectrum');
subplot(2,1,2);
% Generate the up-sampled sequence
L = input('Type in the up-sampling factor = ');
y = zeros(1, L*length(x));
y([1: L: length(y)]) = x;
% Evaluate and plot the output spectrum
[Yz, w] = freqz(y, 1, 512);
plot(w/pi, abs(Yz)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Output Spectrum');
