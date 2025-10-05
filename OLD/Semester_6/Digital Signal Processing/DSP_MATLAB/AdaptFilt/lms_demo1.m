% LMS_DEMO1a: Demonstrate LMS in line enhancement
% kzr / 11.02, rch / 09.03
%
mue = input('Type in the value of mue = ');
alpha = input('Type in the value of alpha = ');
sigma= input('Type in the value of initialized sigma^2 = ');
L = input('Type in the FIR filter order = ');
N = 501;
w = zeros(1,L+1); px=0;
d1 = sqrt(2)*sin(2*pi*[0:N-1]/20); % single sine component
%d1 = sqrt(2)*sin(2*pi*[0:N-1]/20)+sqrt(2)*sin(2*pi*[0:N-1]/5); % double sine
d = sqrt(2)*sin(2*pi*[0:N-1]/20) + sqrt(12)*(rand(1,N)-0.5);
%d2 = sqrt(2)*sin(2*pi*[0:N-1]/5) + sqrt(12)*(rand(1,N)-0.5); % double sine
%d=d+d2; % double sine
x = [0,d(1:N-1)];
%
[y,w,px] = dsp_lms(x,d,w,mue,sigma,alpha,px);
%
figure(1); plot([0:500],d,'-r',[0:500],d1,'-b'); grid;
   title('Noisy input sequence, d(k)');
   xlabel('Time'); ylabel('Amplitude');
%
figure(2); plot([0:500],y,'-r',[0:500],d1,'-b'); grid;
   title(['Output sequence y(k); mue = ',num2str(mue),', alpha = ',num2str(alpha)]);
   xlabel('Time'); ylabel('Amplitude');
%
[H,f] = freqz(w,1,512,2);
figure(3); plot(f*0.5, 20*log10(abs(H))); grid;
   title('Final gain of adaptive filter');
   xlabel('Frequency (Hz)'); ylabel('Amplitude gain (db)');
