% lab_fft.m
% Tests the FFT routine of the lab for a Mpoint input (Npts=2^N)
% J.R. 20.3.03

N=6;                  % 64 point fft
Npts = 2^N;
xn = zeros(Npts);     % We start with index 1
xn(1)= 1000;
xn(2) = 1000;
xn(3) = 1000;
xn(4) = 1000;
%for i=1:Npts          % Completely filled with 1000!
%   xn(i) = 1000;
%end

Xk = fft(xn);           % Do the FFT

%subplot(1,2,1);         % Left subplot
plot([0:Npts-1],real(Xk(1:Npts))) %Plot the FFT magnitude
title('FFT Real-Values');
xlabel('Index'); ylabel('Re(Xk[k])');
