%---------------------------------------------------------------------------
% Bsp. vom Mittwoch, 16. Nov 2005
% fold_back.m
%---------------------------------------------------------------------------
clear
close('all');
t=(0:10);
f0 = 18000;
f1 = 20000;
Fs = 38000;

% Freq. ist 18 kHz
x0 = sin(2 * pi * (f0/Fs) * t );
figure(1);
stem(t,x0),grid,title('x0'),pause

% Freq. ist 20 kHz
x1 = sin(2 * pi * (f1/Fs) * t );
figure(1);
stem(t,x1),grid,title('x1'),pause

x0,x1,pause
plot(t,x0,'o-',t,-x1,'*-'),grid,title('x0 und x1'),pause
