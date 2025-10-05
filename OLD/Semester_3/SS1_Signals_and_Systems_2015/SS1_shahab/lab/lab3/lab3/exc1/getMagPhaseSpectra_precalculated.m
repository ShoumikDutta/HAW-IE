function [ magSpec, phaseSpec] = getMagPhaseSpectra_precalculated( omega )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
magSpec=sqrt(2+2*cos(omega*0.001));
phaseSpec=-atan(sin(omega*0.001)./(1+cos(omega*0.001)));

end

