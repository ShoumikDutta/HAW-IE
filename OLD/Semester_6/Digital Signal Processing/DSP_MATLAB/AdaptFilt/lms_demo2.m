% LMS_DEMO2: Adaptive interference cancelling
% kzr / 11.02
%
N=501; rand('seed',123);
mue = input('Type in the value of mue = ');
alpha= input('Type in the value of alpha = ');
sigma= input('Type in the value of initialized sigma^2 = ');
L = input('Type in the FIR filter order = ');
w=zeros(1,L+1); px=0;
t=[0:N-1]; arg=2*pi*t/20;
s=(1 + 0.01*t) .* sin(arg + pi/3);
x=0.1*sin(arg);
d=s+sqrt(12)*(rand(1,N)-0.5);
%
figure(1); plot([0:250],d(1:251)); grid;
      title('Signal plus Interference');
      xlabel('Time'); ylabel('Amplitude');
[y,w,px]=dsp_lms(x,d,w,mue,sigma,alpha,px);
%
figure(2); plot([0:250],s(1:251),'-r',...
                [0:250],x(1:251),':b',...
                [0:250],y(1:251),'--k'); grid;
   title(' Initial convergence');
   xlabel('Time');
   ylabel('Amplitude');
tb=[251:500];
%
figure(3); plot([251:500],s(252:501),'-r',...
                [251:500],y(252:501),'--b'); grid;
   title(' Tracking performance');
   xlabel('Time');
   ylabel('Amplitude');
