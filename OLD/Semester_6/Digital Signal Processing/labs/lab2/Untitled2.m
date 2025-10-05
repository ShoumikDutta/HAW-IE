clear all;

in = [2000 2000 -2000 -2000 0 0 0 0];
N = length(in);
Y = zeros(N);
n = 0 : N-1;
bit_rev = n;
stages = log10(N)/log10(2);

for ki = 0 : N-1
    in1 = bit_rev(ki);
    out = 0;
    for kx = 0 : stages-1
        in2 = in1 / 2;
        out=out*2+(in1-2*in2);
        in1=in2;
    end
    bit_rev(ki) = out;
end

W = exp(1i * 2 * pi * n / N / 2);

for index = 0 : N-1
    Y(2*index) = in(out) + W(index)
    Y(2*index+1) = in(out) - W(index)
end
	