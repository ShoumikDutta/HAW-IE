%---------------------------------------------------------------------------
% dsp_lab2_preparation.m
%
% US Bsp. aus Vorlesung am 13.5.05

clear
freq=(1:100)/200;
Fs = 48000;
%freq=linspace();
freq=0.5*logspace(-3,0,500);
num=[1,0];
den=[1,-0.75]; % Achtung !!! allebi invertieren !!
h_von_z = freqz(num,den,2*pi*freq);
% h_von_z isrt KOMPLEX !!!
% MATLAB : log(x) macht ln !!!
figure(1);
semilogx(freq*Fs, 20*log10( abs(h_von_z) ) ),grid,title('2. Versuch');
title('Uebertrf.');
xlabel('Freq. in Hz');
ylabel('|H| in dB');
