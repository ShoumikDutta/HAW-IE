% Frequency_transform.m
% Conversion of LP-Filter to BP-Filter

% This filter corresponds to a 2nd-order LP-IIR with 1dB@20Hz, 6dB@37Hz with Fs=100Hz
num = 17410.145;     % Laplace coefficients
den=[1, 137.94536, 17410.145];
Fig1=figure('Name','Lowpass Reference Filter');
freqs(num,den);

[numt,dent] = lp2bp(num,den,0.4,0.2)
Fig2=figure('Name','Derived Bandpass Filter');
freqs(numt,dent);








