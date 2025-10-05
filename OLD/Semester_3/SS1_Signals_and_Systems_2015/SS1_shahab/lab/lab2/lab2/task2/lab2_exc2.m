%SS1 LAB 2 exc 2 lab 2 

ak=0;
t=0:0.001:1;
y=0;
for k=1:2:100
    
    bk=4/(k*pi);
    y=y+(bk*sin(2*pi*10*k*t));
   
end

plot(t,y);
title('FRIST PLOT WITH 100 STEP')
xlabel('time(t)')
ylabel('fourier')

