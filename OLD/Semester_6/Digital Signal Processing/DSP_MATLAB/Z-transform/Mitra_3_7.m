% Mitra_3_7.m
% Determinatin of factorial form of a rational z-Transformm (Poles and Zeros)
%
b = input('Enter numerator coefficients: ');
a = input('Enter denominator coefficients');
[z,p,k] = tf2zp(b,a);
m = abs(p);
disp('Zeros are at:'); disp(z);
disp('Poles are at:'); disp(p);
disp('Gain constant is:'); disp(k);
disp('Polee radii are:'); disp(m);
sos = zp2sos(z,p,k);
disp('Second order section coefficients are:'); disp(sos);
zplane(b,a);



