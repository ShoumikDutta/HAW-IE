% Matlab_decimate.m
% Interpolates a double sin input by a factor of 4
clf;
t = 0:.00025:1;                        % time vector
x = sin(2*pi*30*t) + sin(2*pi*60*t);
y = decimate(x,4);
subplot(2,1,1);
stem(x(1:120)), axis([0 120 -2 2])   % original signal
title('Original Signal')
subplot(2,1,2);
stem(y(1:30));                        % decimated signal
title('Decimated Signal');
