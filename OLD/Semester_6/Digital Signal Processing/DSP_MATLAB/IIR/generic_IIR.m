% generic_IIR.m
% Calculation of IIR Filter coefficients using the Bilinear z-transform
% The analog transfer functions are either:
% - Butterworth
% - Chebyshev Type I or II
% - Elliptic (Cauer)
% A coefficient file is generated which hold Q15 constants for cascaded 2nd order stages
% Author: J. R 30.01.03; Source: S.J. Mitra pp472.

close all;
clear all;
disp('Bilinear Z-transform IIR-Filter Design');
disp('Analog filter approximation type: ');
disp('            Buttterworth (BUT)');
disp('            Chebyshev-I  (CHEB1)');
disp('            Chebyshev-II (CHEB2)');
disp('            Elliptical   (ELLIP)');
AppType = input('Enter approximation type string in quotes: ');

disp('Filter type:');
disp('            Lowpass  (LP)');
disp('            Highpass (HP)');
disp('            Bandpass (BP)');
disp('            Bandstop (BS)');
Type = input('Enter filter type string in quotes: ');
switch Type    % generate additional string for highpass and stopband filters:
case 'LP'
   string='';
case 'HP'
   string='high';
case 'BP'
   string='';
case 'BS'
   string='stop';
end;   

Fs = input('Enter sample frequency frequency /Hz: ');
if (Type == 'BP' | Type == 'BS')
   disp('Enter the following as a pair of numbers in [brackets]')
end; 
Fp = input('Enter passband frequency /Hz: ');
if (Type == 'BP' | Type == 'BS')
   disp('Enter the following as a pair of numbers in [brackets]')
end; 
Fst= input('Enter stopband frequency /Hz: ');
Rp = input('Enter passband ripple /dB : ');
Rs = input('Enter minimum stoppband attenuation /dB: ');
Wp = 2*Fp/Fs; % normalized to 0..1 where Fs is 2
Ws = 2*Fst/Fs;

switch AppType
case 'BUT' 
  disp('Calculating a Butterworth-filter:');
  [N,Wn] = buttord(Wp, Ws, Rp, Rs); % Minimum cut-off freq. and the filter order
  if Type == 'HP'
    [b,a] = butter(N,Wn,'high'); % Filter coefficients
    [z,p,k] = butter(N, Wn,'high'); % Zeroes and Poles
  elseif Type == 'BS'
    [b,a] = butter(N,Wn,'stop'); % Filter coefficients
    [z,p,k] = butter(N, Wn,'stop'); % Zeroes and Poles
  else
    [b,a] = butter(N,Wn); % Filter coefficients
    [z,p,k] = butter(N, Wn); % Zeroes and Poles
  end
  
case 'CHEB1'
  disp('Calculating a Chebyshev-I-filter:');
  [N,Wn] = cheb1ord(Wp, Ws, Rp, Rs); % Minimum cut-off freq. and the filter order
  if Type == 'HP'
    [b,a] = cheby1(N, Rp, Wn, 'high'); % Filter coefficients
    [z,p,k] = cheby1(N, Rp, Wn, 'high'); % Zeroes and Poles
  elseif Type == 'BS'
    [b,a] = cheby1(N, Rp, Wn, 'stop'); % Filter coefficients
    [z,p,k] = cheby1(N, Rp, Wn, 'stop'); % Zeroes and Poles
  else
    [b,a] = cheby1(N, Rp, Wn); % Filter coefficients
    [z,p,k] = cheby1(N, Rp, Wn); % Zeroes and Poles
  end
 
case 'CHEB2'
  disp('Calculating a Chebyshev-II-filter:');
  [N,Wn] = cheb2ord(Wp, Ws, Rp, Rs);
  if Type == 'HP'
    [b,a] = cheby2(N, Rs, Wn, 'high'); % Filter coefficients
    [z,p,k] = cheby2(N, Rs, Wn, 'high'); % Zeroes and Poles
  elseif Type == 'BS'
    [b,a] = cheby2(N, Rs, Wn, 'stop'); % Filter coefficients
    [z,p,k] = cheby2(N, Rs, Wn, 'stop'); % Zeroes and Poles
  else
    [b,a] = cheby2(N, Rs, Wn); % Filter coefficients
    [z,p,k] = cheby2(N, Rs, Wn); % Zeroes and Poles
  end
 
case 'ELLIP'
  disp('Calculating an Elliptical- (Cauer-) filter:');
  [N,Wn] = ellipord(Wp, Ws, Rp, Rs); % Minimum cut-off freq. and the filter order
  if Type == 'HP'
    [b,a] = ellip(N, Rp, Rs, Wn,'high'); % Filter coefficients
    [z,p,k] = ellip(N, Rp, Rs, Wn,'high'); % Zeroes and Poles
  elseif Type == 'BS'
    [b,a] = ellip(N, Rp, Rs, Wn,'stop'); % Filter coefficients
    [z,p,k] = ellip(N, Rp, Rs, Wn,'stop'); % Zeroes and Poles
  else
    [b,a] = ellip(N, Rp, Rs, Wn); % Filter coefficients
    [z,p,k] = ellip(N, Rp, Rs, Wn); % Zeroes and Poles
  end
otherwise
   disp('??? Error: no valid filter type specified');
end
   
