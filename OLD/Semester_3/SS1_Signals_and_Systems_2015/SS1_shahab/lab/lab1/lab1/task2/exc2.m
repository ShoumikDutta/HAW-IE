%ss1 lab1 exc 2 19.10.2014 9:10 Aryan Sultan 
a=[4 2 5];
b=[3 8 9];
num=a*b';%numinator 
absa=sqrt((4^2)+(2^2)+(5^2)); % abslout value of a 
absb=sqrt((3^2)+(8^2)+(9^2));% abslout value of b
dinum=absa*absb; %dinuminator 
ang_rad=acos(num/dinum); %arc cos angle in radian 
ang_deg=((ang_rad*180)/pi);%calculation to achive angle in degree
result=['angle in radian   ' num2str(ang_rad) '  angle  in degree  ' num2str(ang_deg)]

%second appraoch 


phi=acos(dot(a,b)/(norm(a)*norm(b)))/pi*180;
