% KOSZI_P.M: Menügesteuertes 3-Kanal Oszilloskop für 3 Vektoren des Workspace
% Gerdsen, Kröger: Digitale Signalverarbeitung
% 17:03  13.08.1995
% Autor: Kröger
% Datei: KOSZI_P.M
%
% Menügesteuertes Mehrkanaloszilloskop zum Plotten von im Workspace befindlichen
% Vektoren.
% Das Programm verarbeitet einen Vektor t_clock für Zeitwerte auf
% der Abzisse. In Simulink erzeugt man diesen Vektor durch Anschluß
% eines Vektors t_clock an das Standard-CLOCK-Symbol
% oder durch Benutzung eines besonderen Symbols t_clock in der Simulink-Bibliothek
% SIMU_S (siehe Symbol unter Sinken).
% Wenn dieser Vektor nicht existiert, verwendet das Programm als Abzissenwerte automatisch
% Folgennummern (1, 2, 3..).
%
% Der x-Bereich und der y-Bereich sind einstellbar. Bereichsgrenzen im
% x-Bereich beziehen sich auf aktuelle Werte (Folgennummer oder Absolut-
% zeiten).
%
% Nach Erzeugen des Plots (Menüpunkt Plot) bleibt der Plot im Vordergrund
% stehen. Durch Drücken der Leertaste gelangt man in das Menü zurück.

% Weitere Features: X-Beschriftung, y-Beschriftung, Titel-Beschriftung
%                   Drucken
%
% Achtung: Bereichseinstellung y-Ychsen und Drucken noch nicht implementiert.

clc;
c = 1;
m=2;
abzisse=0;
ordinate=0;
titel='';
xeinheit='';
y1einheit='';
y2einheit='';
y3einheit='';
xmin=1; xmax=1;
s1='r'; s2='r'; s3='r';


while m < 6
    m = menu('Oszilloskop','Kanäle','Einstellungen','Plot','Drucken','Hilfe','Ende');
    
    if m == 1
        c=menu('Kanalwahl','1-Kanal','2-Kanal','3-Kanal');
        if c >= 1
            y1=input('Name Kanal 1:  ');
            tt=1:length(y1);
            t_clock_exist=exist('t_clock');
            if t_clock_exist==1 tt=t_clock; end;
            if abzisse==0 xmin=1; xmax=length(tt); end;
        end;
        if c > 1
            y2=input('Name Kanal 2:  '); end;
        if c > 2
            y3=input('Name Kanal 3:  ');end;
    end;
    
    if m == 2
        % Einstellungen
        e=1;
        while e<5
            e=menu('Einstellungen','Abzisse','Ordinate(n)','Titel','Style','Zurück');
            if e==1
                %Abzisse
                eabz=1
                while eabz<4
                    eabz=menu('Abzisse','Gesamtbereich','Auschnitt von/bis','Einheit','Zurück');
                    if eabz==1
                        abzisse=0;
                        xmin=1; xmax=length(tt);
                    end;
                    
                    if eabz==2
                        abzisse=1;
                        clc;
                        start_wert=input('Startwert:    ');
                        end_wert=  input('Endwert:      ');
                        index_min=find(tt>=start_wert);
                        index_max=find(tt>=end_wert);
                        xmin=index_min(1);
                        xmax=index_max(1);end;
                    
                    if eabz==3
                        clc;
                        xeinheit=input('Einheit Abzisse (Text):  ');end;
                end;
            end;
            
            if e==2
                %Ordinate(n)
                eord=1;
                while eord < 4
                    eord=menu('Ordinate(n)','Auto-Bereich','Von/Bis','Einheit(n)','Zurück');
                    
                    if eord==1
                    end;
                    
                    if eord==2
                    end;
                    
                    if eord==3
                        eord_einheit=1;
                        while eord_einheit < 4
                            eord_einheit=menu('Einheiten Ordinate(n)','Kanal 1','Kanal 2','Kanal 3','Zurück');
                            if eord_einheit==1
                                y1einheit=input('Einheit Kanal 1 (Text):  '); end;
                            if eord_einheit==2
                                y2einheit=input('Einheit Kanal 2 (Text):  '); end;
                            if eord_einheit==3
                                y3einheit=input('Einheit Kanal 3 (Text):  '); end;
                        end;
                    end;
                end;
            end;
               
            if e==3
                %Titel
                clc;
                titel=input('Geben Sie einen Titel ein (Text):  ');
            end;
            
            if e==4
                %style
                clc;
                s1=input('Style Kanal 1 (Zeichenkette):  ');
                if c>1 s2=input('Style Kanal 2 (zeichenkette):  '); end;
                if c>2 s3=input('Style Kanal 3 (Zeichenkette):  '); end;
            end;
            
        end;
    end;
    
    if m == 3
        % Plot
        subplot(c,1,1);
        plot(tt(xmin:xmax),y1(xmin:xmax),s1);
        if c==1 xlabel(xeinheit);end;
        ylabel(y1einheit);
        title(titel);
        grid;
        if c>1
            subplot(c,1,2);
            plot(tt(xmin:xmax),y2(xmin:xmax),s2);
            if c==2 xlabel(xeinheit); end;
            ylabel(y2einheit)
            grid;end;
        if c>2
            subplot(c,1,3);
            plot(tt(xmin:xmax),y3(xmin:xmax),s3);
            if c==3 xlabel(xeinheit); end;
            ylabel(y3einheit)
            grid;end;
        pause;
    end;
    
    
    if m == 4
        % Drucken
        % print; funktioniert bei manchen Rechnern nicht !!!!!
    end;
    
    if m == 5
        % Hilfe
        clc;
        help koszi_p;
        pause;
    end;
    
end;
