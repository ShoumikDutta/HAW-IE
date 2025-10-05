function out = FFT_a(in)
   % clear
   % close('all');

    N = length(in);
    n = 0:N-1;
    one = ones(size(in))';
    y_2D = (one*in)';
    k = n';
    W = exp(-1i*k*n*2*pi/N);
    Y = y_2D .* W;
    out = sum(Y);
end

