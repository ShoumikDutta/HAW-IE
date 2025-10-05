% Design of Equiripple Linear-Phase FIR Filter with the Parks-McClellan algorithm )
% Edited by Marco Casagrande, Julius Rauscher

clear all;

DeltaP = 0.01;
DeltaSS = 40;
DeltaS = 10^(-DeltaSS/20);

% ----------------------- Band pass case -----------------------
% estimation of filter order
dev = [DeltaS DeltaP DeltaS DeltaP DeltaS]; % deviation
f = [900 1100 1600 1850 2100 2350 2600 2850]; % frequency bands
m = [0 1 0 1 0]; % amplitudes
FS = 8000; % frequency scaling (sampling frequency)
[N,f0,m0,w] = firpmord(f,m,dev,FS);
N = N + 2; % compensate for estimation error
N_FIR_BP = N;

fprintf('Bandpass filter order N = %g\n',N);
% filter design by Remez algorithm
h = firpm(N,f0,m0,w); % impulse response
b_FIR_BP = h;

% frequency response
M = 2048; % number of frequency samples
[H,f] = freqz(h,1,M);


%added cosine function
x_n = cos(2*pi*500*(0:M-1)/FS) + cos(2*pi*1250*(0:M-1)/FS) + cos(2*pi*2400*(0:M-1)/FS) + cos(2*pi*2500*(0:M-1)/FS) + cos(2*pi*3000*(0:M-1)/FS);

y_n = filter(h,1,x_n);


FIG1 = figure('Name','Bandpass FIR Filter','NumberTitle','off','Units','normal','Position',[.5 .30 .45 .55]);
% impulse responses
subplot(3,1,1), stem(0:N,h), grid
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -1 1]);
% frequency response
fn = f/pi;
subplot(3,1,2), plot(fn,abs(H))
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,1,3) % attenuation
plot(fn,20*log10(abs(H))), axis([0 1 -80 0]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')

fe = fn*8000;

FIG2 = figure('Name','Bandpass FIR Filter with multiple sinussoidal inputs','NumberTitle','off','Units','normal','Position',[.5 .30 .45 .55]);

subplot(2,1,1)
plot(fn,abs(fft(x_n))/2048), axis([0 1 0 1]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')

subplot(2,1,2)
plot(fn,abs(fft(y_n))/2048), axis([0 1 0 1]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')


FIG3 = figure('Name','Multiple sinussoids','NumberTitle','off','Units','normal','Position',[.5 .30 .45 .55]);

subplot(2,1,1)
plot(f,x_n), axis([0 pi -4 4]), grid
xlabel('\Omega \rightarrow'), ylabel('x_n \rightarrow')

subplot(2,1,2)
plot(f,y_n), axis([0 pi -4 4]), grid
xlabel('\Omega \rightarrow'), ylabel('y_n \rightarrow')

FIG3 = figure('Name','Bandpass FIR Filter','NumberTitle','off','Units','normal','Position',[.5 .30 .45 .55]);
subplot(3,1,1)
plot(fn,abs(fft(x_n))/2048), axis([0.5 1 0 1]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')

subplot(3,1,2)
plot(fn,20*log10(abs(H))), axis([0 1 -80 0]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')

subplot(3,1,3)
plot(fn,abs(fft(y_n))/2048), axis([0.5 1 0 1]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')