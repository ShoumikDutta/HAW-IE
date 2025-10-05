% complex_sequence.m
% Generation of complex exponential sequence.
% see Mitra p.59
disp('Generation of complex exponential sequence');
a = input('Enter real exponent = ');
b = input('Enter imaginary exponent = ');
c = a + b*i;
K = input('Enter gain constant = ');
N = input('Enter length of sequence = ');
n= 1:N;
x = K*exp(c*n);
re = real(x);
im = imag(x);
subplot(2,2,1);
stem(n, re);
xlabel('Time index n'); ylabel('Amplitude');
title ('Real part');
subplot(2,2,2);
stem(n, im);
xlabel('Time index n'); ylabel('Amplitude');
title ('Imaginary part');
phase = atan(im ./ re)*180/pi; % Note that "dot-division" is required here!
subplot(2,2,3);
stem(n, phase);
xlabel('Time index n'); ylabel('Phase (deg)');
title ('Phase');




   
