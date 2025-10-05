% us_overlap_add_very_simple.m
%
% Fs=8192:
% generates two sine waves, one at f0=53 Hz in pass-band, one at f1=3200 Hz in stop-band
% predefined filter impuls response h(n) below, low-pass
%
% shows that overlap and add works:
% the result is the sum of the two convolutions !!!
%
% US 2-Nov-04
% 
clear
pack
close('all');
Fs=8192;

% compute filter transfer function
h = ones(2,1);
Nh = length(h);

freq=(1:499)/1000;
hz=freqz(h,1,2*pi*freq);
plot(freq*Fs, db(hz)),grid
xlabel('freq [Hz]');
ylabel('|H| in dB');
pause

% time-domain simulation/convolution
N=2;
t=(0:N-1);
x1 = ones(1,N);
x2 = ones(1,N);

figure(1);
% append the two sequences for direct convolution in 1 step below:
x12 = [x1,x2];
stem(1:length(x12), x12),grid;
axis([0,length(x12),-1,1]);
title('x12: all ones in signal')
xlabel('samples'),
pause

% show the two sequences in the intervals:
%plot(t,x1),grid,title('x1'),pause
%plot(t,x2),grid,title('x2'),pause

% x1 with (Nh-1) zeros behind it, such that linear convolution = ciscular convolution !!!
x1z = [x1,zeros(1,Nh-1)];
y1=conv(h,x1z);
ty1=(1:length(y1));
Ny1 = length(y1);
stem(ty1,y1),grid,title('y1'),pause

% x2 with (Nh-1) zeros behind it, such that linear convolution = ciscular convolution !!!
x2z = [x2,zeros(1,Nh-1)];
y2=conv(h,x2z);
ty2=(1:length(y2));
Ny2 = length(y2);
stem(ty2,y2),grid,title('y2'),pause

%-------------------------------- all in 1 step: -----------------
y12 = conv(x12,h);

% just append 2 zeros to make the length of this sequence and the one computed
% below (sum of y1 and y2 !!) identical !!!
figure('position',[10,50,600,300]);
y12 = [y12,zeros(1,2)];
ty12=(1:length(y12));
stem(ty12,y12),grid,title('y12 direct convolution, 1 step'),pause
Ny12 = length(ty12);

%-------------------- and compare results -----------------------
y12t = zeros(1,Ny12);

% 1st interval:
figure('position',[10,400,300,300]);
y12t(1:N) = y1(1:N);
subplot(2,1,1);
plot(ty12,y12,ty12,y12t),grid,title('first interval');
subplot(2,1,2);
plot(y12-y12t),xlabel('difference');grid
pause

% 2nd interval:
figure('position',[350,400,300,300]);
subplot(2,1,1);
y12t(N+1:Ny2) = y1(N+1:Ny1)+y2(1:Ny2-N);
plot(ty12,y12,ty12,y12t),grid,title('middle interval');
subplot(2,1,2);
plot(y12-y12t),xlabel('difference');grid
pause

% 3rd interval:
figure('position',[700,400,300,300]);
subplot(2,1,1);
y12t(Ny1+1:2*Ny1-(Ny1-N)) = y2(Ny2-N+1:Ny2);
plot(ty12,y12,ty12,y12t),grid,title('last interval');
subplot(2,1,2);
plot(y12-y12t),xlabel('difference');grid
pause

