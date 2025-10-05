% limit_cyc_2ord.m (source: S.K.Mitra pp.643)
% Investigate overflow limit cycles in 2nd order all poles.
% Note that limit cycles are only observed for ROUNDING.
% The problem does not show up for truncation!
%
a1 = input('Enter a1 coefficient value: ');
a2 = input('Enter a2 coefficient value: ');
b = input('Enter number of bits: ');

%Initial conditions:
yi1 = 1; yi2 = -1;
%yi1 = -0.625; yi2 = -0.125;
for n =1:41
   y(n) = a1*yi1 + a2*yi2; % 2nd order equation
   y(n) = a2dR(y(n), b); % Rounding the sum
   yi2 = yi1; yi1 = y(n); % Feedback
end
k = 0:40;
stem(k,y)
ylabel('Amplitude');xlabel('Time index n');
title(['\alpha_1 = ' num2str(a1), '   \alpha_2 = ' num2str(a2)]);
%end
