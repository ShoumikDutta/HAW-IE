% conv_linear.m
% Illustration of Convolution
% Version 11.10.01 / kzr
x = input('Type in the first sequence (in square brackets)= ');
h = input('Type in the second sequence (in square brackets)= ');
y = conv(x, h);   % Use library function
%y = my_conv(x,h); % Use own convolution function
L = length(y) - 1 ;
k = 0:1:L;
disp('output sequence ='); disp(y);
% end
