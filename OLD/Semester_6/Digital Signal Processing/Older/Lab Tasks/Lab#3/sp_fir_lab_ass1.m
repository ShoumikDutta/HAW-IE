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
lp = [1 0]; % amplitudes
hp = [0 1]; % amplitudes

[N1,f1,m1,w1] = firpmord(f,lp,dev,FS);
[N2,f2,m2,w2] = firpmord(f,hp,dev,FS);
N1 = N1 + 2; % compensate for estimation error
% filter design by Remez algorithm
h_lp = firpm(N1,f1,m1,w1); % impulse response
h_hp = firpm(N2,f2,m2,w2); % impulse response
% frequency response
M = 2048; % number of frequency samples
[H1,W1] = freqz(h_lp,1,M,FS);
[H2,W2] = freqz(h_hp,1,M,FS);

%%Write LP filter's coefficients
% filnam = fopen('FIR_LP.h', 'w'); % generate include-file
% fprintf(filnam,'#define N_FIR_LP_coeffs %d\n', N+1);
% fprintf(filnam,'short b_FIR_LP[N_FIR_LP_coeffs]={\n');
% j = 0;
% for i= 1:N+1
% fprintf(filnam,' %6.0d,', round(h_lp(i)*32768) );
% j = j + 1;
% if j >7
% fprintf(filnam, '\n');
% j = 0;
% end
% end
% fprintf(filnam,'};\n');
% fclose(filnam);
%%
%%Write HP filter's coefficients
% filnam = fopen('FIR_HP.h', 'w'); % generate include-file
% fprintf(filnam,'#define N_FIR_HP_coeffs %d\n', N+1);
% fprintf(filnam,'short b_FIR_HP[N_FIR_HP_coeffs]={\n');
% j = 0;
% for i= 1:N+1
% fprintf(filnam,' %6.0d,', round(h_hp(i)*32768) );
% j = j + 1;
% if j >7
% fprintf(filnam, '\n');
% j = 0;
% end
% end
% fprintf(filnam,'};\n');
% fclose(filnam);

%impulse responses of LP
subplot(6,1,1), stem(0:N1,h_lp), grid
xlabel('n'), ylabel('h[n]')
%axis([0 N1-1 -.2 .5]);
title('Impulse response of LP');
subplot(6,1,2), stem(0:N2,h_hp), grid
xlabel('n'), ylabel('h[n]')
%axis([0 N2 -.2 .5]);
title('Impulse response of HP');
% frequency response of LP
subplot(6,1,3)
plot(W1,abs(H1)),axis([0 4000  0 1]); grid
xlabel('Hz'), ylabel('|H(e^{j\Omega})')
title(' Low Pass');
subplot(6,1,4) % attenuation
plot(W1,20*log10(abs(H1))), axis([0 4000  -100 0]), grid
xlabel('Hz'), ylabel('|H(e^{j\Omega})|')
title(' Low Pass');
% frequency response of HP
subplot(6,1,5)
plot(W2,abs(H2)),axis([0 4000  0 1]); grid
xlabel('Hz'), ylabel('|H(e^{j\Omega})|')
title(' High Pass');
subplot(6,1,6) % attenuation
plot(W2,20*log10(abs(H2))), axis([0 4000  -100 0]), grid
xlabel('Hz'), ylabel('|H(e^{j\Omega})|/dB')
title(' High Pass');