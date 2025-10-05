% Demo-Programm zur Generierung von Sinussignalen

fs=8000; %Specify Sampling Frequency
N=512;
n=0:N-1;
f1=4000;
f2=2000;
omega1 = 2*pi*fs/fs;
omega2 = 2*pi*f1/fs;
omega3 = 2*pi*f2/fs; 
x1=sin(omega1*n/N * 4); % 4 Perioden fs
x2=sin(omega2*n/N * 4); % 2 Perioden fs/2
x3=sin(omega3*n/N * 4); % 1 Periode fs/4
dt = 1/fs/N * 4;        % Timescale
plot(n*dt,x1,'b',n*dt,x2,'r',n*dt,x3,'g');
xlabel('t / sec');ylabel('Amplitude');
