% SS1 lab 1 exc 3 19.10.2014 9:29 Aryan Sultan 
%First approach is to calculate result  with the formula of
%these sum series which is for a =(n(n+1))/2 and for b=(n(n+1)(n+2))/6
%the second approach is to calculate the sum by using the for loop and
%adding up them together.

%First approach 

 k=100;
        resulta=(100*101)/2;
        resultb=(100*101*((2*100)+1))/6;
first=['First approch: a=' num2str(resulta) ' b=' num2str(resultb)];
disp(first);

% Second approach 
suma=0;
for i=0:100
suma=suma+i;
end
sumb=0;
for i=0:100
sumb=sumb+(i^2);
end
second=['Second approch: a=' num2str(suma) ' b=' num2str(sumb)];
disp(second);