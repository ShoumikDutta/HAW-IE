function [H,W] = dtft(h,N)
% DTFT Calculate DTFT at N equally spaced frequencies
%    usage: H=dtft(h,N)
%           h: finite-length input vector, whose length is L
%           N: number of frequencies for evaluation over [-pi, pi)
%              constarint: N >= L !
%           H: complex DTFT values
%           W: vector of frequencies where DTFT is computed
%    Ref: McClellan et.al.: Signal Processing using Matlab-5 p.14
%    J.R. 23.06.03 
N = fix(N);
L = length(h); h= h(:); % for vectors only
if ( N<L )
   error('DTFT: # data samples cannot exceed # freq samples!');
end
W = (2*pi/N) * [0:(N-1) ]'; % generate column vector W using transpose operator
n = 0 : N-1;
mid = ceil(N/2) + 1; % ceil rounds towards infinity
W(mid:N) = W(mid:N) -2*pi; % move [pi,2pi) to (-pi, 0)
W =fftshift(W); % move negative frequency components
H = fftshift( fft(h,N)); % calculate FFT and move negative frequency components
