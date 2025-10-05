% clock_recovery.m
% Clock recovery filter for 4.8 kbaud
% Based on Ifeachor example 13.8
% 4.09.03 /rch 
% Generate an input sequence
k=1:500;
x = zeros(1,500);
x(1)=1; x(100)=1; x(400)=1; % accidental excitations
dig = zeros(1,500); % holds digital output

num = [1, 0, 0];
den = [1, -1.957558, 0.995913]; % From Ifeachor

y = filter(num,den,x); % Calculate filter response for x 

for j=k % Calculate digital output
   if y(j) >0 % Simple Schmitt-Trigger model
      dig(j)=1;
   else
      dig(j)=0;
   end
end
subplot(2,1,1);
plot(k,y,k,x,'r+');
title('Filter excitation and filter output')
subplot(2,1,2);
plot(k,dig);
title('Digital output')
axis([0,500,-0.5,1.5])




