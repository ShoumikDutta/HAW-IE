% lecture_fft.m
% Calculates a simple 8-point fft
% Check the calculation result of dsp-fft.doc slide 14-16
% J.R.02.07.03

N=8;                  % 64 point fft
x = [1,2,3,4,5,6,7,8];     % This is the lecture example
%x = [3,5,7,1,8,2,4,6];     % This is the lecture example
X = fft(x)'           % Do the FFT and output the result
