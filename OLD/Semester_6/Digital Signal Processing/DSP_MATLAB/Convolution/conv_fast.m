% conv_fast.m
% Linear convolution via the DFT
% Version 11.10.01 / kzr
x = input('Type in the first sequence = ');
h = input('Type in the second sequence = ');
% Determine the length of the result of convolution
L = length(x)+length(h)-1;
%Compute the DFTs by zero-padding
XE = fft(x,L); % second parameter forces automatic zero padding
HE = fft(h,L); % second parameter forces automatic zero padding
y1 = ifft(XE.*HE); % Calculate matrix product by using transposed XE
k = 0:1:L-1;
stem(k,real(y1)); % Display real-part of ifft-result 
xlabel('Time index n'); ylabel('Amplitude');
title('Result of DFT-based linear convolution');
