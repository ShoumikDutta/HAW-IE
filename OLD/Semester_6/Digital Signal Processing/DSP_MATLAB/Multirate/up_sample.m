function y = up_sample(x,L)
% y = up_sample(x,L)
% Upsamples the input sequence x by introducing L-1 zeros between two x-samples each
%
y = zeros(1, L*length(x));
y([1: L: length(y)]) = x;
% end
