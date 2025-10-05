% program to display measurement results of simulation
%
% Hamburg University of Applied Sciences  
% Department of Informations- und Elektrotechnik
%
% Author: Prof. Dr.-Ing. Hans J.Micheel
%
% Date: 10.03.2009 	last change: 10.03.2009


a=1;
while a<3,
    
   a=menu('plot signal prop.:','spectrum (FFT)','waveform','Close');
     
	switch a,
   
case 1
   run GSPEK_P;
  
case 2
 	run KOSZI_P;

     
end;
end;