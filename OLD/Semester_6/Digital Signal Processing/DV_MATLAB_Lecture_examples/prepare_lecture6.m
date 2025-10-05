% prepare_lecture6.m
% US 26-Mar-08
clear
close('all')

N1=inputs('N1 (16)',16);
N2=inputs('N2 (16..1024)',128);
v=ones(1,N1);
x = [v,zeros(1,N2-N1)];
X = fft(x);
n=(0:N2-1);
plot(n,db(X)),grid,title(['UN-normalized ',num2str(N2),',-point FFT of x(n)']),
%plot(n,db(X)-db(N2)),grid,title(['UN-normalized ',num2str(N2),',-point FFT of x(n)']),
pause
plot(n,db(X)-max(db(X))),grid,title(['normalized ',num2str(N2),',-point FFT of x(n) with boxcar']),
pause

% bartlett window
v_triang = v.*bartlett(N1)';
x_traing = [v_triang,zeros(1,N2-N1)];
X_triang = fft(x_traing);
plot(n,db(X_triang)-max(db(X_triang))),grid,title(['normalized ',num2str(N2),',-point FFT of x(n) with bartlett']),
pause

% hanning window
v_hanning = v.*hanning(N1)';
x_hanning = [v_hanning,zeros(1,N2-N1)];
X_hanning = fft(x_hanning);
plot(n,db(X_hanning)-max(db(X_hanning))),grid,title(['normalized ',num2str(N2),',-point FFT of x(n) with hanning']),
pause

% hamming window
v_hamming = v.*hamming(N1)';
x_hamming = [v_hamming,zeros(1,N2-N1)];
X_hamming = fft(x_hamming);
plot(n,db(X_hamming)-max(db(X_hamming))),grid,title(['normalized ',num2str(N2),',-point FFT of x(n) with hamming']),
pause

% blackman window
v_blackman = v.*blackman(N1)';
x_blackman = [v_blackman,zeros(1,N2-N1)];
X_blackman = fft(x_blackman);
plot(n,db(X_blackman)-max(db(X_blackman))),grid,title(['normalized ',num2str(N2),',-point FFT of x(n) with blackman']),

% compare the windows in the time domain:
plot(0:N2-1,blackman(N2),0:N2-1,hanning(N2),0:N2-1,hamming(N2)),grid,
title('blackman(b) ,hanning(g), hamming(r)'),
pause

