% Ex_7_3.m
% Calculation of LP-filter in Ifeachor Example 7.3
N = 53;
;    % Number of coeffs
fg = 1750; % Cut-off freq
fs = 8000; % Sample freq
n = -(N-1)/2 : (N-1)/2;
hd = 2*fg/fs * sinc(2*fg/fs * n); % Symmetrical sin(pi*x)/(pi*x). Note that this 
                                  % requires a factor 2 in the sinc-argument!
subplot(3,1,1);
plot(n,hd);
title('Ideal z-transform (sinc-function)');
window = hamming(N)';   % calculate Hamming window of length N and transpose 
h = hd .* window;       % element by element multiplication
subplot(3,1,2);
stem(n,h);
title('Filter coefficients');

[H,w] = freqz(h, 1, 512, fs);  % calculate freq. transform
subplot(3,1,3);
H_dB = 20*log10(abs(H));  % Calculate in dB
plot(w,H_dB), grid
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Frequency Transform');
