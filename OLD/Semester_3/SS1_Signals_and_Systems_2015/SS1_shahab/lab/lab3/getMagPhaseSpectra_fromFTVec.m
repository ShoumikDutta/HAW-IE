function [magSpec,phaseSpec ] = getMagPhaseSpectra_fromFTVec( ftVec )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
%phase
phaseSpec=atan2(imag(ftVec),real(ftVec));
%magnitude
magSpec=abs(ftVec);
% inside=((img(ftVec))^2)+((real(ftVec)^2));
% magSpec=sqrt(inside);

end

