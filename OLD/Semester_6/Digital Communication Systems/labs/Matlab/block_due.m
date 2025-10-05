%program to open dig. comm. exercise toolboxes
%
% Hamburg University of Applied Sciences  
% Department of Informations- und Elektrotechnik
%
% Author: Prof. Dr.-Ing. Hans J.Micheel
% Date: 10.03.2009 
% This version by Prof. Dr. Rainer Schoenen
% Date: 10.03.2015 

function y=block_due(x)

% opens project step 1 work file
if x=='STP1',
   open_system('STEP1_W');					% empty file 
end;

% opens project step 2 work file
if x=='STP2',
   open_system('STEP2_W');					% empty file 
end;

% opens project step 3 work file
if x=='STP3',
   open_system('STEP3_W');					% empty file 
end;

% opens project step 4 work file
if x=='STP4',
   open_system('STEP4_W');					% empty file 
end;
% 
%if x=='SPEC',
%  open_system('Spektral_Messtechnik');
%   open_system('SPEC_W');	
%end;

% opens library file with system module blocks
if x=='METO',
   open_system('measurement_tools');
end;

% opens library file with useful measurement tool blocks
if x=='SYST',
   open_system('system_blocks');
end;


if x=='Help',
   clc;
   disp('***********************************************')
   disp('.                                             .')
   disp('. For obtaining help about this exercise      .')
   disp('. please start Microsoft Word and open        .')
   disp('. the file HELP.doc in the current directory  .')
   disp('.                                             .')
   disp('. Um Hilfe zu diesem Versuch zu erhalten      .')
   disp('. starten Sie bitte Microsoft Word und öffnen .')
   disp('. die Datei HILFE im aktuellen Verzeichnis    .')
   disp('.                                             .')
   disp('***********************************************')
end;
