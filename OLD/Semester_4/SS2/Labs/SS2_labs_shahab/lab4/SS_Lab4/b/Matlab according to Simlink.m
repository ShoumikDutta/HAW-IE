Ts=0.25 ; 
Fs= 1/Ts ; 
R=3 ; 
a=1/2 ; 
ws=2*pi*Fs ; 

n=0:Ts:ws ; 

plot(n.*Ts,abs(fft(simout))) ; 