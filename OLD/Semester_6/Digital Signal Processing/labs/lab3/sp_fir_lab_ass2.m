clear all;
close all;
% All frequency values are in Hz.
Fs = 8000;  % Sampling Frequency
Fstop1 = 800; 
Fpass1 = 1000; 
Fpass2 = 1500;  
Fstop2 = 1750; 
Fstop3 = 2000; 
Fpass3 = 2250;
Fpass4 = 2500;
Fstop4 = 2750;
Dstop_dB = 40;  %Stopband attenuation in dB
Dstop = 10^(-Dstop_dB/20);  % Stopband attenuation linear
Dpass  = 0.01;  % Passband Ripple

% design a BP FIR filter with the above specifications.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2 Fstop3 Fpass3 Fpass4 Fstop4]/(Fs/2), [0 1 0 1 0], [Dstop Dpass Dstop Dpass Dstop]);

% calculate the coefficients/impulse response.
h  = firpm(N, Fo, Ao, W);

%amplitude response
[H,f] = freqz(h,1,2048);
figure;plot(f/pi, 20*log10(abs(H)));grid on;         
title('BP FIR Filter Amplitude response');xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('abs(H) (dB)');
figure;plot(f/pi, abs(H));grid on;         
title('BP FIR Filter Amplitude response');xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('abs(H) (linear)');

%write the coefficients as short ints on files
write_coeffs(N, h, 'bp');

%generate signal
f1 = 500;
f2 = 1250;
f3 = 2000;
f4 = 2500;
f5 = 3000;
t = 0:1/Fs:1;
x_n = 0.2*(cos(2*pi*f1*t)+cos(2*pi*f2*t)+cos(2*pi*f3*t)+cos(2*pi*f4*t)+cos(2*pi*f5*t));

%filter the signal with the constructed BP FIR filter
y_n = filter(h, 1, x_n);

%plot original and filtered signals
figure('Name','Generated signal');
subplot(2,1,1);
plot(t, x_n);axis([0 .02 -.5 1]);xlabel('Time (s)');ylabel('x_n');
subplot(2,1,2);
plot(t, y_n);axis([0 .02 -.5 1]);xlabel('Time (s)');ylabel('y_n');

%plot FFT of x_n and y_n
figure;
subplot(2,1,1);
plot(0:Fs, abs(fft(x_n)));title('FFT of generated signal');xlabel('Frequency (Hz)');ylabel('FFT(x_n)');
subplot(2,1,2);
plot(0:Fs, abs(fft(y_n)));title('FFT of filtered signal');xlabel('Frequency (Hz)');ylabel('FFT(y_n)');