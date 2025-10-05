%%Problem 2 (Spectrum of a rectangular signal):
fs = 8000;
To = 0.004;
Ts = 1/fs;
N = 2^nextpow2(To/Ts);% Next power of 2 from length of y[n]

y = zeros(N);
for k = 1:N
    y(k+1) = rect((k+1)*Ts);
end

x = linspace(0,To,N);
subplot(2,1,1);
plot(x,y);
title('RECT');
xlim([0, 5/1000]);
ylim([0,2]);
xlabel('Time domain');
ylabel('Amplitude Spectrum');
%
subplot(2,1,2);
f = fs/2 * linspace(-1,1,N);%generates N points. The spacing between the points is (1-(-1))/(N-1)
toShift = fft(y);
plot(f , abs(fftshift(toShift)));

% toShift = DFT(y);
% plot(f , abs(fftshift(toShift)));
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')