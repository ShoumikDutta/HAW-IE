function  ss2_problem1( n )% n control the sampling freq
T=0.0025;
Ta=T*n;
t=0.0025:T:1;
x_t=4*sin(2*pi*t)+cos(pi/4+16*pi*t);
%y-Axe
xn=downsample(x_t,n);% and the corresponding time values
tn=downsample(t,n);
%-------------------------------------
subplot(3,1,1)
plot(t,x_t)
hold on
plot(tn,xn,'xr')
%---------------------------------
% time-discretized signal
subplot(3,1,2)
plot(tn,xn)
hold on
plot(tn,xn,'xr')
% Reconstruction of the continuous signal from the sampled values
x_r=0*t;
k=length(xn);
for i=1:k
x_r = x_r + xn(i)*sinc((t-(i-1)*Ta)/Ta);
end
%  From the time-discrete signal reconstructed continuous signal
%-----------------------------------------------------------------
subplot(3,1,3)
plot(t,x_r)
hold on
plot(tn,xn,'xr')
hold on
plot(t,x_t,'g')
end