% limit_cyc.m (source: S.K.Mitra pp.640)
% Investigate granular limit cycles in 1st order filters
%
clf;
alpha = input('Enter the filter coefficient: ');
yi = input('Enter initial condition yi: ');
x = input('Enter the initial value x[0]: ');
b = input('Enter number of bits: ');
for n =1:21
   y(n) =a2dR(alpha*yi, b) + x; % 1st order equation
   yi = y(n); % Feedback
   x = 0; % Input quiet
end
k = 0:20;
stem(y,k)
ylabel('Amplitude');xlabel('Time index n');
title(['\alpha = ' num2str(alpha)]);
%end
