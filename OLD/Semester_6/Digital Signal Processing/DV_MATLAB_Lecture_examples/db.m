%---------------------------------------------------------------------------
% dB computation
%
% Linear to LOG conversion of complex numbers
%
% US 6-Oct-04
%
% function arglog20 = dB(arglin);
function arglog20 = dB(arglin);

arglog20 = 20*log10(abs(arglin));
