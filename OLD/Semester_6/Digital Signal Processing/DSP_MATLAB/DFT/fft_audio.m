% fft_audio.m
% version 10.10.01 / kzr
fprintf('Spectral analysis of audio signal\n')    % load audio signal 
filename = input('Type in the name of audio file (*.wav): ','s');
[y,fs,bits] = wavread(filename);
Y = fft(y);		% spetral analysis 
% graphics
t=0:length(y)-1; t=t/fs; % time scale
FIG1=figure('Name','FFT_audio : audio signal','NumberTitle','off');
subplot(2,1,1),plot(t,y), grid
xlabel('t [s]  \rightarrow'), ylabel('y(t)  \rightarrow')
title('time signal')
f=0:length(y)-1; f=f*fs/length(y); % frequency scale
YY = abs(Y)/max(abs(Y));
subplot(2,1,2), plot(f,YY), grid
axis([0 fs/2 0 1]);
title('dft spectrum');
xlabel('f [Hz]   \rightarrow'), ylabel('norm. |Y(f)| \rightarrow')
soundsc(y,fs,bits);   % sound
pause;
% spetral analysis - short term
M = 512;            % fft length
w = hamming(M);     % Hamming window
OL =4;              % overlap of the fft blocks, i.e, size of overlap M/OL  
N = floor(length(y)/M);
Y = zeros(OL*N,M/2);
for k=1:OL*(N-1)
  start = 1+(M/OL)*(k-1);
  stop  = start+M-1;
  YY    = fft(w.*y(start:stop))';
  Y(k,:)= abs(YY(1:M/2));
end
% graphics
FIG2=figure('Name','FFT_audio: waterfall diag.','NumberTitle','off');
Y = abs(Y(:,1:M/4));
Ymax=max(max(Y));
Y = Y/Ymax;
t=1:OL*N; t = t*(M/OL)/fs; % time scale
f=0:1:M/4-1; f=fs*f/M;     % frequency scale
h = waterfall(f,t,Y);
view(30,30)
xlabel(' f [Hz] \rightarrow'), ylabel(' t [s] \rightarrow')
zlabel('magnitudes of short term dft spectra \rightarrow')
% end
