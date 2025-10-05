% sec_ord_inv_z.m
% Inverse z-transform for a second-order system using polynomial division.
% Calculates X(z)= N1(z)/D1(z)* N2(z)/D2(z)* N2(z)/D2(z)
% using sostf and deconv.
% See Ifeachor Example 4D.2 and 4D.4 p.233 and p.236
%(Note some numerical discrepancies!)
n = 5; % Number of power series points
N1 = [1 -1.22346 1]; D1 = [1 -1.433509 0.85811]; % First stage
N2 = [1 1.474597 1]; D2 = [1 -1.293601 0.556929]; % Second Stage   
N3 = [1 1 0]; D3 = [1 -0.612159 0]; % Third  stage
B = [N1; N2; N3]; % setup B-matrix from 3 row-vectors
A = [D1; D2; D3]; % setup A-matrix from 3 row-vectors
[b,a] = sos2tf([B A]); % Calculate transfer function from second order stages
[r,p,k] = residuez(b,a); % calculate partial fraction expansion
r
p
k
b = [b zeros(1,n-1)];
[x,r] = deconv(b,a); % perform long division
x
r
zplane(b,a); % Display poles and zeros



   
