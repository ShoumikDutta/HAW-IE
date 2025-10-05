%function writes the coefficients on a header file
%input arguments are: Order of filter, h - vector containing the
%coefficients (usually returned from "firpm" function), Type of filter
function write_coeffs(Filter_order, h, Filter_type) 

N_coeffs = Filter_order + 1;
% create header file FIR_??.h depending on the type specified
switch Filter_type 
    case 'l'
        filnam = fopen('FIR_LP.h', 'w'); % generate include-file for LP
    case 'h'
        filnam = fopen('FIR_HP.h', 'w'); % generate include-file for HP
    case 'bp'
        filnam = fopen('FIR_BP.h', 'w'); % generate include-file for BP
    case 'bs'
        filnam = fopen('FIR_BS.h', 'w'); % generate include-file for BS
    otherwise
        return;
end   
fprintf(filnam,'#define N_FIR_coeffs %d\n', N_coeffs);
fprintf(filnam,'short h[N_FIR_coeffs]={\n');
j = 0;
for i= 1:N_coeffs
 fprintf(filnam,' %6.0d,', round(h(i)*32768) );
 j = j + 1;
 if j >7
 fprintf(filnam, '\n');
 j = 0;
 end
end
fprintf(filnam,'};\n');
fclose(filnam);