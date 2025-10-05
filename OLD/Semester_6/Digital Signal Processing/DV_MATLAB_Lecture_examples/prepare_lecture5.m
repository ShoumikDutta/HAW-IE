% prepare_lecture5.m
% US 25-Mar-08
clear
close('all')

n=(0:15);
N=16;

% generate two cos- or sin-signals
f0=inputs('f0',1.5);
f1=inputs('f0',2);
%x0=cos(2*pi*f0*n/N);
%x1=cos(2*pi*f1*n/N);
x0=sin(2*pi*f0*n/N);
x1=sin(2*pi*f1*n/N);
plot(n,x0,n,x1),grid,title('x0 and x1'),pause

% remember : operator ' does conjugate transpose
disp('ffts')
fft(x0.'),pause
fft(x1.'),pause

figure(1);
subplot(2,1,1);
stem(n,abs(fft(x0))),grid,title(['fft(x0), f0=',num2str(f0)])
subplot(2,1,2);
stem(n,abs(fft(x1))),grid,title(['fft(x1), f1=',num2str(f1)])
pause

% generate a triangular window
figure(2);
h_win=bartlett(N)';
plot(n,h_win),grid,pause
close(2)

%  window and do the FFT
figure(3);
subplot(2,1,1);
stem(n,abs(fft(x0.*h_win))),grid,title('fft(x0.*hwin)')
subplot(2,1,2);
stem(n,abs(fft(x1.*h_win))),grid,title('fft(x1.*hwin)')
pause
