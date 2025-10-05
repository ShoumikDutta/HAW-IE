% freq_reversal.m
% US 27-Mar-2012
% x*(k) = X*(-n)
clear
close all
N=inputs('N=4 or 5 or 7 x random values', 5);
if N==5
    x	= [1,2,3,4,5]+j*[6,7,8,9,10];
elseif N==4
    x	= [1,2,3,4]+j*[5,6,7,8];
else
    x	= rand(1,7)+j*rand(1,7);
end; % if
X  = fft(x);
X1 = fft(conj(x));
% freq reversal X(-n) means that X(-n) = [X(1),X(N),X(N-1),...,X(2)]
X1	= [X1(1),X1(N:-1:2)];

disp('[X, conj(X1) and error abs( X - conj(X1)) ]');
[X; conj(X1); abs(X - conj(X1))]