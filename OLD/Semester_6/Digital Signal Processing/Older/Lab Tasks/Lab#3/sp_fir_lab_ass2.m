
%Desired passband ripple (linear)
DeltaP = 0.01;

%Desired stopband tolerance (dB)
DeltaSS = 40;

DeltaS = 10^(-DeltaSS/20);
% estimation of filter order
%dev = [DeltaP DeltaS]; % deviation
dev = [0.01 0.01 0.01 0.01 0.01]; % deviation
f = [800 1000 1500 1750 2000 2250 2500 2750]; % frequency bands
FS = 8000; % frequency scaling (sampling frequency)
m = [0 1 0 1 0]; % amplitudes

[N,f0,m0,w] = firpmord(f,m,dev,FS);
N = N + 2; % compensate for estimation error
fprintf('filter order N = %g\n',N);
% filter design by Remez algorithm
h = firpm(N,f0,m0,w); % impulse response
% frequency response
M = 2048; % number of frequency samples
[H,f] = freqz(h,1,M,FS);

% filnam = fopen('FIR_BP.h', 'w'); % generate include-file
% fprintf(filnam,'#define N_FIR_BP_coeffs %d\n', N+1);
% fprintf(filnam,'short b_FIR_BP[N_FIR_BP_coeffs]={\n');
% j = 0;
% for i= 1:N+1
% fprintf(filnam,' %6.0d,', round(h(i)*32768) );
% j = j + 1;
% if j >7
% fprintf(filnam, '\n');
% j = 0;
% end
% end
% fprintf(filnam,'};\n');
% fclose(filnam);

FIG1 = figure('Name','Equiripple Linear-Phase FIR Filter',... 
    'NumberTitle','off','Units','normal');
% impulse responses
% subplot(2,1,1), stem(0:N,h), grid
% xlabel('n'), ylabel('h[n]')
% axis([0 N -.2 .5]);
% frequency response
%fn = f/pi;
subplot(2,1,1), plot(f,abs(H))

axis([0 4000 0 1.2]); 
grid
xlabel('Hz '), ylabel('|H(e^{j\Omega})|')
title('Aplitude response, absolute scale')
subplot(2,1,2) % attenuation
plot(f,20*log10(abs(H))), axis([0 4000 -80 0]), grid
xlabel('Hz '), ylabel('|H(e^{j\Omega})|/dB ')
title('Aplitude response, in dB')