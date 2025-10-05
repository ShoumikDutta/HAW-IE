%---------------------------------------------------------------------------
% Bsp. vom Mittwoch, 2. Nov 2005
% basics.m
%---------------------------------------------------------------------------
clear
close('all');
Fs=8000;

% Generatorfrequenz
f0=inputs('Generatorfrequenz',100);

% n Abtastwerte
t=(0:999);

% Sinusschwingung
x=sin(2*pi*f0/Fs*t);
plot(x),grid,pause

% H(z) = 1 + 1 * zhm1;
h=[1,1];

% normierter Frequenzvektor
freq=(0:499)/1000;

% Uebertrf. berechnen (Freq. bereich)
% zae = h, nen = 1, Omega = 2*pi*freq  
H = freqz(h, 1, 2*pi*freq);

plot(freq*Fs, abs(H));grid,title('Amplitudengang');
ylabel('abs(H)');
xlabel('Freq.');
pause

plot(freq*Fs, 20*log10( abs(H) ) );grid,title('Amplitudengang in dB');
ylabel('dB');
xlabel('Freq. (lin)');
pause

semilogx(freq*Fs, 20*log10( abs(H) ) );grid,title('Amplitudengang in dB');
ylabel('dB');
xlabel('Freq. (log)');
pause

% Zeitbereich
y = filter(h, 1, x);
plot(t,x,t,y),grid
xlabel('n');
ylabel('x(n), y(n)');
pause

