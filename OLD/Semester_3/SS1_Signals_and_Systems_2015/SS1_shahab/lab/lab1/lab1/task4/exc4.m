%SS1 lab1 exc 4 19.10.2014 10:09 Aryan Sultan shahab shafie
%THE TAYLOR EXPANSION OF THE SINE FUNCTION 
%i seprated the negative and positive parts of the formula and added up all
%negative together and all positive together 
x=pi/6;
minus=0;
plus=0;
result=0;
result1=0;
for k=1:3
    for j=1:+4:10
plus=(x^j/factorial(j));%positive sums 
  outj=['j=' num2str(j)];
    disp(outj);
     
    for i=3:+4:11
minus=(x^i/factorial(i));%negative sums 

       outi=['i=' num2str(i)];
            disp(outi);


    end
    result1=plus-minus;
    end
    result=result+result1;

end

second aprroach 

i = 1;
summe=0;
summand=1;
while(abs(summand)>10^(-8))
    summand((-1)^(i+1)*((-pi/2)^(2*i-1)))/(factorial(2*i-1)));
    summe=summe+summand;
    i=i+1;
end
