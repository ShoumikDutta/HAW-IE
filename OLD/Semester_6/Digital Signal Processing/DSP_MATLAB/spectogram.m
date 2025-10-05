% spectogram_demo_US.m
fs = 1000; % sampling rate
a = 0; % time interval
b = 5;
o = 400; % frequency of chirp function at time 1
t = a:1/fs:b;
f = sin(o*pi*t.*t); % computing chirp function
nfft = 32; % size of FFT
window_size = 16;
window = hanning(window_size);
overlap = 4; % overlap of window functions
axes('Position',[0.1,0.8,0.8,0.1])
plot(t,f)
title('Chirp function f(t) = sin(400\pi t^2) and FFT with Hanning window')
axis([a,b,-1.4,1.4])
axes('Position',[0.1,0.1,0.8,0.63])
spectrogram(f, window, overlap, nfft, fs);