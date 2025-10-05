%%exc c 
syms s t Y 
ode='D(D(y))(t)+3*D(y)(t)+2*y(t)=exp(-t)*heaviside(t)';%% our differential equation.
%%----------------------part (i) ---------------------
ltode=laplace(ode,t,s);%apply the Laplace transform to both sides of our equation. 
pretty(ltode)
%%.---------------------part(ii)-------------------------
eqn=subs(ltode,{'laplace(y(t),t,s)','y(0)','D(y)(0)'},{Y,0,0});
%replace laplace(y(t),t,s) by Y and also plug in our initial conditions
pretty(eqn)
Y=solve(eqn,Y);
pretty(Y)
%%------------------------part(iii)------------------------------
y=ilaplace(Y,s,t);%y(t) by inverting the Laplace transform
pretty(y)
