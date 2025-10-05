% up_down_cascade.m
% Cascades of L-upsampler M-downsampler sequences.
% The file compares 
% a) first up- then down-sampling
% b) first down- then up-sampling
% We see that the two cascades give identical results only
% if L and M are "relatively prime" i.e M and L only have 1 as a common factor.
% This especially means that L=M yield DIFFERENT results!
% see S.K. Mitra p. 670

clf;
L = input('Enter up-sampling factor ');
M = input('Enter down-sampling factor ');
freq = [0 0.1 0.1+eps 0.33 1]; mag = [0 1 1 0 0]; % Set spectrum
x = fir2(511, freq, mag); % and use fir2 to create a bandlimited input sequence
% Evaluate and plot the input spectrum
[X, w] = freqz(x, 1, 512);
subplot(3,2,1);
%stem([0:length(x)-1],x);
plot(w/pi, abs(X)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title('Input spectrum');

v1=up_sample(x,L);
[V1, w] = freqz(v1, 1, 512);
subplot(3,2,3);
%stem([0:length(v1)-1],v1);
plot(w/pi, abs(V1)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title(['Spectrum after Upsampling by ',num2str(L)]);
v2=down_sample(v1,M);
[V2, w] = freqz(v2, 1, 512);
subplot(3,2,4);
%stem([0:length(v2)-1],v2);
plot(w/pi, abs(V2)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title(['This after Downsampling by ',num2str(M)]);

v3=down_sample(x,M);
[V3, w] = freqz(v3, 1, 512);
subplot(3,2,5);
%stem([0:length(v1)-1],v1);
plot(w/pi, abs(V3)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title(['Spectrum after Downsampling by ',num2str(L)]);
v4=up_sample(v3,L);
[V4, w] = freqz(v4, 1, 512);
subplot(3,2,6);
%stem([0:length(v2)-1],v2);
plot(w/pi, abs(V4)); axis([0 1 0 1]); grid
xlabel('\omega/\pi'); ylabel('Magnitude');
title(['This after Upnsampling by ',num2str(M)]);
