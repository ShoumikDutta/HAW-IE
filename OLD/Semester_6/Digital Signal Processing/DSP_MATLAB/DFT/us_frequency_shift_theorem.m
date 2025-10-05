% us_frequency_shift_theorem.m
% Demonstration of the frequency_shift_theorem for ll
%
% W_N^(ll*k) * x(k)   o-.    X(n +ll)
%
% US 4-Apr-06, revised 9-Oct-2011
% 
clear
close('all');
N = inputs('N', 8);             % original length of sequence
k = (0:N-1);
ll = inputs('frequency domain shift in samples "ll"',1);
% create a sine wave signal with 1 Hz
f0 = 1;
x = cos(2*pi*f0*k/N)';

% create a VECTOR W_N^(k) for multiplicaion in the time domain
W_N_to_the_k = exp(-j*2*pi/N*k).';
% calc the FFT
X = fft (x);

% multiply x(n) with complex exponential in the time domain (modulation)
x_freq_mod = x .* W_N_to_the_k.^(ll);
% calc the FFT of the frequency-shifted spectrum 
X_mod = fft( x_freq_mod );

% show results (magnitude)
[k', abs(X), abs(X_mod) ]




