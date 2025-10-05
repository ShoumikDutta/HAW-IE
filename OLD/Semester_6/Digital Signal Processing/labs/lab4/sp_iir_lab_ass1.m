% All frequency values are in Hz.
Fs = 8000;  % Sampling Frequency

Fpass = 1950;        % Passband Frequency
Fstop = 3000;        % Stopband Frequency
Rpass = 0.01;        % Passband Ripple (dB)
Astop = 40;          % Stopband Attenuation (dB)
%design LP IIR Chebyshev 1 filter
[n,Wn]= cheb1ord(Fpass/(Fs/2),Fstop/(Fs/2),Rpass,Astop);
[b,a] = cheby1(n,Rpass,Wn);
%design LP IIR Elliptic filter
[n1,Wn1]= ellipord(Fpass/(Fs/2),Fstop/(Fs/2),Rpass,Astop);
[b1,a1] = ellip(n1,Rpass,Astop,Wn1);
%design HP IIR Elliptic filter
[b_hp,a_hp] = ellip(n1,Rpass,Astop,0.75,'high');

%find sos matrixes and gains
sos_cheb = tf2sos(b,a);
sos_ellip = tf2sos(b1,a1);
sos_hp = tf2sos(b_hp,a_hp);

%write the coefficients as short ints on header files
write_coeffs(n, sos_cheb, 1);
write_coeffs(n1, sos_ellip, 2);
write_coeffs(n1, sos_hp, 3);

[H, w] = freqz(b,a,1024);
[H1, w1] = freqz(b1,a1,1024);
[H_hp, w_hp] = freqz(b_hp,a_hp,1024);

figure('Name','LP IIR Filter - Chebyshev 1');
subplot(2,1,1), plot(w/pi, abs(H)), title('Linear magnitude'), xlabel('w/pi'), ylabel('|H|');
subplot(2,1,2), plot(w/pi, db(abs(H))), title('In dB magnitude'), xlabel('w/pi'), ylabel('|H|(dB)');
figure('Name','LP IIR Filter - Elliptic');
subplot(2,1,1), plot(w1/pi, abs(H1)), title('Linear magnitude'), xlabel('w/pi'), ylabel('|H|');
subplot(2,1,2), plot(w1/pi, db(abs(H1))), title('In dB magnitude'), xlabel('w/pi'), ylabel('|H|(dB)');
figure('Name','HP IIR Filter - Elliptic');
subplot(2,1,1), plot(w_hp/pi, abs(H_hp)), title('Linear magnitude'), xlabel('w/pi'), ylabel('|H|');
subplot(2,1,2), plot(w_hp/pi, db(abs(H_hp))), title('In dB magnitude'), xlabel('w/pi'), ylabel('|H|(dB)');

%-------part 2--------
t = 0:1/Fs:1;
x_n = 0.2*(cos(2*pi*500*t)+cos(2*pi*1250*t)+cos(2*pi*2000*t)+cos(2*pi*2500*t)+cos(2*pi*3500*t));

%create digital filters from specified sos matrix
lp_cheb = dfilt.df2sos(sos_cheb);
lp_ellip = dfilt.df2sos(sos_ellip);
hp_ellip = dfilt.df2sos(sos_hp);

%filter x_n with the different filters
y1_n = filter(lp_cheb, x_n);
y2_n = filter(lp_ellip, x_n);
y3_n = filter(hp_ellip, x_n);

figure('Name','LP IIR Filter - Chebyshev 1');
subplot(4,1,1), plot(t, x_n);axis([0 .02 -.5 1]);title('Generated signal');xlabel('Time (s)');ylabel('x_n');
subplot(4,1,2), plot(t, y1_n);axis([0 .02 -.5 1]);title('Filtereded signal in time domain');xlabel('Time (s)');ylabel('y_n');
subplot(4,1,3), plot(0:Fs, abs(fft(x_n)));title('FFT of generated signal');xlabel('Frequency (Hz)');ylabel('FFT(x_n)');
subplot(4,1,4), plot(0:Fs, abs(fft(y1_n)));title('FFT of filtered signal');xlabel('Frequency (Hz)');ylabel('FFT(y_n)');
figure('Name','LP IIR Filter - Elliptic');
subplot(4,1,1), plot(t, x_n);axis([0 .02 -.5 1]);title('Generated signal');xlabel('Time (s)');ylabel('x_n');
subplot(4,1,2), plot(t, y2_n);axis([0 .02 -.5 1]);title('Filtereded signal in time domain');xlabel('Time (s)');ylabel('y_n');
subplot(4,1,3), plot(0:Fs, abs(fft(x_n)));title('FFT of generated signal');xlabel('Frequency (Hz)');ylabel('FFT(x_n)');
subplot(4,1,4), plot(0:Fs, abs(fft(y2_n)));title('FFT of filtered signal');xlabel('Frequency (Hz)');ylabel('FFT(y_n)');
figure('Name','HP IIR Filter - Elliptic');
subplot(4,1,1), plot(t, x_n);axis([0 .02 -.5 1]);title('Generated signal');xlabel('Time (s)');ylabel('x_n');
subplot(4,1,2), plot(t, y3_n);axis([0 .02 -.5 1]);title('Filtereded signal in time domain');xlabel('Time (s)');ylabel('y_n');
subplot(4,1,3), plot(0:Fs, abs(fft(x_n)));title('FFT of generated signal');xlabel('Frequency (Hz)');ylabel('FFT(x_n)');
subplot(4,1,4), plot(0:Fs, abs(fft(y3_n)));title('FFT of filtered signal');xlabel('Frequency (Hz)');ylabel('FFT(y_n)');
