function result = my_conv(a,b)
%result = my_conv(a,b) calculates the convolution of a and b vectors
L = length(a) + length(b) -1; % Calculate the length of the convolution vector
result = zeros(1,L);          % Zero the 1-D output vector
for i = 1:length(a)           % Loop the a-vector
   for j = 1:length(b)        % Loop the b-vector
      result(i+j-1) = result(i+j-1) + a(i)*b(j); % Accumulate partial products
   end
end


