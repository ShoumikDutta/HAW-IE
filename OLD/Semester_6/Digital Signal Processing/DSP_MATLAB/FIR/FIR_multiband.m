% FIR_multiband.m				Version 19.08.03 / rch
% Design of Equiripple Linear-Phase Multiband Filter with the Remez 
% algorithm Chebyshev approximation)
Fs = input('Enter sample frequency: ');
fedge = input('Enter frequency vector fedge (in rectangular brackets): ');
mval = input('Enter relative band-amplitudes (in rectangular brackets): ');
dev = input('Enter linear band-ripples (in rectangular brackets): ');
[N, fpts, mag, W] = remezord(fedge,mval,dev,Fs);
fprintf('filter order N = %g\n',N);
% filter design by Remez algorithm
h  =  remez(N,fpts,mag,W); 		% impulse response
% frequency response
M = 2048;               		% number of frequency samples
[H,f] = freqz(h,1,M);

FIG1 = figure('Name','Equiripple Linear-Phase FIR Filter',...
  'NumberTitle','off','Units','normal','Position',[.44 .30 .45 .55]);
% impulse responses
subplot(3,1,1), stem(0:N,h), grid 
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
% frequency response
fn = f/pi;
subplot(3,1,2), plot(fn,abs(H)), grid;
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,1,3)		% attenuation 
plot(fn,20*log10(abs(H))), grid 
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')
% end
