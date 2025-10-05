function r=ueberl(wert)
%Tobias Hör 13.04.03 Vers.1.0
%Diese Funktion überprüft einen Überlauf aus dem 16 bit Zahlenbereich
%Ist ein Überlauf vorhanden, wird wie in einem realen 16bit System auf die andere Seite des Zahlenbereichs gesprungen
%Dazu ein Beispiel:
%32767+10=32777 => Überlauf; die Zahl wird in dieser Funktion neu berechnet:
%32767+10=-32768+9=-32759 =>diese Zahl wird ins Hauptprogramm zurückgegeben
%Daraus folgt eine Approximation eines 16bit Systems
if wert>32767
         wert=wert-32767;
         wert = -32768+wert;
      end
      if wert<-32768
         wert=wert+32768;
         wert=32767+wert;
      end
r=wert;