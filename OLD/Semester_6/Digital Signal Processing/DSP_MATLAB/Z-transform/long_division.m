% long_division.m
% Inverse z-transform using the polynomial division approach.
% Calculates X(z)=(1 + 2z^-1 + z^-2) / (1 - z^-1 + 0.3561z^-2)
% using deconv.
% See Ifeachor Example 4D.1 p.233
b = [ 1 2 1]; %Numerator coefficients
a = [1 -1 0.3561]; % Denominator coefficients
zplane(b,a);
n = 5; % Desired number of x coefficients
b=[b zeros(1, n-1)]; % Append n-1 zeros to b
[x,r] = deconv(b,a);
disp(x);
disp(r);

   
