% us_Impact_of_leakage_widely_sp.m
%
% DSP_dft.doc, slide 33
clear
close('all');

figure(1);
Fs=2;
N=inputs('N (... or 8192 or 128)',131072);
widely=inputs('widely spaced (Enter)',1);
t=(1:N);

%widely spaced
if (widely==1) 
    amp_2nd = inputs('amp 2nd',0.001);
    fprintf('widely spaced, amp of 2nd sin is = %6.4f\n', amp_2nd)
    y = sin(2*pi*0.1/Fs*t) + amp_2nd*sin(2*pi*0.6/Fs*t) ;
else 
%closely spaced
    amp_2nd = inputs('amp 2nd',0.1);
    fprintf('closely spaced, amp of 2nd sin is = %6.4f\n', amp_2nd)
    y = sin(2*pi*0.1/Fs*t) + amp_2nd*sin(2*pi*0.145/Fs*t) ; 
end;
plot(y),grid,pause
    
Y = fft(y');
Y_hamm = fft(y'.*hamming(length(y)));
Y_blackm = fft(y'.*blackman(length(y)));

Y_dB = db(Y);
Y_dB = Y_dB-max(Y_dB);

Y_hamm_dB = db(Y_hamm);
Y_hamm_dB = Y_hamm_dB-max(Y_hamm_dB);

Y_blackm_dB = db(Y_blackm);
Y_blackm_dB = Y_blackm_dB-max(Y_blackm_dB);

figure('position',[10,400,350,300]);
plot(Y_dB);grid, xlabel('Freq'),ylabel('|Y| in dB');
title('Y boxcar');
axis([0,length(y),-100,0]);

figure('position',[370,400,350,300]);
plot(Y_hamm_dB);grid, xlabel('Freq'),ylabel('|Y| in dB');
title('Y hamming');
axis([0,length(y),-100,0]);

figure('position',[730,400,350,300]);
plot(Y_blackm_dB);grid, xlabel('Freq'),ylabel('|Y| in dB');
title('Y Blackman');
axis([0,length(y),-100,0]);

fprintf('\n NOTE ----------->');
disp('script shows: for two closely spaced sinosoids and N=128:');
disp('the freq and amplitude of the 2nd sinus (f0=0.145, amp=0.1)is chosen such that');
disp('although blackman is better for N=128 it is not detected');
disp('since Blackman is twice as wide.');
disp('N=1024 helps of course');

