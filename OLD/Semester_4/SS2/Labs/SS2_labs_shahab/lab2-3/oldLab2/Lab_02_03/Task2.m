fs = 8000;
To = 0.004;
Ts = 1/fs;
N = 2^nextpow2(To/Ts);

y = zeros(N);
for k = 1:N
    y(k+1) = rect((k+1)*Ts);
end

x = linspace(0,To,N);
plot(x,y);
title('RECT');
xlim([0, 5/1000]);
ylim([0,2]);
xlabel('Time domain');
ylabel('Amplitude Spectrum');
