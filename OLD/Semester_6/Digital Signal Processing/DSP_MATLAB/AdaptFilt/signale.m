function [s,r,e,e_s]=signale(samples,abtastfr,amplitude,frequenzst,frequenzerw)
%Tobias Hör 13.04.03
%Signalgenerierung 
%signale(samples,abtastfr,amplitude,frequenzst,frequenzerw)
%Generiert eine Sinusschwingung der, mit frequenzst, angegebenen Frequenz (Störsignal d[k])
%Generiert eine Cosinusschwingung der, mit frequenzst, angegebenen Frequenz (Referenzsiganl x[k])
%Generiert eine Cosinusschwingung der, mit frequenzerw, angegebenen Frequenz (erwünschtes Signal s[k])
%Addiert d[k] und s[k] um ein gestörtes Signal zu erhalten
%gibt die generierten Signale zurück in der Reihenfolge: d[k], x[k], s[k], s[k]+d[k]
global GENAUIGKEIT
for i=1:samples;
   stoerung(i) =(round(amplitude*sin(2*pi*(i-1)*frequenzst/abtastfr)*GENAUIGKEIT)); %Samples von 1000Hz sin-Signal
%****************************%auf 16 bit skalieren***********************************************   
if stoerung(i)>32767 
   stoerung(i)=32767;
   end 
   if stoerung(i)< -32768
      stoerung(i)=-32768;
   end
%************************************************************************************************
   ref(i)=(round(amplitude*cos(2*pi*(i-1)*frequenzst/abtastfr)*GENAUIGKEIT));
   if ref(i)>32767
      ref(i)=32767;
   end 
   if ref(i)< -32768
      ref(i)=-32768;
   end
   erwuenscht(i)=(round(amplitude*cos(2*pi*(i-1)*frequenzerw/abtastfr)*GENAUIGKEIT)); %Samples von 500Hz cosinus-Signal
   erwplusstoerung(i)=stoerung(i) + erwuenscht(i); 
	if erwplusstoerung(i)>32767
      erwplusstoerung(i)=32767;
   end 
   if erwplusstoerung(i)< -32768
      erwplusstoerung(i)=-32768;
	end
end
s=stoerung;
r=ref;
e=erwuenscht;
e_s=erwplusstoerung;
