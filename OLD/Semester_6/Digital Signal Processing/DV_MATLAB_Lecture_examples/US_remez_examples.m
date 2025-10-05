%---------------------------------------------------------------------------
% Bsp. vom Mittwoch, 23. Nov 2005
% US_remez_examples.m
%---------------------------------------------------------------------------

%
% US 22-Nov-05
%
% Bsp. 2 : funktioniert auch
% von 0 bis 0.1 wird die 1 approx, AbsRipple ist 0.01
% von 0.1 bis 0.2 : Übergangsbereich !!
% von 0.2 bis 0.3 wird die 0 approx, AbsRipple ist 0.0001
% von 0.3 bis 0.4 : Übergangsbereich !!
% von 0.4 bis 0.5 wird die 0.1 approx, AbsRipple ist 0.01
% von 0.5 bis 0.6 : Übergangsbereich !!
% von 0.6 bis 0.7 wird die 0 approx, AbsRipple ist 0.01
% von 0.7 bis 0.8 : Übergangsbereich !!
% von 0.8 bis 1.0 wird die 0.1 approx,, AbsRipple ist 0.0001
clear
close('all');
freq=(1:499)/1000;
Fs = 2;
[N_FIR,fo,mo,w] = remezord( ...
    [0.1  0.2  0.3    0.4  0.5    0.6   0.7     0.8     ], ... % bis 1.0 !!
    [1        0          0.1         0          0.1     ], ... % bis 1.0 !! 
    [0.01     0.01       0.0001      0.01       0.0001  ])

b = remez(N_FIR,fo,mo,w);

sq_size = 300;

fprintf('number of coe %d\n', length(b));
hz_FIR = freqz(b,1,2*pi*freq);

figure('position',[10,50,sq_size,sq_size],'name','FIR filter |H| linear');
plot(freq*Fs, abs(hz_FIR)),grid
title(['FIR Filter, degree : ',num2str(length(b))]);

figure('position',[350,50,sq_size,sq_size],'name','FIR filter |H| in dB');
title(['FIR Filter, degree : ',num2str(length(b))]);
plot(freq*Fs, db(hz_FIR)),grid

