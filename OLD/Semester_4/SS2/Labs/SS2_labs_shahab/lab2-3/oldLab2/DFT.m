function  DFT( xn )
%profile on 
tic

Y = zeros(1, 1000000);%Preallocating Arrays
N=length(xn);

for k = 1:N
   Y(k)=0;
    for n = 1:N
        Y(k) = Y(k)+(xn(n)*exp((-1j)*2*pi*(n-1)*(k-1)/N));
    end
end

%toprofile viewer

tic 
fft(xn);
toc 



% function [Xk] = dft(xn)
% N=length(xn);
% n = 0:1:N-1; % row vector for n
% k = 0:1:N-1; % row vecor for k
% WN = exp(-1j*2*pi/N); % Twiddle factor (w)
% nk = n'*k; % creates a N by N matrix of nk values
% WNnk = WN .^ nk; % DFT matrix
% Xk = (WNnk*xn );