% Problem 1 (DFT implementation):
%clc;    % clean the screen
clear;  % clear the memory

% create an arbitary vector  sin(t)
t = 0:1:1000;
%y = sin(t);
y = t;


% Call the function 
tic;
profile on;
Result1=funcDFT(y);
profile viewer
toc;


% Comparison with fft
tic;
Result2=fft(y);
toc;

Difference= Result2-Result1;

plot(y,Result1,'r', y,Result2,'b')
%figure(1)
%plot(y,Result1,'r')
%figure(2)
%plot(y,Result2,'b')