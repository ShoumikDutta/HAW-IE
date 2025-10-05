%---------------------------------------------------------------------------
% 24-May-06 example MATLAB_Intro, shown beginning of the semester
%---------------------------------------------------------------------------
% MATLAB_intro.m
%
% US 6-Sep-04
%
% serves as MATLAB introduction in first WPP lecture

clear
close('all');
Fs=8192;

% design FIR low-pass filter and computation of |H(z)| using freqz()
fprintf('\n design of FIR low-pass filter\n');
t=(0:2000);
f_edge = inputs('edge frequency of LP-filter',1000);
b=fir1(32, f_edge/(Fs/2) );
%b=remez(32,[0, f_edge/(Fs/2), 1.5*f_edge/(Fs/2), 1], [1, 1 , 0, 0]);
freq_lin=linspace(1,999,500)'/2000;
freq_log=logspace(-4,0.001,500)'*0.5;

% computs H(z)
hz_lin = freqz(b,1,2*pi*freq_lin);
hz_log = freqz(b,1,2*pi*freq_log);

figure('position',[10,400,350,300]);
plot(freq_lin*Fs,20*log10(abs(hz_lin)));
grid;
xlabel('Frequency [Hz]');
ylabel('|H(e^j^\omega^T)|');
pause

figure('position',[370,400,350,300]);
semilogx(freq_log*Fs,20*log10(abs(hz_log)));
grid;
xlabel('Frequency [Hz]');
ylabel('|H(e^j^\omega^T)|');
pause

% time-domain filter simulation using filter()
fprintf('\n time-domain filter simulation using filter()\n');
f0=inputs('frequency of sinus',1000);
x=sin(2*pi*f0*t/Fs);
y=filter(b,1,x);

figure('position',[730,400,300,300]);
subplot(2,1,1);
plot(t,x);grid
subplot(2,1,2);
plot(t,y);grid,

%-----------------------------------------------------------
pause
close('all')

figure('position',[10,400,350,300]);
zplane(b,1);
grid;xlabel('low-pass');
figure('position',[10,100,350,200]);
hz_lin = freqz(b,1,2*pi*freq_lin);
plot(freq_lin*Fs,20*log10(abs(hz_lin)));
grid;
xlabel('Frequency [Hz]');
ylabel('|H(e^j^\omega^T)|');
pause




% high-pass
figure('position',[370,400,350,300]);
b_HP=fir1(32, f_edge/(Fs/2) ,'high');
zplane(b_HP,1);
grid;xlabel('high-pass');

figure('position',[370,100,350,200]);
hz_HP_lin = freqz(b_HP,1,2*pi*freq_lin);
plot(freq_lin*Fs,20*log10(abs(hz_HP_lin)));
grid;
xlabel('Frequency [Hz]');
ylabel('|H(e^j^\omega^T)|');
pause



% band-pass
figure('position',[730,400,300,300]);
b_BP=fir1(32, [f_edge 1.5*f_edge]/(Fs/2) ,'high');
zplane(b_BP,1);
grid;xlabel('band-pass');

figure('position',[730,100,350,200]);
hz_BP_lin = freqz(b_BP,1,2*pi*freq_lin);
plot(freq_lin*Fs,20*log10(abs(hz_BP_lin)));
grid;
xlabel('Frequency [Hz]');
ylabel('|H(e^j^\omega^T)|');
pause



