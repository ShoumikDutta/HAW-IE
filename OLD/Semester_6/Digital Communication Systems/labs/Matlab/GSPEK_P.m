% GSPEK_P .M: Spektrumanalyse analoger und digitaler Signale
% Gerdsen, Kröger.
% Autor: Gerdsen
% Datei: GSPEK_P.M
% 11:46  29.02.1996
% Spektrumanalysator mit 3 Kanaelen
% Quotient von 2 Spektren nach Betrag und Phase            
% Spektren als Einzelplot oder Subplot
% Ordinate linear oder logarithmisch
% Frequenzachse fuer Zahlenfolgen in bezogenen Frequenzen
%               fuer analoge Signale in Hertz
% Frequenzfenster: Default 0...0.5 bzw. 0...FA/2
% Abtastfrequenz FFAA wird von Datei t_clock übernommen.
% Existiert t_clock nicht, wird FFAA = 1 gesetzt.
% Ist FFAA > 1, so wird ein analoges Signal angenommem
% und entsprechend beschriftet.
           
clc;
disp('.');
disp(' S P E K T R U M A N A L Y S E ');
disp(' von Zahlenfolgen und analogen Signalen ');
disp('.');
disp('.');

clear name1;clear name2;clear name;
clear N;    clear fa;   clear fe;  clear femax;

lg=0;TTAA=1;FFAA=1; %Default
kanal1=0;kanal2=0;kanal3=0;

if exist('t_clock')==1 
   TTAA=t_clock(2)-t_clock(1);
   if TTAA > 0 , FFAA = 1/TTAA; end;
end;

