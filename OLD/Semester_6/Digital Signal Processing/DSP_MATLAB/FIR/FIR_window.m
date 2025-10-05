% fir_window.m
% Demonstrates windowing  
b = 0.4 * sinc(0.4*(-25:25)); % Symmetrical sinc function 
subplot(3,1,1);
plot((-25:25),b);
title('symmetrical sinc-function');
[H,w] = freqz(b, 1, 512, 2);  % frequency transform for boxcar window
subplot(3,1,2);
plot(w,abs(H)), grid
title('Frequency transform with rectangular window');
b = b.*hamming(51)';          % use transpose hamming vector here 
[H,w] = freqz(b, 1, 512, 2);  % calculate frequency transform for windowed function
subplot(3,1,3);
plot(w,abs(H)), grid
title('Frequency transform with Hamming window');
