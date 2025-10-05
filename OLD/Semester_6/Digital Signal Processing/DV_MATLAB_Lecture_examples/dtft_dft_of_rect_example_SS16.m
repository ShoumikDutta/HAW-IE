% dtft_dft_of_rect_example_SS16.m
%
% US 20-Mar-16
%
% Explains that the DFT is the sampled sequence of the DTFT
%
% Changes:
%
clear
close all
% we assume that F = Fs= 1/T = 1

% X_e_j_omega via formula as used in excersice
freq=(0:0.01:0.99);
omega = 2*pi*freq;
M = inputs('M',3);
X_e_j_omega = exp(-j*omega*M/2).*sin(omega*(M+1)/2)./sin(omega/2);
abs_of_X_e_j_omega = abs(X_e_j_omega);


% X_k via 8 point DFT
N = inputs('please enter N', 8);
n = (0:N-1);
freq_DFT = (0:N-1)/N;
x_n = [ones(1,M+1), zeros(1,N-M-1)];
X_k = fft(x_n);

% X(e^(j*om)) via freqz:
% here x_n act like the impulse response of an FIR filter
X_e_j_omega_freqz = freqz(x_n, 1, 2*pi*freq);

% the DFT is the sampled sequence of the DTFT
plot(   freq, abs_of_X_e_j_omega, 'b-',...
        freq, abs(X_e_j_omega_freqz), 'r.',...
        n/N, abs(X_k),'g*'),grid
xlabel('normalized frequency 0 .. Fs')
title('DTFT, freqz-result and DFT of x_n');
ylabel('magnitudes');
