%cosdft.m.m
%J.R. 22.06.03 Source:. M.Werner S. 39
% DFT Spektrum einer Cosinus-Folge bzw. anderer Funktionen
N=32;             % Länge der Folge
n=0:N-1;          % Normierte Zeit
x=zeros(1,N);     % Initialisierung (nur t.w. erforderlich)
Omega=pi/8;       % Normierte Winkelfrequenz
%x=cos(Omega*n);                                                %cos pi/8
%x=0.75*cos(Omega*n) + 0.25*cos(2*Omega*n);   % .75*cos pi/8 + .25*cos pi/4
%x=0.75*cos(Omega*n) + 0.25*sin(2*Omega*n);   % .75*cos pi/8 + .25*sin 2*pi/4
%x(3)=1;                                                                           % Delta-Funktion mit n0=2 (beachte: wir beginnen beim Index 0!)
x=exp(j*Omega*n);                                                                   % Komplexe Exp. Funktion

X=dft(x);

%graphics
FIG=figure('Name','DFT-Example','NumberTitle','off','Units','normal');
subplot(2,2,1), stem(n, real(x));     % Realteil des Signals
axis([0 N-1 -1 1]);
grid,xlabel('n\rightarrow'),ylabel('Re\{x[n]\}\rightarrow')
subplot(2,2,2), stem(n, imag(x));     % Imagnärteil des Signals
axis([0 N-1 -1 1]);
grid,xlabel('n\rightarrow'),ylabel('Im\{x[n]\}\rightarrow')
subplot(2,2,3), stem(n, real(X));
MAX=max(abs(X));
axis([0 N-1 -MAX MAX]);
grid,xlabel('k\rightarrow'),ylabel('Re\{X[k]\}\rightarrow')
subplot(2,2,4), stem(n, imag(X));
axis([0 N-1 -MAX MAX]);
grid,xlabel('k\rightarrow'),ylabel('Im\{X[k]\}\rightarrow')
%end

