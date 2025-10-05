% check_IIR.m
% This M-file checks the fix-point conversion quality of IIR filters
% It is required that the cascaded 2nd order constant matrix sec_ord_sec
% exists in the Matlab dataspace.
% This matrix is converted to a pole-zero representation.
disp('Reading data structure "sec_ord_sec" from Matlab data space');
stages = min(size(sec_ord_sec)); % number of rows in the coefficient matrix
disp('Number of 2nd order stages found: '); disp(stages);
Fs = input('Enter Sample Frequency: ');
[z1,p1,k1] = sos2zp(sec_ord_sec);
[b1,a1] = sos2tf(sec_ord_sec);

[h1,omega1] = freqz(b1,a1, 256); % Z-transform with quantized coeffs.
[h,omega] = freqz(b,a, 256); % Original Z-transform
gain = 20*log10(abs(h));
gain1 = 20*log10(abs(h1));
absp1 = abs(p1);

figure;
subplot(2,2,1);
plot(Fs*omega/pi/2, gain); grid; axis([0 Fs/2 -100 +10]);
title('Magnitude of original transfer function');
xlabel('f [Hz]'); ylabel('Gain /dB')
subplot(2,2,2);
plot(Fs*omega1/pi/2, gain1); grid; axis([0 Fs/2 -100 +10]);
title('Magnitude of quantized transfer function');
xlabel('f [Hz]'); ylabel('Gain /dB');

subplot(2,2,3);
zplane(z,p);
xlabel('Re \rightarrow'); ylabel('Im     \uparrow');
title('Original Pole-Zero Diagram');
subplot(2,2,4);
zplane(z1,p1);
xlabel('Re \rightarrow'); ylabel('Im     \uparrow');
title('Quantized Pole-Zero Diagram');

disp('Poles are located at: '); disp(p1);
disp('Poles radii are     : '); disp(absp1);
disp('B coeffs are		  : '); disp(b1);
disp('A coeffs are		  : '); disp(a1);
%end



