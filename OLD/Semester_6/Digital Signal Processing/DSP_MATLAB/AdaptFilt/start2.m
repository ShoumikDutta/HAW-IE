%Tobias Hör 14.04.03
%Vers.1.0 Filterung läuft
%Vers.1.1 16.04.03: Fensteraufrufe eingebaut
%Vers.1.2 17.04.03: Fehler mit Vektorüberläufen beseitigt
%Vers.1.3 23.04.03: gleitendes µ mit eingebaut
%start2.m beinhaltet die Adaptive Filterung
%Am 23.04.03 ist die Berechnung des gleitenden µ hinzu gekommen
%Es werden die Funktionen "Signale" und "ueberl" benutzt
%Außerdem werden hier alle Fenster mFiles aufgerufen (fig2.m - fig9.m)
%alle erzeugten Vektoren löschen
clear stoerung;
clear ref;
clear erwuenscht;
clear erwplusstoerung;
clear coef;
clear eingang;
clear ploterror;
clear plotausgang;
clear plotcoef;
clear restfehler;
clear clean;
clear plotmue;
%Signale generieren
[stoerung,ref,erwuenscht,erwplusstoerung]=signale(SAMPLES,ABTASTFR,AMPLITUDE,FREQUENZST,FREQUENZERW);
%Plotzeit und Genauigkeit sind für die graphische Darstellung
PLOTZEIT=((1/ABTASTFR)*SAMPLES);
global GENAUIGKEIT
zaehl=0;
y=0;
z1=0;
gross=0;
%Speicher auf Null setzen
for i=1:ORDNUNG+1
   coef(i) = 0;
   eingang(i) = 0;
end

%t ist für die graphische Darstellung
t = ((1/ABTASTFR)*(0:SAMPLES-1));%Zeichne Graphik mit den drei Signalen über die Zeit
%Fenster mFiles aufrufen
Fig2;
Fig3;


%*************************************************************************************************

%adaptiver Algorithmus

h=1;   
for x=1:SAMPLES
   ausgang = 0;%Ausgangswert zuerst auf Null setzen, für neue Berechnung
   eingang(1) = ref(h);% neuen eingangs-sample (der Referenz der Störung)
   clean = erwplusstoerung(h);%neuen gestörten Eingangs-sample
   for i=1:ORDNUNG+1%Filterung starten
      ausgang = ausgang + (round(coef(i) * eingang(i)/(2^15)));%Filterausgangswert Berechnen
      ausgang=ueberl(ausgang);%16Bit Genauigkeit
   end
   error = clean - ausgang;%Fehlersignal Berechnen
   error=ueberl(error);%16Bit Genauigkeit
   restfehler(h)=error - erwuenscht(h);%restfehler wird für Fig8 gebraucht

   ploterror(x)=error;%Vektor erzeugen für die graphische Darstellung des errors
   plotausgang(x)=ausgang;%Alle Ausgangswerte speichern, zur späteren Darstellung
   if x<50
         plotausgang1(x)=plotausgang(x);
   end
   if x<100
         plotausgang2(x)=plotausgang(x);
   end
   if x<250
         plotausgang3(x)=plotausgang(x);
   end
   %gleitendes MUE*****************************************************************
if GLEITEN==1
   z=abs(eingang(1));
   y=y+z;
   zaehl=zaehl+1;
   if zaehl==ORDNUNG
   	zaehl=0;
      y=round(y/ORDNUNG);
      y=round(y*y/2^15);
      div=round(655*(y)/2^15);
      if div==0
         MUEmax=32767;
      else
         MUEmax=round(32767/div);
      end
      if MUEmax>=round(26214*MUE/2^15)&MUEmax<=round(6554*MUE/2^15)+MUE%zwischen +- 20%
         if MUEmax>(MUE+10)&MUE<32757
         	MUE=MUE+10;
      	elseif MUEmax<(MUE-10)&MUE>10
         	MUE=MUE-10;
         end
         gross=0;
      elseif MUEmax>=round(19660*MUE/2^15)&MUEmax<=round(13107*MUE/2^15)+MUE%zwischen +- 40%
         if MUEmax>(MUE+100)&MUE<32667
         	MUE=MUE+100;
      	elseif MUEmax<(MUE-100)&MUE>100
            MUE=MUE-100;
         end
         gross=0;
      end
      if gross==2
         gross=0;
      	if MUEmax>=round(13107*MUE/2^15)&MUEmax<=round(19661*MUE/2^15)%zwischen +-60%
         	if MUEmax>(MUE+1000)&MUE<31767
         		MUE=MUE+1000;
      		elseif MUEmax<(MUE-1000)&MUE>1000
            	MUE=MUE-1000;
         	else
            	MUE=MUEmax;
         	end
      	else
         	if MUEmax>(MUE+3000)&MUE<29767
         		MUE=MUE+3000;
      		elseif MUEmax<(MUE-3000)&MUE>3000
            	MUE=MUE-3000;
         	else
            	MUE=MUEmax;
         	end
      	end
   	else
      	gross=gross+1;
      end
         y=0;
   end
  plotmue(x)=MUE;
	end
%Filterkoeffizienten berechnen***************************************************
	temp=round(MUE*error/(2^15));%Diese Berechnung muß nicht in der Schleife passieren
   for i=ORDNUNG+1:-1:1
      temp1=round(temp*eingang(i)/(2^15));
      coef(i) = coef(i) + temp1;%Filtercoeffizienten Berechnen
      coef(i)=ueberl(coef(i));%16Bit überlauf überprüfen
      plotcoef(h,i)=coef(i);%für die graphische Darstellung der Koeffizienten

      if i ~=1 
         eingang(i) = eingang(i-1);%Eingangsdaten neu Sortieren
      end
   end
      if h==SAMPLES
      h=1;
   else
      h=h+1;
   end
end
%Fenster mFiles aufrufen
Fig4;
Fig5;
Fig6;
Fig7;
Fig8;
%Figure9 wird nur bei der aktivierung der Checkbox für das gleitende MUE angezeigt
if GLEITEN==1
f9=1;
figure(9)
[xb,yb] = stairs(plotmue);
plot(xb,yb)
axis([0 SAMPLES -32768 32767]);
grid on;
xlabel('Sample');
ylabel('MUE');
title('Verlauf von MUE');
elseif f9==1
   figure(9);
   close(9);
   f9=0;
end
