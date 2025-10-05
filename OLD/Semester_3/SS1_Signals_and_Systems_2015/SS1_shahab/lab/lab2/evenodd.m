function [ xe , xo] = evenodd( x )

xe=0.5*(x+flip(x));
xo=0.5*(x-flip(x));

end

