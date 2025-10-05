% SS1 LAB 1 EXC 7  22.10.2014 13:51 Aryan Sultan 
%The frequency response of an RC-circuit is given by
%H( jw) =1/1 + jwRC.
%(a) Plot jH( jw)j for RC = 10s on a linear frequency scale between 0 and 1000 1/s
%(b) Plot  A( jw) = 20 lg(H(jw)on a logarithmic frequency scale within the frequency range specified in Ex. 
%7a).(Hint: log10 calculates the base ten logarithm.)


%TASK(a)
f=0:1:1000;
RC=10;
omegaRC=2*pi*f*RC;
H=1./sqrt(1^2+(omegaRC).^2);
plot(f,H);


%TASK(b)

A=20*log(H);

bode(f,A);

