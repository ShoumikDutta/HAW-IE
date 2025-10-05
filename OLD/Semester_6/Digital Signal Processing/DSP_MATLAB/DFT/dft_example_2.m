% FFT / spectrum of a rectangular sequence
%Version 06.10.01 / kzr
%
N = input('Type in the length N of sequence = ');
M = input('Type in the length of the DFT = ');
u = [ones(1,N)];
%
U = fft(u,M);		% computation the M-point DFT
t = 0:N-1;
stem(t,u);
figure(1);
title('Original time-domain sequence')
xlabel('Time index n'); ylabel('Amplitude')
pause
%
subplot(2,1,1);
k = 0:M-1;
stem(k,abs(U));
title('Magnitude of the DFT samples')
xlabel('Frequency index k'); ylabel('Magnitude');
subplot(2,1,2);
stem(k,angle(U));
title('Phase of the DFT samples');
xlabel('Frequency index k'); ylabel('Phase');
% end
