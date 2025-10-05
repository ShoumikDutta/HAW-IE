t=-10:10;
x=size(t);
x(1:10)=0;
x(11)=0.5;
x(12:21)=1;
[xe,xo]=evenodd(x);


subplot(4,1,1);
plot(t,x)
title('signal')
axis([-10 10 min(x)-2 max(x)+2]);
set(gca , 'XTick',-10:10);
subplot(4,1,2);
plot(t,xe)
title('even part')
axis([-10 10 min(x)-2 max(x)+2]);
set(gca , 'XTick',-10:10);
subplot(4,1,3);
plot(t,xo)
title('odd part')
axis([-10 10 min(x)-2 max(x)+2]);
set(gca , 'XTick',-10:10);
subplot(4,1,4);
plot(t,xe+xo)
title('sum')

axis([-10 10 min(x)-2 max(x)+2]);
set(gca , 'XTick',-10:10);