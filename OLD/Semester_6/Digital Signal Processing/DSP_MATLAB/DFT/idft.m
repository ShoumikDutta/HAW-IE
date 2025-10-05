function x=idft(X)
%idft.m
% Diskrete inverse Fourier-Transformation J.R. 2.12.01
% X : Eingangsspektrum
% x : Rücktransformierte Folge
N = length(X);
w=exp(+j*2*pi/N);                   % Komplexer Exponent
x=zeros(1,N);                       % Initialisiere alle Komponenten mit 0
for k=0:N-1                         % Schleife über die Elemente der Folge
   for n=0:N-1                      % Summationsschleife
      x(k+1)=x(k+1)+X(n+1)*w^(k*n); % Summiere auf
   end
end
 x=x/N;                             % Normiere alle Folgenelemente
%end

