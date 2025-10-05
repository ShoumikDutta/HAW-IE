% Design of IIR digital filters 
% IIR_Lowpass1.m  Version: 10/02 kzr
fprintf('Lowpass filter design\n')
fprintf('Butterworth........1 \n')
fprintf('Chebyshev I........2 \n')
fprintf('Chebyshev II.......3 \n')
fprintf('Elliptic / Cauer...4 \n')
FILTER = input('select filter type ? ');
%
Wp = input('passband cutoff frequency (0...1) ? ');
Ws = input('stopband cutoff frequency (0...1) ? ');
Dp = input('passband deviation (linear) ? ');
Rs = input('stopband deviation (dB) ? ');
% filter design 
%
Rp = -20*log10(1-Dp); % passband deviation in dB
switch FILTER
case 1
  disp('Butterworth')
  [n,Wn]= buttord(Wp,Ws,Rp,Rs); 
  [b,a] = butter(n,Wn);
case 2
  disp('Chebyshev I')
  [n,Wn]= cheb1ord(Wp,Ws,Rp,Rs); 
  [b,a] = cheby1(n,Rp,Wn);
case 3
  disp('Chebyshev II')
  [n,Wn]= cheb2ord(Wp,Ws,Rp,Rs); 
  [b,a] = cheby2(n,Rs,Wn);
case 4
  disp('Elliptic')
  [n,Wn]= ellipord(Wp,Ws,Rp,Rs); 
  [b,a] = ellip(n,Rp,Rs,Wn);
end
% --------------------------------------------------------- graphics
%
FIG1 = figure('Name','dsplab11_2 : lowpass design',...
  'NumberTitle','off','Units','normal','Position',[.54 .40 .45 .55]);
% pole-zero plot
subplot(3,2,1), zplane(b,a), grid
xlabel('Re\{z\} \rightarrow'), ylabel('Im\{z\} \rightarrow')
% frequency response
N = 1000;
f = (1/N)*(0:1:N-1);
% tolerance scheme 
TSu = ones(1,N);   % upper tolerance border
TSl = zeros(1,N);  % lower tolerance border
for k=1:N
  if f(k) <= Wp
    TSl(k) = 1-Dp;
  end
  if f(k) >= Ws
    TSu(k) = Dp;
  end
end
%
N = 1024;
[H,w] = freqz(b,a,N);     % frequency response

% magnitude
subplot(3,2,2), plot(w/pi,abs(H),f,TSu,'r',f,TSl,'r')
grid, xlabel('\Omega / \pi \rightarrow')
ylabel('|H(e^{j\Omega})| \rightarrow')
subplot(3,2,4), plot(w/pi,-20*log10(abs(H)),f,-20*log10(TSu),'r',f,-20*log10(TSl),'r')
grid, axis([0 1 0 60])
xlabel('\Omega / \pi \rightarrow')
ylabel('H(\Omega) [dB] \rightarrow')
% phase
%subplot(3,2,3), plot(w/pi,-phase(H')), grid
subplot(3,2,3), plot(w/pi,-real(H)/imag(H)), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('\phi(\Omega) \rightarrow')
% group delay
[taug,w] = grpdelay(b,a,N);
subplot(3,2,5), plot(w(1:N-5)/pi,taug(1:N-5)), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('\tau(\Omega) \rightarrow') 
%
% text
subplot(3,2,6)
axis([1 100 0 100])
axis('off')
switch FILTER
case 1
  text(0,90,'\bf{discrete-time Butterworth lowpass design}')
case 2
  text(0,90,'\bf{discrete-time Chebyshev I lowpass design}')
case 3
  text(0,90,'\bf{discrete-time Chebyshev II lowpass design}')
case 4
  text(0,90,'\bf{discrete-time Elliptic lowpass design}')
end
text(0,68,['filter order N = ',num2str(n)])
text(0,51,['passband cutoff frequency \omega_p/\pi = ',num2str(Wp)])
text(0,34,['passband deviation D_p = ',num2str(Dp)])
text(0,17,['stopband cutoff frequency \omega_s/\pi = ',num2str(Ws)])
text(0,0,['stopband deviation R_s (db) = ',num2str(Rs)])
% end
