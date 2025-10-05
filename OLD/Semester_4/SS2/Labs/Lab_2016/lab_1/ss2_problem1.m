function [ t , x , ts, xs ] = ss2_problem1( n )
%SS2_PROBLEM1 omputes original and sampled signal
%   x = original signal, sx = sampled signal
T = 0.0025;

% compute original signal
t = 0.0025 : T : 1;
x = 4*sin(2*pi()*t) + cos(pi()/4 +16*pi()*t);

% compute sampled signal
Ts = T*n;
ts = 0.0025 : Ts : 1;
xs = 4*sin(2*pi()*ts) + cos(pi()/4 +16*pi()*ts);

end

