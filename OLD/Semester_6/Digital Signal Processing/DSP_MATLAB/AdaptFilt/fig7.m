%Tobias Hör
%fig7.m erstellt das Figure7 Fenster um den 7. Koeffizienten darzustellen

figure(7)
set(figure(7),'Position',[scrsz(3)/3 scrsz(2)+9 scrsz(3)/3 scrsz(4)/4]);
clear h;
h = 0:1:SAMPLES-1;
stairs(h,plotcoef(1:1:SAMPLES,7));
axis([0 SAMPLES -GENAUIGKEIT GENAUIGKEIT]);
grid on;
xlabel('Sample');
ylabel('Wert des Koeffizienten in Integer');
if TIT==1
 	d=get(h38,'String');
    title(d);
    TIT=0;
else
title('Veränderung des 7. Filterkoeffizienten über die Anzahl der Samples');
end
