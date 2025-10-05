%% Problem 3 (Dual tones):

%[y, Fs] = wavread(filename) returns the sample rate (Fs) in Hertz used to encode the data in the file.
[y, Fs] = wavread('touchtone1.wav');
%soundsc(y, Fs);%soundsc(y,Fs) sends audio signal y to the speaker at sample rate Fs.

%(c) Imported the values

% t=linspace(0,1/Fs,length(Fs));
% plot(t,y);
% title('signal in time domain');
% xlabel('time');
% ylabel('|Y|');
% 
% Ts = 1/Fs;
% N = length(y)-1;
% To = N * Ts;
% n=0:Ts:To;
% plot(n.*Ts, y);
% xlabel('Time');
% ylabel('|Y|');

%-------------------------------------------
% Ts = 1/Fs;
% N = length(y)-1;
% To = N * Ts;
% n=0:Ts:To;
% plot(n.*Ts, y);
% title('signal in time domain');
% xlabel('Time');
% ylabel('|Y|');
%------------------------------------------------

% %(d) 
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
% 
% %Yes, the fequencies are obtained
