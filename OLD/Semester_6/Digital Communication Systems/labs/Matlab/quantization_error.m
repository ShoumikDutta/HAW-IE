%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HAW Hamburg               %
% Department IuE            %
% Digital Communications    %
% Prof. Dr. Rainer Schoenen %
% SS2015                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script creates a signal, and then quantizes it to a specified number
% of bits.  It then calculates the quantization error.
% See yourself if you run the script.
% Source: http://www.swarthmore.edu/NatSci/echeeve1/Class/e71/E71L1/E71L1.html

init_digital_communications; % initialize HAW/DKL details
fprintf('\nSampling and Quantization\n');

b=3;                            % Number of bits.
N=120;                          % Number of samples in final signal.
n=0:(N-1);                      % Index

% Choose the input type.
choice = questdlg('Choose input','Input',...
    'Sine','Sawtooth','Random','Random');

fprintf('Bits = %g, levels = %g, signal = %s.\n', b, 2^b, choice);

% Create the  input data sequence.
switch choice
    case 'Sine'
        x=sin(2*pi*n/N); % one period
    case 'Sawtooth'
        x=sawtooth(2*pi*n/N); % one period
    case 'Random'
        x=randn(1,N);       % Random data
        x=x/max(abs(x));    % Scale to +/- 1 (this changes signal power)
end
x_power = sum(x.^2)/N;      % signal power of signal (ignoring R, or R=1 Ohm)

% Signal is restricted to between -1 and +1. (this may change signal power)
x(x>=1)=(1-eps);            % Make  signal from -1 to just less than 1.
x(x<-1)=-1;

% Quantize a signal to "b" bits.  
xq=floor((x+1)*2^(b-1));    % Signal is one of 2^n int values (0 to 2^n-1)
xq=xq/(2^(b-1));            % Signal is from 0 to 2 (quantized)
xq=xq-(2^(b)-1)/2^(b);      % Shift signal down (rounding)

xe=x-xq;                    % Quantization error
xe_power = sum(xe.^2)/N;    % signal power of error signal (ignoring R, or R=1 Ohm)
snr = x_power / xe_power;   % signal-to-noise ratio
snr_dB = 10*log10(snr);     % SNR in dB (measured)
fprintf('S=%f, N=%f <-> S=%f dBm, N=%f dBm.\n', x_power, xe_power, 10*log10(x_power)+30, 10*log10(xe_power)+30);
fprintf('SNR=%f <-> %f dB.\n', snr, snr_dB);

stem(x,'b');
hold on;
stem(xq,'r');
hold on;
stem(xe,'g');
legend('exact','quantized','error','Location','Southeast')
title(sprintf('Signal, Quantized signal and Error for %g bits, %g quantization levels',b,2^b));
hold off
