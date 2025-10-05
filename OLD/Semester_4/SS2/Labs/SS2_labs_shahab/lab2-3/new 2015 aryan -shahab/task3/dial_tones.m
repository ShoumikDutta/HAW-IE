function [ tones ] = dial_tones()
Fs=8000;
key = input('Please enter your number:');
key = num2str(key);
num = length(key);
tones = zeros(1,num*Fs);
time = 0: 1/Fs:(num -1/Fs);
for x = 1:num
    tones((1+Fs*(x-1)):(Fs/2 +Fs*(x-1))) = generate_tones(str2num(key(x)));
end
sound(tones,Fs);
subplot(2,1,1)
plot(time(1:500),tones(1:500));
title('Time domain');
xlabel('Time(sec)');
ylabel('Magnitude');

% subplot(2,1,2)
% f=Fs/2;
% toShift = fft (tones);
% plot(f,abs(ffshift(toShift)));
% title('Freq domain');
% xlabel('Frequeny (Hz)')
% ylabel('|Y(f)|')



end