% The following is independent from the calculation method:
[h,omega] = freqz(b,a, 256); % Z-transform
sec_ord_sec = zp2sos(z,p,k); % generate coefficients for cascaded 2nd order system
stages = min(size(sec_ord_sec)); % number of rows in the coefficient matrix

disp('IIR-characteristics:      ');
disp('Filter Order:             ');disp(N);
disp('Prewarped Frequency:      ');disp(Wn);
disp('Nominator Coefficients:   ');disp(b);
disp('Denominator Coefficients: ');disp(a);
disp('Gain constant:            ');disp(k);
disp('Poles at:                 ');disp(p);
disp('Radius of Poles:          ');disp(abs(p));
disp('Zeros at:                 ');disp(z);
disp('Number of 2nd-ord. stages:');disp(stages);
for i=1:stages
   fact(i) = abs(sec_ord_sec(i,5)) + abs(sec_ord_sec(i,6)); % Calculate abs(a1) + abs (a2)
end
disp('The abs(a1,i)+abs(a2,i) are: ');disp(fact);

gain = 20*log10(abs(h));
figure;
freqz(b,a, 256); % Display magnitude and phase in Fig. 1

figure; % Display Fig. 2

subplot(2,2,1);
plot(Fs*omega/pi/2, gain); grid;
title('Magnitude of Transfer Function');
xlabel('f [Hz]'); ylabel('Gain /dB');

subplot(2,2,2); zplane(z,p); grid;
xlabel('Real part \rightarrow'); ylabel('Imag part \rightarrow');
title('Pole-Zero Diagram');

subplot(2,2,3);
axis([1 100 0 100])
axis('off')
text(5,90,['IIR-Filter type :', Type]);
text(5,75,['Approximation type :', AppType]);
text(5,60,['Sample frequency /Hz :', num2str(Fs)]);
text(5,45,['Passband frequency(s) /Hz :', num2str(Fp)]);
text(5,30,['Stopband frequency(s) /Hz :', num2str(Fst)]);
text(5,15,['Passband Ripple /dB :', num2str(Rp)]);
text(5,0,['Stopband attenuation /dB :', num2str(Rs)]);

inp = input('Do you want to create a coefficient file? (0/1) ');
if inp == 1
   string = input('Enter Filename (in quotes): ');
   string = [string,'.h'];
   scale = input('Enter scaling factor (0 means float coefficients): ');
      
   filnam = fopen(string, 'wt');		% generate include-file
   fprintf(filnam,'/* IIR-Filter Project: %s */\n', string);
   fprintf(filnam,'/* IIR-Filter spec: Fs= %d, Filter-Type: %s, Approximation: %s */\n', Fs, Type, AppType);
   if length(Fp) == 2  % Bandpass or Bandstop Filters
      fprintf(filnam,'/* Passband [Hz] %d %d, Stopband [Hz] %d %d, Passband-Ripple %ddB, Stopband-Attenuation= %ddB */\n', Fp, Fst, Rp, Rs);
   else
      fprintf(filnam,'/* Passband [Hz] %d, Stopband [Hz] %d, Passband-Ripple %ddB, Stopband-Attenuation %ddB */\n', Fp, Fst, Rp, Rs);
   end   
   fprintf(filnam,'#define STAGES %d // Number of 2nd order stages  \n', stages);
   if scale == 0 
      fprintf(filnam,'float b[STAGES][3]={   // bi0, bi1, bi2 \n');
      for i= 1:stages;
         fprintf(filnam,'{%8.6f, %8.6f, %8.6f},\n',sec_ord_sec(i,1), sec_ord_sec(i,2), sec_ord_sec(i,3));
      end;
      fprintf(filnam,'};\n');
      fprintf(filnam,'float a[STAGES][2]={   // ai1, ai2 \n');
      for i= 1:stages;
         fprintf(filnam,'{%8.6f, %8.6f},\n',sec_ord_sec(i,5), sec_ord_sec(i,6));
      end;
      fprintf(filnam,'};\n');
      fclose(filnam);
   else
      type = input('Enter your C-type in quotes: ');
      sec_ord_sec = fix(sec_ord_sec*scale); % Scale with suitable factor 
      fprintf(filnam,'/* Scale factor used: %d */\n', scale);
      fprintf(filnam,'%s b[STAGES][3]={   // bi0, bi1, bi2 \n', type);
      for i= 1:stages;
         fprintf(filnam,'{%8.0f, %8.0f, %8.0f},\n',sec_ord_sec(i,1), sec_ord_sec(i,2), sec_ord_sec(i,3));
      end;
      fprintf(filnam,'};\n');
      fprintf(filnam,'%s a[STAGES][2]={   // ai1, ai2 \n', type);
      for i= 1:stages;
         fprintf(filnam,'{%8.0f, %8.0f},\n',sec_ord_sec(i,5), sec_ord_sec(i,6));
      end;
      fprintf(filnam,'};\n');
      fclose(filnam);
   end
   fprintf(1,'Coefficient file %s has been generated\n', string);

   subplot(2,2,4);
   axis([1 100 0 100])
   axis('off')
   text(5,90,['Number of coefficients: ', num2str(N)]);
   text(5,75,['Number of 2nd-order stages: ', num2str(stages)]);
   text(5,60,['Coefficient file: ', string]);
   text(5,45,['Scale factor used: ', num2str(scale)]);
end
%end




