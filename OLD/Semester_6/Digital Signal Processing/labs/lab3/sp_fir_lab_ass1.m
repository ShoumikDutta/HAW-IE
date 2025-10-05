clear all;
close all;
% all frequency values are in Hz.
Fs = 8000;     % sampling frequency
Fpass = 500;   % passband frequency
Fstop = 1000;  % stopband frequency
Dpass = 0.01;  % passband ripple
Dstop_dB = 40; % stopband attenuation in dB
Dstop = 10^(-Dstop_dB/20); %stopband attenuation linear

% design a LP FIR filter with the above specifications
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);
%design a HP FIR filter with the same specifications
%note that the Fpass and Fstop are flipped
[N_hp, Fo_hp, Ao_hp, W_hp] = firpmord([Fpass, Fstop]/(Fs/2), [0 1], [Dstop, Dpass]);

%make the filter order and hence the number of coefficients equal
while N < N_hp
    N = N+1;
end
while N_hp < N
    N_hp = N_hp+1;
end

% calculate the coefficients/impulse response.
h_FIR_LP  = firpm(N, Fo, Ao, W);
h_FIR_HP  = firpm(N_hp, Fo_hp, Ao_hp, W_hp);

%frequency responce
[H,f] = freqz(h_FIR_LP, 1, 2048,'whole');
[H1,f1] = freqz(h_FIR_HP, 1, 2048,'whole');

%plot amplitude response in dB 
figure('Name','Equiripple Linear-Phase FIR Filter - Amplitude reasponse');
%plot(f/pi, 20*log10(abs(H))); grid on;         
%title('LP FIR Filter Amplitude response');xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('abs(H) (dB)');
plot(f/pi, 20*log10(abs(H)), f1/pi, 20*log10(abs(H1))); grid on;
title('LP and HP FIR Filter Amplitude response');xlabel('Normalized Frequency (\times\pi rad/sample)');ylabel('abs(H) (dB)');legend('LPF', 'HPF');

%plot impulse response for both filters on the same graph
figure('Name','Equiripple Linear-Phase FIR Filter - Impulse response');
stem(0:N, h_FIR_LP);hold on
stem(0:N_hp, h_FIR_HP);title('Impulse responses of both HP and LP filters');legend('LPF','HPF');

%write the coefficients as short ints on files
write_coeffs(N, h_FIR_LP, 'l');
write_coeffs(N_hp, h_FIR_HP, 'h');


% x=1;
% for k=1:length(h_FIR_LP)
%     h(k) = h_FIR_LP(k) * x;
%     x=-1*x;
% end
% figure
% subplot(2,1,1);
% stem(0:N,h);
% [H1,f1] = freqz(h, 1, 2048);
% subplot(2,1,2);
% plot(f1,20*log10(abs(H1)));




