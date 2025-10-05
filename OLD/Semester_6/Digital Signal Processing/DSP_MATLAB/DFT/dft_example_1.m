% dft spectrum of a rectangular sequence
% Version 06.10.01 / kzr
%
x = [1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0];	% rectangular sequence
% x = [zeros(1,16)];
% x(1:4) = 1;   		% alternative syntax 

%Alternative sequence:
%Omega = pi/8;        
%x = cos (Omega*n);   % cos waveform
N = length(x);		% length of sequences (period)
n = 0:N-1;			% normalized time
X = dft(x); 		% computation of dft spectrum
%
% graphics
figure(1);
% subplot 1
subplot(2,2,1), stem(0:N-1,real(x));
axis([0 N-1 -1 1]);
grid;
xlabel('Time index n \rightarrow'),ylabel('Re\{x[n]\} \rightarrow');
title('Time-Sequence');
%
% subplot 2
subplot(2,2,3), stem(0:N-1,abs(X));
MAX = max(abs(X));
axis([0 N-1 -MAX MAX]);
grid; 
xlabel('Frequency index k \rightarrow'),ylabel('Magnitude\{X[k]\} \rightarrow');
title('DFT samples');
% end
