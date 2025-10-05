function y = down_sample(x,M)
% y = down_sample(x,M)
% Downsample the input sequence x by introducing L-1 zeros between two x-samples each
%
y = x([1: M: length(x)]);
% end
