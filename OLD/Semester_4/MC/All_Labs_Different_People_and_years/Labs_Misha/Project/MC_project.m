n = 960000 + 410000;
x = 2/300 : 2/100 : 2;
y = 1 ./ sqrt(1 - power(x - 1, 2)); %sqrt(2 * x - power(x, 2));
y_sum = sum(y);
y = n * y / y_sum;
t = 1 : 100;
plot(t, y);