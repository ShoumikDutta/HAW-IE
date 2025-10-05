% FIR_equiripple.m				Version 02.11.01 / kzr
% Design of Equiripple Linear-Phase FIR Filter with the Remez 
% algorithm Chebyshev approximation)
OmegaP = input('Desired passband cutoff radian frequency = ');
OmegaS = input('Desired stopband cutoff radian frequency = ');
DeltaP = input('Desired passband ripple (linear)= ');
DeltaSS = input('Desired stopband tolerance (dB)= ');
DeltaS = 10^(-DeltaSS/20);
% estimation of filter order for Chebyshev approximation
dev = [DeltaP DeltaS];  		% deviation
f = [OmegaP OmegaS];    		% frequency bands
FS = 2;                 		% frequency scaling (sampling frequency)
m = [1 0];              		% amplitudes
[N,f0,m0,w] = remezord(f,m,dev,FS);
N = N + 2; 					% compensate for estimation error
fprintf('filter order N = %g\n',N);
% filter design by Remez algorithm
h  =  remez(N,f0,m0,w); 		% impulse response
% frequency response
M = 2048;               		% number of frequency samples
[H,f] = freqz(h,1,M);
% tolerance scheme for display
TSu = (1+DeltaP)*ones(1,M); 		% upper tolerance border
TSl = zeros(1,M);           		% lower tolerance border
for k=1:M
  if k <= OmegaP*M
    TSl(k) = 1-DeltaP;
  end
  if k >= OmegaS*M
    TSu(k) = -DeltaSS;
  end
end
FIG1 = figure('Name','Equiripple Linear-Phase FIR Filter',...
  'NumberTitle','off','Units','normal','Position',[.44 .30 .45 .55]);
% impulse responses
subplot(3,1,1), stem(0:N,h), grid 
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
% frequency response
fn = f/pi;
subplot(3,1,2), plot(fn,abs(H),fn,TSu,'r',fn,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,1,3)		% attenuation 
plot(fn,20*log10(abs(H)),fn,TSu,'r'), axis([0 1 -80 0]), grid 
xlabel('\Omega /\pi \rightarrow'), ylabel('|H(e^{j\Omega})|/dB \rightarrow')
% end
