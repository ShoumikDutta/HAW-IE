% lecture_22Mar2016.m
%
%
% demo of FFT/DFT for one cosine that fits into fundamental window
clear
close all
N=8;
n=0:N-1;

x_n = cos(2*pi*1/8*n);
X_k = fft(x_n);
X_k.'
pause

x_n = cos(2*pi*2/8*n);
X_k = fft(x_n);
X_k.'
pause

x_n = cos(2*pi*3/8*n);
X_k = fft(x_n);
X_k.'
pause

x_n = cos(2*pi*4/8*n);
X_k = fft(x_n);
X_k.'
pause

% here, we sample zeros !!
x_n = sin(2*pi*4/8*n);
X_k = fft(x_n);
X_k.'
pause
