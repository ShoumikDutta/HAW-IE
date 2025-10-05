%SS1 LAB 1 EXC 6 22:10:2014 12.48 ARYAN SULTAN 
%Plot the following two signals in the time range 
% between t = 0s and t = 2s,given the frequencies f1 = 2Hz and f2 = 5Hz.,


%TASK (a)
t=0:0.01:2;
y=cos(2*pi*2*t);
plot(t,y,'r');
hold on 

%TASK (b)
t1=0:.01:1;
   y1=cos(2*pi*2*t1);


   t2=1:.01:2;
        y2=cos(2*pi*5*t2);
plot(t1,y1,'g');
hold on ;
plot(t2,y2,'b');
 
    end