% LMS_DEMO3: Adaptive system identification
% kzr / 04.03
%
mue = input('Type in the value of mue = ');
alpha = input('Type in the value of alpha = ');
sigma = input('Type in the value of initialized sigma^2= ');
L = input('Type in the FIR model filter order = ');

N=1001; rand('seed',123);
h=zeros(1,L+1);  % Initializing of vector h
xk=sqrt(12)*(rand(1,N)-0.5); % Input / random sequence

% The "unknown system" is an FIR bandpass filter with L=31:
w = hamming(31);
b = fir1(30,[0.3 0.7],'',w);
[H,f] = freqz(b,1,512,2);
figure(1);plot(f,20*log10(abs(H))), grid;
   title('Fig. 1: Characteristic of unknown system');
   xlabel('\Omega /\pi \rightarrow');
   ylabel('|H(e^{j\Omega})| \rightarrow');
% Generate the output sequence of the unknown system
dk = filter(b,1,xk);

% LMS Algorithm
[xk,h,px]=dsp_lms(xk,dk,h,mue,sigma,alpha,0);
SE=(dk-xk).^2;
figure(2); plot([0:1000],SE,'-k'); grid;
   title('Fig. 2: Ek^2, Squared error during convergence');
   xlabel('Sample Number');
   ylabel('Epsilon squared');
b=[b,zeros(1,L+1-length(b))];
figure(3); plot([0:L],h,'-k', [0:L],b,'*k'); grid;
   title('Fig. 3: Impulse response of system and model');
   xlabel('Sample Number');
   ylabel('(-)=system;  (*)=model');
