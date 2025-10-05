function [sys,x0,str,ts] = compress(t,x,u,flag,ck,A)
% Dispatch the flag. The switch function controls the calls to 
% S-function routines at each simulation stage.
switch flag,

   case 0
     [sys,x0,str,ts] = mdlInitializeSizes; % Initialization

   case 3
     sys = mdlOutputs(t,x,u,ck,A); % Calculate outputs

   case { 1, 2, 4, 9 }
     sys = []; % Unused flags

   otherwise
     error(['Unhandled flag = ',num2str(flag)]); % Error handling
end;
% End of function timestwo.
 %============================================================== 
% Function mdlInitializeSizes initializes the states, sample 
% times, state ordering strings (str), and sizes structure.
%==============================================================
function [sys,x0,str,ts] = mdlInitializeSizes
% Call function simsizes to create the sizes structure.
sizes = simsizes;
% Load the sizes structure with the initialization information.
sizes.NumContStates= 0;
sizes.NumDiscStates= 0;
sizes.NumOutputs=    1;
sizes.NumInputs=     1;
sizes.DirFeedthrough=1;
sizes.NumSampleTimes=1;
% Load the sys vector with the sizes information.
sys = simsizes(sizes);
%
x0 = []; % No continuous states
% 
str = []; % No state ordering
% 
ts = [-1 0]; % Inherited sample time

% End of mdlInitializeSizes.
%==============================================================
% Function mdlOutputs performs the calculations.
%==============================================================
function sys = mdlOutputs(t,x,u,ck,A)

	if abs(u)<ck/A, sys = u/ck;
	else sys = sign(u)*(exp((1+log(A))*abs(u) - 1))/A;
	end;


% End of mdlOutputs.