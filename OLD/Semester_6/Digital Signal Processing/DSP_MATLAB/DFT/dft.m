function X=dft(x)
%dft.m
% Diskrete Fourier-Transformation J.R. 25.11.01
% x : Eingangsfolge
% X : Spektrum
N = length(x);
w=exp(-j*2*pi/N);                   % Komplexer Exponent
X=zeros(1,N);                       % Initialisiere alle Komponenten mit 0
for k=0:N-1                         % Schleife über die Elemente der Folge
   for n=0:N-1                      % Summationsschleife
      X(k+1)=X(k+1)+x(n+1)*w^(k*n); % Summiere auf
   end
end
%end

