%Tobias Hör
%fig5.m erstellt das Figure5 Fenster um die Signale nach der Filterung im 
%Frequenzbereich darzustellen

[h,w]=freqz(plotausgang1,1,SAMPLES);
[h1,w]=freqz(plotausgang2,1,SAMPLES);
[h2,w]=freqz(plotausgang,1,SAMPLES);
[h3,w1]=freqz(ploterror,1,SAMPLES);
[h4,w2]=freqz(erwplusstoerung,1,SAMPLES);
ff = (0:SAMPLES-1)/SAMPLES*(ABTASTFR/2);
amplh=abs(h);
amplh1=abs(h1);
amplh2=abs(h2);
amplh3=abs(h3);
amplh4=abs(h4);
figure(5)
set(figure(5),'Position',[scrsz(3)*2/3 scrsz(4)/3 scrsz(3)/3 scrsz(4)/4]);
plot(ff,amplh2,ff,amplh3);
grid on;
xlabel('Frequenz in HZ');
ylabel('Amplitude');
legend('y[k] nach 256 SAMPLES','e[k] nach 256 SAMPLES');
if TIT==1
 	d=get(h36,'String');
   title(d);
   TIT=0;
else
title('y[k] ist abhängig von e[k]');
end
