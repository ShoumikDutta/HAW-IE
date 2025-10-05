function [ y ] = myConv(x,h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
conv_l=length(x)+length(h)-1
yz=zeros(1,conv_l)
y=zeros(1,conv_l)
yz(1:length(h))=h;
for n=1:conv_l;
     for k=1:length(x)
         if((1+n-k) <=0)
             break
         end
        y(n)=y(n)+x(k)*yz(1+n-k);
     end
end

