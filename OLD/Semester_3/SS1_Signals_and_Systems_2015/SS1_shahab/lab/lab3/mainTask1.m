%ss1 lab 3 task 1 main function calculation of phase and magnitute spec
% shahab shafie aryan sultan 
%--------------------------------------------
f=[0:0,01:100];
T=1./f;
omega=2*pi*f;
%---------------------------------------------------
%task c magnitude and phase of delta and delta-1
a=computeFT_diracPulse(omega,0);
[magnitude0,phase0]=getMagPhaseSpectra_fromFTVec(a);

b=computeFT_diracPulse(omega,1);
[magnitude1,phase1]=getMagPhaseSpectra_fromFTVec(b);
figure
subplot(4,1,1);
plot(T,magnitude0);
title('Magnitude of \delta(t)')
xlabel('T(Period)')
ylabel('Magnitude')

subplot(4,1,2);
plot(T,phase0)
title('Phase Spectra of \delta(t)')
xlabel('T(Period)')
ylabel('Phase')


subplot(4,1,3);
plot(T,magnitude1)
title('Magnitude of \delta(t-1)')
xlabel('T(Period)')
ylabel('Magnitude')

subplot(4,1,4);
plot(T,phase1)
title('Phase Spectra of \delta(t-1)')
xlabel('T(Period)')
ylabel('Phase')
%-------------------------------------------------------
%task d magnitude and ohase of y(t)=delta(t)+delta(t-1) base on
%precalculation and matlab 
[ premag, prephase]=getMagPhaseSpectra_precalculated( omega );
c=a+b;
[magnitudec,phasec]=getMagPhaseSpectra_fromFTVec(c);

figure
subplot(4,1,1);
plot(T,premag);
title('Magnitude of precaculatuin y(t)')
xlabel('T(Period)')
ylabel('Magnitude')

subplot(4,1,2);
plot(T,prephase)
title('Phase Spectra of precalculation y(t)')
xlabel('T(Period)')
ylabel('Phase')


subplot(4,1,3);
plot(T,magnitudec)
title('Magnitude of y(t)')
xlabel('T(Period)')
ylabel('Magnitude')

subplot(4,1,4);
plot(T,phasec)
title('Phase Spectra of y(t)')
xlabel('T(Period)')
ylabel('Phase')
% For part(ii) we use Linearity Fourier property.
%--------------------------------------------------------
%task e
d=computeFT_diracPulse(omega,2);
e=b+d;
[magnitudee,phasee]=getMagPhaseSpectra_fromFTVec(e);
figure 
subplot(4,1,1);
plot(T,magnitudec)
title('Magnitude of f1(t)')
xlabel('T(Period)')
ylabel('Magnitude')

subplot(4,1,2);
plot(T,phasec)
title('Phase Spectra of f1(t)')
xlabel('T(Period)')
ylabel('Phase')

subplot(4,1,3);
plot(T,magnitudee)
title('Magnitude of f2(t)')
xlabel('T(Period)')
ylabel('Magnitude')

subplot(4,1,4);
plot(T,phasee)
title('Phase Spectra of f2(t)')
xlabel('T(Period)')
ylabel('Phase')

