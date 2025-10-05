% partial_fraction.m
% Calculate partial fraction expansion of a z-transform.
% using residuez.
% See Ifeachor Example 4D.3 p.235 (Note numerical discrepancies!)
b = [1 2 1];
a = [1 -1 0.3561];
[r,p,k] = residuez(b,a)
zplane(b,a); % Display poles and zeros
radius = abs(r);



   