mm=1;
while mm < 8
        mm=menu('Spektralanalyse :','Kanal1','Kanal2','Kanal3','Frequenzfenster','Ordinate: Default Linear','Spektralanalyse','Hilfe','Ende des Programms');
  	disp('.');
        if mm==1     %>>>>>>>>Kanal1
      	  name1=input(' Signal1                  = ');
          N= length(name1);fa=0;fe=((N-1)/N);kanal1=1;
        elseif mm==2 %>>>>>>>>Kanal2
      	  name2=input(' Signal2                  = ');
      	  N= length(name2);fa=0;fe=((N-1)/N);kanal2=1;
        elseif mm==3 %>>>>>>>>Kanal3
      	  name3=input(' Signal3                  = ');
      	  N= length(name3);fa=0;fe=((N-1)/N);kanal3=1;
        elseif mm==4 %>>>>>>>>Frequenzfenster
	       if (exist('name1')==1 | exist('name2')==1 | exist('name3')==1) & N > 3
               fa=input(' Anfangsfrequenz     = ');
               fa=fa/FFAA;
               femax=((N-1)/N)*FFAA;
               fprintf(' maximale Endfrequenz = %g',femax);
               fe=input(' Endfrequenz         = ');
               fe=fe/FFAA;
           end;
        elseif mm==5 %>>>>>>>>Ordinate
           lg=menu('Ordinate:','logarithmisch','linear'); 
        elseif mm==6 %>>>>>>>>Menu Spektralanalyse 
	       msp=1;
           while msp < 6
              msp=menu('Spektralanalyse','Spektrum1','Spektrum2','Spektrum3','Spektren Subplot','Quotient Spektrum2/Spektrum1','zurück');
              if msp==1 %--------Spektrum1
                 if exist('name1')==1 & isempty(name1)==0
                     n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                     ia=round(fa*N)+1;ie=round(fe*N)+1;
                     ff=f(ia:ie);
                     mag01=fft(name1,N);
                     mag1=abs(mag01);
                     magpl=mag1(ia:ie);
                     magpl=2*magpl/N;
                     if lg==1, magpl=20*log10(magpl/0.775); end;
                     subplot(111);
                     plot(ff,magpl,'r');
                     if FFAA==1 xlabel('relative Frequenz f´');end;
                     if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                     if lg==1   ylabel('Spektrum1 in dB'); end;
                     if lg==0   ylabel('Spektrum1 linear');end;
                     grid;
                 end; % if exists
              end; % if msp
              if msp==2 %--------Spektrum2
                  if exist('name2')==1 & isempty(name2)==0
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag02=fft(name2,N);
                      mag2=abs(mag02);
                      magpl=mag2(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end;
                      subplot(111);
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum2 in dB'); end;
                      if lg==0   ylabel('Spektrum2 linear');end;
                      grid; end;
              end; % if msp
              if msp==3 %--------Spektrum3
                  if exist('name3')==1 & isempty(name3)==0
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag03=fft(name3,N);
                      mag3=abs(mag03);
                      magpl=mag3(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end;
                      subplot(111);
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´'); end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum3 in dB'); end;
                      if lg==0   ylabel('Spektrum3 linear'); end;
                      grid;
                  end;
              end;
              if msp==4 %--------Spektren Subplot
                  if ((kanal1==1) & (kanal2==1)) %>>>> 1 & 2
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag01=fft(name1,N);
                      mag1=abs(mag01);
                      magpl=mag1(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end; 
                      subplot(211),
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum1 in dB'); end;
                      if lg==0   ylabel('Spektrum1 linear');end;
                      grid;
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag02=fft(name2,N);
                      mag2=abs(mag02);
                      magpl=mag2(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end;
                      subplot(212),
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum2 in dB'); end;
                      if lg==0   ylabel('Spektrum2 linear');end;
                      grid;
                  end;
                  if ((kanal1==1) & (kanal2==1) & (kanal3==1)) %>>> 1 & 2 & 3
                      subplot(311);
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag01=fft(name1,N);
                      mag1=abs(mag01);
                      magpl=mag1(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end;
                      
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum1 in dB'); end;
                      if lg==0   ylabel('Spektrum1 linear');end;
                      grid;
                      subplot(312);
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag02=fft(name2,N);
                      magpl=mag2(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end;
                      
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum2 in dB'); end;
                      if lg==0   ylabel('Spektrum2 linear');end;
                      grid;
                      subplot(313)
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag03=fft(name3,N);
                      mag3=abs(mag03);
                      magpl=mag3(ia:ie);
                      magpl=2*magpl/N;
                      if lg==1, magpl=20*log10(magpl/0.775); end;
                      
                      plot(ff,magpl,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA > 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Spektrum3 in dB'); end;
                      if lg==0   ylabel('Spektrum3 linear');end;
                      grid;
                  end;
              end
              if msp==5 %--------Quotient Spektrum2/Spektrum1
                  if exist('name1')==1 & isempty(name1)==0 & exist('name2')==1 & isempty(name2)==0
                      n=1:N;n=n-1;fb=n/N;f=fb*FFAA;
                      ia=round(fa*N)+1;ie=round(fe*N)+1;
                      ff=f(ia:ie);
                      mag02=fft(name2,N);
                      mag01=fft(name1,N);
                      quot=mag02(ia:ie)./mag01(ia:ie);
                      qmg=abs(quot);
                      if lg==1, qmg=20*log10(qmg); end;
                      qph=angle(quot)/pi;
                      subplot(211);
                      plot(ff,qmg,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA> 1 xlabel('Frequenz f in Hz'); end;
                      if lg==1   ylabel('Betrag in dB'); end;
                      if lg==0   ylabel('Betrag linear');end;
                      grid;
                      subplot(212);
                      plot(ff,qph,'r');
                      if FFAA==1 xlabel('relative Frequenz f´');end;
                      if FFAA> 1 xlabel('Frequenz f in Hz'); end;
                      ylabel('Winkel *pi');
                      grid;
                  end;
              end; % if msp
           end;
        elseif mm==7 %Hilfe
            clc;
            help gspek_p;
            pause ;
        end;
end;
%
%Ende des Programms








