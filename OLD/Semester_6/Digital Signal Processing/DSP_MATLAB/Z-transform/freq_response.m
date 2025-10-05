% sec_ord_inv_z.m
% Frequency response estimation.
% using freqz.
% See Ifeachor Example 4D.4 p.240
b = [1 -1.6180 1]; % setup B-matrix from 3 row-vectors
a = [1 -1.5161 0.878]; % setup A-matrix from 3 row-vectors
freqz(b,a,256,500); % plot frequency response for 256 points and fs=500Hz
figure;
zplane(b,a); % Display poles and zeros



   
