%Tobias Hör 13.04.03
%start1.m wird für das Starten der Simulation benötigt. 
%Es ist also das Startfile, das als erstes aufgerufen werden muß!
%Dieses mFile setzt alle Anfangsvariablen und ruft danach das mFile "button" auf

clear all;
close all;
global GENAUIGKEIT
GENAUIGKEIT=1*2^15;%Bit Genauigkeit Q15 Format
DREID=0;%Flagge zum auswählen der 3D Ansicht der Koeffizienten
GLEITEN=0;%Flagge für gleitendes µ
f9=0;%flagge für gleitendes µ Fenster
%Startwerte der Variablen
FREQUENZST=1000;
ABTASTFR=8000;
MUE=round(0.003*2^15);
FREQUENZERW=500;
AMPLITUDE=0.5;
ORDNUNG=21;
SAMPLES=256;
%Flagge für die Titeleingabe
TIT=0;
%Bildschirmgröße
scrsz = get(0,'ScreenSize');
%Aufruf des Auswahlfensters
button;
%start2;
