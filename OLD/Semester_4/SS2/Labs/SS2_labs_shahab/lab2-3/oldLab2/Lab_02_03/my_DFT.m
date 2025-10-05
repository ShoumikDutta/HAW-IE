function output = my_DFT(x )

N = length(x);
output=zeros(size(x));
n = 1:N;

for k = 1:N
    Exp = exp(-1j*2*(n-1)*(k-1)*pi/N); 
    output(k)= x* Exp';
end

end
