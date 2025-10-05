% Matlab_interp.m
% Interpolates a double sin input by a factor of 4
t = 0:0.001:1; % time vector
x = sin(2*pi*30*t) + sin(2*pi*60*t);
y = interp(x,4);
subplot(2,1,1);
stem(x(1:30)); title('Original Signal');
subplot(2,1,2);
stem(y(1:120)); title('Interpolated Signal');
