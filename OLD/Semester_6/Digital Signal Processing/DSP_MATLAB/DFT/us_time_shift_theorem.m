% us_time_shift_theorem.m
% Demonstration of the time_shift_theorem for ll
%
% x(k + ll)   o-.    W_N^(-ll*n) * X(n)
%
% US 09-Oct-11
% 
clear
close('all');
N = inputs('N', 8);             % original length of sequence
ll = inputs('time domain shift in samples "ll"', 1);
% create a ramp signal
k = (0:N-1);

x = (1:N)';
% calc the FFT
X = fft (x);
% create a VECTOR W_N^(-n) for multiplicaion in the frequency domain
% in order to demonstrate the time shift
n = (0:N-1);
W_N_to_the_n = exp(+j*2*pi/N*n).';
% multiply in the frequency domain (phase shift in time domain)
X_mult_in_freq_domain = X .* W_N_to_the_n.^(ll);

x_time_shifted = ifft( X_mult_in_freq_domain );
% ignore small 10^(-14) imaginary components
x_time_shifted = real(x_time_shifted);
% show results
[k', x, x_time_shifted ]




