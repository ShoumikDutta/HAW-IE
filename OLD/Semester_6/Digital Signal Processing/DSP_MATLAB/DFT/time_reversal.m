% time_reversal.m
% US 27-Mar-2012
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

% time reversal x(-k) means that x(-k) = [x(1),x(N),x(N-1),...,x(2)]
x1	= [x(1),x(N:-1:2)];
X   = fft(x);
X1  = fft(conj(x1));

disp('[conj(X), X1 and error abs( conj(X) - X1) ]');
[conj(X); X1; abs(conj(X) - X1)]