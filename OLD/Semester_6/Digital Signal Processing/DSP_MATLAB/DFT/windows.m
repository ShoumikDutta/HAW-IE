% windows.m
% Version 08.10.01 / kzr

N = 64; NC = 65;        % length of windows
M = 2048;               % length of fft
f = 0:M-1; f = f/(M/2); % normalized radian frequency
FIG1 = figure('Name','Hanning and Blackman window', 'NumberTitle','off');
w = hanning(N);	% Hanning window
subplot(2,2,1), stem(0:N-1,w), grid
axis([0 N-1 0 1])
title('Hanning'), xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft([w' zeros(1,M-N)]);
W = W/abs(W(1));
subplot(2,2,3),semilogy(f,abs(W)), grid
axis([0 1 1e-6 1])
xlabel('\Omega / \pi \rightarrow'), ylabel('|W(e^{j\Omega})| \rightarrow') 
w = blackman(N); % Blackman window
subplot(2,2,2), stem(0:N-1,w), grid
axis([0 N-1 0 1])
title('Blackman'), xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft([w' zeros(1,M-N)]);
W = W/abs(W(1));
subplot(2,2,4),semilogy(f,abs(W)), grid
axis([0 1 1e-6 1])
xlabel('\Omega / \pi \rightarrow')
ylabel('|W(e^{j\Omega})| \rightarrow') 
FIG2 = figure('Name','Kaiser and Chebyshev window','NumberTitle','off');
w = kaiser(N,5.46);	% Kaiser window
subplot(2,2,1), stem(0:N-1,w), grid
axis([0 N-1 0 1])
title('Kaiser'), xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft([w' zeros(1,M-N)]);
W = W/abs(W(1));
subplot(2,2,3),semilogy(f,abs(W)), grid
axis([0 1 1e-6 1])
xlabel('\Omega / \pi \rightarrow'), ylabel('|W(e^{j\Omega})| \rightarrow') 
w = chebwin(NC,60);	% Chebyshev window
subplot(2,2,2), stem(0:NC-1,w), grid
axis([0 NC 0 1])
title('Chebyshev'), xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft([w' zeros(1,M-NC)]);
W = W/abs(W(1));
subplot(2,2,4),semilogy(f,abs(W)), grid
axis([0 1 1e-6 1])
xlabel('\Omega / \pi \rightarrow'), ylabel('|W(e^{j\Omega})| \rightarrow') 
% end
