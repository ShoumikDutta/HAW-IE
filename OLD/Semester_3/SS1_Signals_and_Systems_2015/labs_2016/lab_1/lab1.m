% number of samples
% since the fastest  frequency of the
% original signal period is f = 8
% fs = 1/Ts = 16
% to meet the sampling theorem
% and n < Ts/T = 25
n = 15;

% factor that multiplies n
down_factor = 2;
T = 0.0025;

[t, x , ts, xs] = ss2_problem1(n);

% recontructing original signal from samples
Ts = n*T;
xr = t;
for it=1 : length(t)
    xr(it) = 0;
    for k=1 : length(xs)
        xr(it) = xr(it) + xs(k)*sinc((t(it) - k*Ts)/Ts);
    end
end

figure('name','Sampling theorem');

subplot(3,2,1);
plot(t, x);
xlabel('t');
ylabel('x(t)')
title('Original signal');

subplot(3,2,3);
stem(ts, xs);
xlabel('t');
ylabel('xs(t)')
str = sprintf('Sampled signal, n = %d', n);
title(str);

subplot(3,2,5);
plot(t, xr);
xlabel('t');
ylabel('xr(t)')
title('Reconstructed signal');

% downsample
xs_d = downsample(xs, down_factor);
ts_d = downsample(ts, down_factor);

xr_d = t;
Ts_d = n*T*down_factor;

for it=1 : length(t)
    xr_d(it) = 0;
    for k=1 : length(xs_d)
        xr_d(it) = xr_d(it) + xs_d(k)*sinc((t(it) - k*Ts_d)/Ts_d);
    end
end

% xr_d = xr_d + xs_d*sinc((t - k*Ts_d)/Ts_d);


subplot(3,2,4);
stem(ts_d, xs_d);
xlabel('t');
ylabel('xs_d(t)')
str = sprintf('Down-Sampled signal, n = %d', n*down_factor);
title(str);


subplot(3,2,6);
plot(t, xr_d);
xlabel('t');
ylabel('xr_d(t)')
title('Reconstructed signal');
