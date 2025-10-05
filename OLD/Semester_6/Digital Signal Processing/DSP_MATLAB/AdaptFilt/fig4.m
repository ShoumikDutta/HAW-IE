%Tobias Hör
%fig4.m erstellt das Figure4 um die Signale nach der Filterung darzustellen

figure(4)
set(figure(4),'Position',[scrsz(3)*2/3 scrsz(4)/1.5 scrsz(3)/3 scrsz(4)/4]);
plot(t,ploterror,t,plotausgang,t,stoerung,t,erwuenscht);
axis([0 PLOTZEIT -GENAUIGKEIT GENAUIGKEIT]);
grid on;
legend('Error e[k]','Filterausgang y[k]','Störung n[k]','erwünschtes Signal s[k]');
xlabel('Zeit in sekunden');
ylabel('Amplitude');
if TIT==1
 	d=get(h35,'String');
   title(d);
   TIT=0;
else
title('adaptives Filter geht in das erwünschte Signal über ');
end
