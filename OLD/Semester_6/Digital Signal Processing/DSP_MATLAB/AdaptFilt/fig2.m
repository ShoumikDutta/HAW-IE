%Tobias Hör
%fig2.m erstellt das Figure2 Fenster um die generierten Signale darzustellen

figure(2)
set(figure(2),'Position',[1 scrsz(4)/1.5 scrsz(3)/3 scrsz(4)/4]);
plot(t,stoerung,t,erwplusstoerung,t,ref);
axis([0 PLOTZEIT -GENAUIGKEIT GENAUIGKEIT]);
legend('Stoerung n[k]','gem.Signal d[k]','Referenz x[k]');
grid on;
xlabel('Zeit in sekunden');
ylabel('sin(t),cos(t),sin(t)+cos(t)');
if TIT==1
   d=get(h31,'String');
   title(d);
   TIT=0;
else
   title('Generierte Signale:Störung, Referenz und gemischtes Signal');
end
