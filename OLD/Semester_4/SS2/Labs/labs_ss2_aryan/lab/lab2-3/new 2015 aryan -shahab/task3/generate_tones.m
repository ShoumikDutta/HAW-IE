function  [tone] = generate_tones( key )

Fs = 8000;
t = 0:1/Fs:(1/2-1/Fs);
key=0;
num=length(key);
    for k=1:num;
        value =key(k);
            switch value
                case{1,2,3}
                    row = 697;
                case{4,5,6}
                    row = 770;
                case{7,8,9}
                    row = 852;
                otherwise
                    row = 942;
            end
            switch value
                case{1,4,7}
                    column = 1209;
                case{2,3,8,0}
                    column = 1336;
                otherwise
                    column = 1477;
            end
     tone = 0.5*(sin(2*pi*row*t)+sin(2*pi*column*t));
    sound(tone,Fs);
    end

end

