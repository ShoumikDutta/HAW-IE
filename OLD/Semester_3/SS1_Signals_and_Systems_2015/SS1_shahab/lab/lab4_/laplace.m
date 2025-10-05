%%ss1 lab 4 excerise (b) aryan sultan- shahab shafie 02,01,2015
syms s t 
Y=laplace(heaviside(t)*(cos(2*t)+2*sin(2*t)),t,s);
pretty(Y)
