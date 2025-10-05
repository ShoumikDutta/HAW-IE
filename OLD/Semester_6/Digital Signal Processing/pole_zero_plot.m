fs = input(' Enter Sample frequency /Hz ');
Ts = 1/fs;
num = input(' Enter Transfer function numerator coeffs [Cn*z^-n +...+ C1*z^-1 + C0] ');
den = input(' Enter Transfer function denumerator coeffs [Cm*z^-m +...+ C1*z^-1 + C0] ');
H = tf(num, den, Ts);
% set(H,'Variable','z^-1');display(H);
[poles,zeros] = pzmap(H)
pzmap(H)