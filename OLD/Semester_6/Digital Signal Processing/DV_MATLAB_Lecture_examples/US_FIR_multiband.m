%---------------------------------------------------------------------------

% 10. Juni 2005

% US_FIR_multiband.m (from FIR_multiband.m)	Version 19.08.03 / rch
% Design of Equiripple Linear-Phase Multiband Filter with the Remez 
% algorithm Chebyshev approximation)
%
% Examples:
%
% c = remezord( [500 1000 1500 2000 2500 3000], [0 1 0 1], [.1 0.01 0.1 0.01], 8000)
%
% REMEZ, with 1 band:
% b=remez(256,[0,15000/48000,16000/48000,1],[1,1,0.001,0.001]);
% 4 bands:
% b=remez(32,[0,.2, .25,0.4, 0.5,0.75, .8,1],[1,1, 0.01,0.01, 1,1, 0.01,0.01]);
%
% US 9-Nov-04
%
help us_fir_multiband
clear
close('all');

Fs = inputs('Enter sample frequency: ',8000);
% 0-500 stop-band, 1000-1500 pass-band, 2000-2500 stop-band, 3000-4000 pass-band
fedge = inputs('Enter frequency vector fedge (in rectangular brackets):', [500 1000 1500 2000 2500 3000]);
mval = inputs('Enter relative band-amplitudes (in rectangular brackets):',[0       1         0     1]);
dev = inputs('Enter linear band-ripples (in rectangular brackets):',      [0.01   0.001     0.01   0.001]);
[N, fpts, mag, W] = remezord(fedge,mval,dev,Fs);
fprintf('filter order N = %g\n',N);
% filter design by Remez algorithm
h  =  remez(N,fpts,mag,W); 		% impulse response
% frequency response
fn=(1:999)/2000;
H = freqz(h,1,2*pi*fn);

FIG1 = figure('Name','Equiripple Linear-Phase FIR Filter',...
  'NumberTitle','off','Units','normal','Position',[.44 .30 .45 .55]);
% impulse responses
subplot(3,1,1), stem(0:N,h), grid 
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
% frequency response
subplot(3,1,2), plot(fn*Fs,abs(H)), grid;
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,1,3)		% attenuation 
plot(fn*Fs,20*log10(abs(H))), grid 
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')
% end





