function outp = rect( x )
%RECT Summary of this function goes here
%   Detailed explanation goes here
max = 1/500;
    if((x < max) && (x > 0))
        outp = 1;
    else
        outp = 0;
    end ;
end
