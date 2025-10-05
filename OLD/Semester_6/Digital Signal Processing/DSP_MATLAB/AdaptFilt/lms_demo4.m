% LMS_DEMO4: Adaptive design of an FIR filter
% kzr / 04/03 modified rch / 9/03

mue = input('Type in the value of mue = ');
alpha = input('Type in the value of alpha = ');
fc = input('Type in the normalized edge frequency (0..1)= ');
L = input('Type in the FIR model filter order = ');

M=41; N=1001; sigma=1+40*sqrt(2);
b=zeros(1,L+1); 
% Specification of the desired response
amp=[ones(1,(M-1)*fc),0.5,zeros(1,(M-1)*(1-fc))];
x=zeros(1,N); d=zeros(1,N);
for k=0:N-1,
   % Desired filter output signal
   d(k+1)=sum(amp(1:41).*sin(2*pi*[0:40]*(k-L/2)/80));
   % Adaptive filter input
   x(k+1)=sum(sin(2*pi*[0:40]*k/80));
end
figure(4);
plot([1:length(d)],d,[1:length(d)],x,'r');
   title('Fig. 4: Testsignal (blue) and reference signal (red)');
   xlabel('Sample Number'); ylabel('Amplitude');
   
[y,b,px]=dsp_lms(x,d,b,mue,sigma,alpha,0);
%gain=abs(spgain(b,1,(0:300)*0.5/300));
[H,f] = freqz(b,1,512,2);
figure(1); plot(f,abs(H),'k',[0:40]/40,amp,'r'); grid;
   title('Fig. 1: Desired (red) and adaptive amplitude gains (black)');
   xlabel('\Omega /\pi \rightarrow');
   ylabel('|H(e^{j\Omega})| \rightarrow');
figure(2); plot([0:L],b,'k'); grid;
   title('Fig. 2: Modelled impulse response H(z)');
   xlabel('Sample Number'); ylabel('Amplitude');
   epsilon=max(1e-5,(d-y).^2);
figure(3); semilogy([0:N-1],epsilon,'k');
   title('Fig. 3: Ek^2, Squared error during convergence');
   xlabel('Sample Number'); ylabel('Epsilon squared')
