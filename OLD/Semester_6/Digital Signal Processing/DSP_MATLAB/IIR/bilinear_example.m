% bilinear_example.m
% Beispiel für IIR-Filterentwurf mit Bilinear-Transformation
% Beispiel aus Lyons S. 280
% rch / 1.9.03

num = 17410.145;     % Laplace coefficients
den=[1, 137.94536, 17410.145];

[z,p,k]=tf2zp(num,den); % analog zeros and poles
Fig1=figure('Name','Analog poles and zeros');
zplane(z,p);grid;

[zd,pd,kd]=bilinear(z,p,k,100); % bilinear transform for fs=100Hz
Fig2=figure('Name','Digital poles and zeros');
zplane(zd,pd);grid;

Fig3=figure('Name','Transfer fuction');
[b,a]=zp2tf(zd,pd,kd) % display coefficients from poles and zeros
freqz(b,a);grid;
