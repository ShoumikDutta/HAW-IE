% FIR_equiripple.m Version 02.11.01 / kzr
% Design of Equiripple Linear-Phase FIR Filter with the Parks-McClellan algorithm )
% Edited by Marco Casagrande, Julius Rauscher

% Fpass = input('Desired passband cutoff radian frequency = ');
% Fstop = input('Desired stopband cutoff radian frequency = ');
% DeltaP = input('Desired passband ripple (linear)= ');
% DeltaSS = input('Desired stopband tolerance (dB)= ');
% DeltaS = 10^(-DeltaSS/20);
clear all;

Fpass = 620;
Fstop = 1020;
DeltaP = 0.01;
DeltaSS = 40;
DeltaS = 10^(-DeltaSS/20);

% ----------------------- LOW PASS case -----------------------
% estimation of filter order
dev = [DeltaP DeltaS]; % deviation
f = [Fpass Fstop]; % frequency bands
FS = 8000; % frequency scaling (sampling frequency)
m = [1 0]; % amplitudes
[N,f0,m0,w] = firpmord(f,m,dev,FS);
N = N + 2; % compensate for estimation error

fprintf('Low-pass filter order N = %g\n',N);
% filter design by Remez algorithm
h = firpm(N,f0,m0,w); % impulse response

% needed by save_FIR_LP.m
N_FIR_LP = N;
b_FIR_LP = h;


% frequency response
M = 2048; % number of frequency samples
[H,f] = freqz(h,1,M);
% tolerance scheme for display
TSu = (1+DeltaP)*ones(1,M); % upper tolerance border
TSl = zeros(1,M); % lower tolerance border
for k=1:M
    if k <= Fpass/(FS/2)*M
        TSl(k) = 1-DeltaP;
    end
    if k >= Fstop/(FS/2)*M
        TSu(k) = -DeltaSS;
    end
end
FIG1 = figure('Name','Equiripple Linear-Phase FIR Filter','NumberTitle','off','Units','normal','Position',[.44 .30 .45 .55]);
% impulse responses
subplot(3,1,1), stem(0:N,h), grid
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
% frequency response
fn = f/pi;
subplot(3,1,2), plot(fn,abs(H),fn,TSu,'r',fn,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,1,3) % attenuation
plot(fn,20*log10(abs(H)),fn,TSu,'r'), axis([0 1 -80 0]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')




% ----------------------- LOW PASS case -----------------------
% estimation of filter order
dev = [DeltaP DeltaS]; % deviation
f = [Fpass Fstop]; % frequency bands
FS = 8000; % frequency scaling (sampling frequency)
m = [0 1]; % amplitudes
[N,f0,m0,w] = firpmord(f,m,dev,FS);
N = N + 2; % compensate for estimation error

fprintf('High-pass filter order N = %g\n',N);
% filter design by Remez algorithm
h = firpm(N,f0,m0,w); % impulse response

% needed by save_FIR_HP.m
N_FIR_HP = N;
b_FIR_HP = h;


% frequency response
M = 2048; % number of frequency samples
[H,f] = freqz(h,1,M);
% tolerance scheme for display
TSu = (1+DeltaP)*ones(1,M); % upper tolerance border
TSl = zeros(1,M); % lower tolerance border
for k=1:M
    if k >= Fpass/(FS/2)*M
        TSl(k) = 1-DeltaP;
    end
    if k <= Fstop/(FS/2)*M
        TSu(k) = -DeltaSS;
    end
end
FIG2 = figure('Name','Equiripple Linear-Phase FIR Filter','NumberTitle','off','Units','normal','Position',[.44 .30 .45 .55]);
% impulse responses
subplot(3,1,1), stem(0:N,h), grid
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
% frequency response
fn = f/pi;
subplot(3,1,2), plot(fn,abs(H),fn,TSu,'r',fn,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,1,3) % attenuation
plot(fn,20*log10(abs(H)),fn,TSu,'r'), axis([0 1 -80 0]), grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')

