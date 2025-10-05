%---------------------------------------------------------------------------
% 24-May-06
%---------------------------------------------------------------------------
% us_bilin_examp_dig_Nth_order.m
% 
% US 18-May-06
%
% designs a digital filter with edge freq. 1 kHz and Fs = 10 kHz via the analog way:
% 1) prewarp via 2/T*tan(om_dig*T/2) such that the analog distortion due to 
%    2/T*atan(om_ana*T/2) cancels out
% 2) analog design of H(s)
% 3) bilinear tranformation determines, from H(s), the coefficients of H(z)
%
% THIS INE IS FOR 2nd Order !!!
% 
clear
close('all');
% Fs = 10 kHz
Fs=10000;
T=1/Fs;
% frequency vector
freq=(10:10:Fs-10);

% do frequency prewarping first:
f_g_dig = inputs('edge frequency of digital filter, f_g_dig',1000);
omega_g_dig = 2*pi*f_g_dig;
omega_g_ana = 2/T*tan(omega_g_dig*T/2);

% now design an analog filter using "old known" methods in s-plane
% in general
N = inputs('degree of filter',2);
[nums,dens]=butter(N, omega_g_ana, 's');
H_von_s = freqs(nums, dens, 2*pi*freq);

% in addition, design the analog filter at om_g_dig !!
% this compares the behavior of an analog filter with om_g_dig INSTEAD of the prewarped filter
[nums_dig,dens_dig]=butter(N, omega_g_dig, 's');
%[nums_dig,dens_dig]=cheby1(N, 0.1, omega_g_dig, 's');
%[nums_dig,dens_dig]=ellip(N, 0.01, 40, omega_g_dig, 's');
H_von_s_dig = freqs(nums_dig, dens_dig, 2*pi*freq);

f0=omega_g_ana/(2*pi);
fprintf('edge frequency of analog filter at %6.2f \n',f0);

%------------------------- in z -------------------------------------
[numz, denz] = bilinear(nums,dens, Fs);
% check whether the "digital way" gives the same result
[numz_chk,denz_chk]=butter(N, f_g_dig/(Fs/2));
% compare
format short
disp('    numz, numz_chk,  denz,  denz_chk,  numz-numz_chk,  denz-denz_chk]');
[numz',numz_chk',denz',denz_chk',numz'-numz_chk',denz'-denz_chk'],pause
format long e

% the digital frequencies:
freq_dig = freq/2/Fs;
H_von_z = freqz(numz, denz, 2*pi*freq_dig);
H_von_z_chk = freqz(numz_chk, denz_chk, 2*pi*freq_dig);
plot(freq_dig*Fs,db(H_von_z),freq_dig*Fs,db(H_von_z_chk)),grid,title('compare with CHK');pause
semilogx(freq_dig*Fs,db(H_von_z),freq_dig*Fs,db(H_von_z_chk)),grid,title('compare with CHK');pause


% Note : the prewarped analog filter does NOT need to have the same shape like the digital one. 
% Remember: We used the prewarping trick to compensate the atan()-distortion
plot(freq,abs(H_von_s),'o', freq_dig*Fs,abs(H_von_z),'+'),title('blue o analog prewarped, + dig'),grid,pause
plot(freq,db(H_von_s),'o',  freq_dig*Fs,db(H_von_z),'+'),title('blue o analog prewarped, + dig'),grid,pause
semilogx(freq,db(H_von_s),'o', freq_dig*Fs,db(H_von_z),'+'),title('blue o analog prewarped, + dig'),grid,pause

% Note:
% compare analog and digtal filter with same om_g_dig, so WITHOUT prewarping.
% These should be the same (but of course they are not !) they only have the same edge frequency om_g_dig!!
% The difference is however small -  but  - it increases if f0_dig gets close to Fs/2  (e.g. 3000 Hz)!!
semilogx(freq,db(H_von_s_dig),'o', freq_dig*Fs,db(H_von_z),'+'),title('blue o analog NOT prewarped, + dig'),grid,pause

% do a time domain simulation and check at f0 what the amplitude is
t = (0:999);
x = sin(2*pi*f_g_dig/Fs*t);
y = filter(numz,denz,x);
plot(t,x,t,y),grid,pause

