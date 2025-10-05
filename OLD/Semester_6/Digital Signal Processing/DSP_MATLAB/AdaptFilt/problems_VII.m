% Problems_VII.m: LMS line enhancement for 3 sinusoids
% rch / 09.03
%
mue = input('Type in the value of mue = ');
alpha = input('Type in the value of alpha = ');
sigma= input('Type in the value of initialized sigma^2 = ');
L = input('Type in the FIR filter order = ');
T=0.01;   % sample period
fs=1/T;   % sample frequency
N = 1000; % This produces a duration of 10 secs
w = zeros(1,L+1); px=0;

% Create the input sequence from unit power sinusoids, all components contain unit power noise 
d1 = sqrt(2)*sin(2*pi*[0:N-1]*5/fs) + sqrt(12)*(rand(1,N)-0.5); % 5Hz sine ampl 1
d2 = sqrt(2*0.5)*sin(2*pi*[0:N-1]*15/fs) + sqrt(12)*(rand(1,N)-0.5); % 15Hz sine ampl 0.5
d3 = sqrt(2*1.5)*sin(2*pi*[0:N-1]*35/fs) + sqrt(12)*(rand(1,N)-0.5); % 35Hz sine ampl 1.5
d = d1+d2+d3;

figure(1); plot(T*[0:N-1],d); grid;
   title('Noisy input sequence, d(k)');
   xlabel('Time'); ylabel('Amplitude');

x = [0,d(1:N-1)];
% Adaptive filter in block-mode: 1st block
[y1,w,px] = dsp_lms(x(1:100),d(1:100),w,mue,sigma,alpha,px);
[H,f] = freqz(w,1,512,2);
figure(2); subplot(1,4,1); plot(f*fs/2, 20*log10(abs(H))); grid;
title('Gain after 100 iterations');axis([0 50 -60 0])
xlabel('Frequency (Hz)'); ylabel('Amplitude gain (db)');

% 2nd block
[y2,w,px] = dsp_lms(x(101:200),d(101:200),w,mue,sigma,alpha,px);
[H,f] = freqz(w,1,512,2);
subplot(1,4,2); plot(f*fs/2, 20*log10(abs(H)));grid;
title('Gain after 200 iterations');axis([0 50 -60 0])
xlabel('Frequency (Hz)'); ylabel('Amplitude gain (db)');
   
% 3rd block
[y3,w,px] = dsp_lms(x(201:500),d(201:500),w,mue,sigma,alpha,px);
[H,f] = freqz(w,1,512,2);
subplot(1,4,3); plot(f*fs/2, 20*log10(abs(H)));grid;
title('Gain after 500 iterations');axis([0 50 -60 0])
xlabel('Frequency (Hz)'); ylabel('Amplitude gain (db)');

% 4th block
[y4,w,px] = dsp_lms(x(501:1000),d(501:1000),w,mue,sigma,alpha,px);
[H,f] = freqz(w,1,512,2);
subplot(1,4,4); plot(f*fs/2, 20*log10(abs(H)));grid;
title('Gain after 1000 iterations');axis([0 50 -60 0])
   xlabel('Frequency (Hz)'); ylabel('Amplitude gain (db)');

y = [y1,y2,y3,y4];
figure(3); plot(T*[0:N-1],y); grid;
   title(['Output sequence y(k); mue = ',num2str(mue),', alpha = ',num2str(alpha)]);
   xlabel('Time'); ylabel('Amplitude');
%
