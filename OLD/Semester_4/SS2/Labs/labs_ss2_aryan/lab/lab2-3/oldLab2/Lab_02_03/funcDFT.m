function [ output ] = funcDFT( y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y1=ones(length(y),1);
y2=(y1*y)';

N=length(y);
n=[0:N-1];
k=[0:N-1]';

% The result is a 2D array such that 
% the columns vary as k varies and rows vary as n varies
h=exp(-i*k*n*2*pi/N);

% Multiply each element in y2 by each element in h
answer=y2.*h;

% We take the sum in row direction ( n direction)
output=sum(answer,1);

% output=sum(answer,2) gives the sum in column direction ( k direction)
end

