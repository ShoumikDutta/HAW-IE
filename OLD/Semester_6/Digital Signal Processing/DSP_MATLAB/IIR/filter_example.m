% filter_example.m
% Illustration of Filtering by an IIR Filter
% Version: 04/2003 kzr
clf;
% Generate the input sequence
k = 0:50;
w2 = 0.7*pi;w1 = 0.2*pi;
x1 = 1.5*cos(w1*k); x2 = 2*cos(w2*k);
x = x1+x2;
% Determine the low pass filter transfer function
[N, Wn] = ellipord(0.25, 0.55, 0.5, 50);
[num, den] = ellip(N,0.5, 50,Wn);
% Generate the output sequence
y = filter(num,den,x);
% Plot the input and the output sequences
subplot(2,1,1);
stem(k,x); grid; axis([0 50 -4 4]);
xlabel('Time index n'); ylabel('Amplitude');
title('Input Sequence (Composition of two Sequences)');
subplot(2,1,2);
stem(k,y); grid; axis([0 50 -4 4]);
xlabel('Time index n'); ylabel('Amplitude');
title('Output Sequence after Filtering');

