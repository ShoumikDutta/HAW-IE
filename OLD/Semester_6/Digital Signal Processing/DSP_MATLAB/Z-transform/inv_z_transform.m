% inv_z_transform.m
% Inverse z-transform using impz.
% Compare example on slide 5
num = [1 2]; % setup numerator coefficients B
den = [1 0.4 -0.12]; % setup denomoinator coefficients A
L=6;
[h,t] = impz(num, den, L) % print impulse response, 6 coefficients
figure;
impz(num,den,L); % display impulse response
title('Impulse response ');


   
