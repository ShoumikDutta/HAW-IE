function outp = rect( x )

max = 1/500;% 2 ms 
    if((x < max) && (x > 0))%between 0 and 2 ms is 1 
        outp = 1;
    else
        outp = 0;% other is 0 
    end ;
end
