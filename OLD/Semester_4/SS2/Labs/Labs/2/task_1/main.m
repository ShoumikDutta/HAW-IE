%input array 
x = 0:1:10000;
tic;
profile on;
Y = DFT(x); %passing thearray to function of DFT 
profile viewer
toc;

tic;
fftshift(fft(x));%using matlab built in function to check 
%fft(x)
toc;
