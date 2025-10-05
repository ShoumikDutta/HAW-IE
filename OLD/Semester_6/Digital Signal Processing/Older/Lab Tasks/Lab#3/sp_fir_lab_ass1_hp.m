%Desired passband cutoff frequency 
OmegaP = 500;
%Desired stopband cutoff frequency 
OmegaS = 1000;
%Desired passband ripple (linear)
DeltaP = 0.01;
%Desired stopband tolerance (dB)
DeltaSS = 40;
DeltaS = 10^(-DeltaSS/20);
% estimation of filter order
dev = [DeltaP DeltaS]; % deviation
f = [OmegaP OmegaS]; % frequency bands
FS = 8000; % frequency scaling (sampling frequency)
m = [0 1]; % amplitudes

[N,f0,m0,w] = firpmord(f,m,dev,FS);
N = N + 2; % compensate for estimation error
fprintf('filter order N = %g\n',N);
% filter design by Remez algorithm
h = firpm(N,f0,m0,w); % impulse response
% frequency response
M = 2048; % number of frequency samples
[H,f] = freqz(h,1,M,FS);

filnam = fopen('FIR_HP.h', 'w'); % generate include-file
fprintf(filnam,'#define N_FIR_HP_coeffs %d\n', N+1);
fprintf(filnam,'short b_FIR_HP[N_FIR_HP_coeffs]={\n');
j = 0;
for i= 1:N+1
fprintf(filnam,' %6.0d,', round(h(i)*32768) );
j = j + 1;
if j >7
fprintf(filnam, '\n');
j = 0;
end
end
fprintf(filnam,'};\n');
fclose(filnam);

% FIG1 = figure('Name','Equiripple Linear-Phase FIR Filter',... 
%     'NumberTitle','off','Units','normal','Position',[.44 .30 .45 .55]);
% % impulse responses
% subplot(3,1,1), stem(0:N,h), grid
% xlabel('n'), ylabel('h[n]')
% axis([0 N -.2 .5]);
% % frequency response
% fn = f/pi;
% subplot(3,1,2), plot(fn,abs(H))
% 
% axis([0 1 0 1.2]); grid
% xlabel('\Omega /\pi '), ylabel('|H(e^{j\Omega})|')
% subplot(3,1,3) % attenuation
plot(f,20*log10(abs(H))), axis([0 3000 -100 10]), grid
xlabel('\Omega /\pi '), ylabel('|H(e^{j\Omega})|/dB ')