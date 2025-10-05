%% NANA BAAH 
%% MOHAMMED BAGHERI
%%SS2 Lab 2

%%Problem 1 (DFT implementation):
%a
x = 1:1:10000;
tic;
profile on;
Y = my_DFT(x);
profile viewer
toc;
tic;
fft(x);
toc;


%%
%%Problem 2 (Spectrum of a rectangular signal):
fs = 8000;
To = 0.004;
Ts = 1/fs;
N = 2^nextpow2(To/Ts);% Next power of 2 from length of y[n]

y = zeros(N);
for k = 1:N
    y(k+1) = rect((k+1)*Ts);
end

x = linspace(0,To,N);
subplot(2,1,1);
plot(x,y);
title('RECT');
xlim([0, 5/1000]);
ylim([0,2]);
xlabel('Time domain');
ylabel('Amplitude Spectrum');
%
subplot(2,1,2);
f = fs/2 * linspace(-1,1,N);
toShift = fft(y);
plot(f , abs(fftshift(toShift)));
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


%% Problem 3 (Dual tones):

hfile='touchtone1.wav';
[y, Fs] = wavread(hfile);
soundsc(y, Fs);

%(c) Imported the values

t=linspace(0,1/Fs,length(Fs));
plot(t,y);
title('signal in time domain');
xlabel('time');
ylabel('|Y|');

Ts = 1/Fs;
N = length(y)-1;
To = N * Ts;
n=0:Ts:To;
plot(n.*Ts, y);
xlabel('Time');
ylabel('|Y|');

%(d) 
f0=1/To;
X=0:f0:Fs;
subplot(2, 1, 1);
plot(X, abs(fft(y)));
title('signal over frequency');
ylabel('|Y|');
xlabel('Angular Frequency');


% Symmetry of the fft around ws/2

subplot(2, 1, 2);

plot(X, abs(fft(y)));
xlim ([0 4096]);
title('signal over frequency');
xlabel('Angular Frequency');
ylabel('|Y|');

%Yes, the fequencies are obtained

