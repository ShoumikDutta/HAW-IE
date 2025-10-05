%conv_fast_filter.m
% Low-pass filter using DFT based linear convolution
% Version 14.8.03 /rch
%/* FIR-Filter spec: fs = 8000, fc = 1000, N = 21 */
h = [ 89 103 -0 -327 -761 -847 0 2033 4798 7225 8192 7225 4798 2033 0 -847 -761 -327 -0 103 89];
h = h/32767;              % Normalize 16 bit values
Lx = 67;                  % Length of input signal
nx = 0:Lx-1;
Omega=2*pi/Lx;
x1 = sin(2 * Omega * nx);     % peak at n=2 (pass region) 
x2 = 0.5*sin(20* Omega * nx); % peak at n=20(cutoff region) 
x3 = 0.5*sin(10* Omega * nx); % peak at n=20(transition region)
x = x1 + x2 + x3;         % superposition

subplot(2,2,1);
plot(nx,x);               % Display input signal
xlabel('Time index n'); ylabel('Amplitude');
title('Input signal');

L = length(h) + length(x) -1;
n = 0:L-1;

%Compute the DFTs
XE = fft(x,L);    % second parameter forces automatic zero padding
HE = fft(h,L);    % second parameter forces automatic zero padding
y = ifft(XE.*HE); % Calculate matrix product using transposed XE

subplot(2,2,2);
plot(n,abs(XE));  % Display spectrum of input signal 
xlabel('Time index n'); ylabel('Amplitude');
title('Spectrum of input signal');

subplot(2,2,4);
plot(n,abs(HE));  % Display transfer function
xlabel('Time index n'); ylabel('Amplitude');
title('Transfer function (spectrum of zero padded coefficients)');

subplot(2,2,3);
plot(n,real(y));  % Display real-part of ifft-result 
xlabel('Time index n'); ylabel('Amplitude');
title('Filter output using DFT-based linear convolution');


 
