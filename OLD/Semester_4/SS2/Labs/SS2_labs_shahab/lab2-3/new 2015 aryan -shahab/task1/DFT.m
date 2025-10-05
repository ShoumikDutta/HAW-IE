function [ X ] = DFT( input )
%step1------------
%making the u1 * k . n 
N=length(input);


n=0:N-1;
k=0:N-1;
%k=-N/2:N/2-1%k for negative values 

y=n';
% The result is a 2D array such that 
u1=y*k;




%step 2 -------------- 
 
% the columns vary as k varies and rows vary as n varies
u2=exp(-1i*u1*2*pi/N);

%step 3 -----------------------------


xMat=input'*ones(1,N);
%step4----------

argMat=u2.*xMat;
%step 5 ---------------------
% We take the sum in row direction ( n direction)
X=sum(argMat,1);


end
