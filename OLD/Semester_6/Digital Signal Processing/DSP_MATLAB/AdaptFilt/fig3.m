%Tobias Hör
%fig3.m erstellt das Figure3 um die generierten Signale im Frequenzbereich darzustellen

%*******************Alle generierten Signale im Frequenzbereich*********************************
ff = (0:SAMPLES-1)/SAMPLES*(ABTASTFR/2);
[h,w]=freqz(stoerung,1,SAMPLES);
[h1,w]=freqz(erwplusstoerung,1,SAMPLES);
[h2,w]=freqz(ref,1,SAMPLES);
amplh=abs(h);
amplh1=abs(h1);
amplh2=abs(h2);
figure(3)
set(figure(3),'Position',[scrsz(3)/3 scrsz(4)/1.5 scrsz(3)/3 scrsz(4)/4]);

plot(ff,amplh,ff,amplh1,ff,amplh2);
grid on;
legend('Stoerung n[k]','gem.Signal d[k]','Referenz x[k]');
xlabel('Frequenz in HZ');
ylabel('Amplitude');
if TIT==1
 	d=get(h34,'String');
   title(d);
   TIT=0;
else
   title('Frequenzanteile der Signale');
end
