% sos_example.m
% Beispiel für Kaskadierung eines IIR-Filters 5. Odnung mit sos
% Beispiel aus Mitra S. 625
% rch / 4.9.03

%Spec:
alphap=0.5; % dB
alphas=40;  % dB
wp=0.3;     % 0.3*fs/2
N=5;        % Filter order

[z,p,k] = ellip(N,alphap, alphas, wp);
subplot(3,1,1)
zplane(z,p);
title('Original poles of 5th order IIR-filter');

sos1 = zp2sos(z,p,k)
[z1,p1,k1] = sos2zp(sos1);
subplot(3,1,2);
zplane(z1,p1);
title('sos-Forward ordering');

sos2 = zp2sos(z,p,k,'down')
[z2,p2,k2] = sos2zp(sos2);
subplot(3,1,3)
zplane(z2,p2);
title('sos-Reverse ordering');