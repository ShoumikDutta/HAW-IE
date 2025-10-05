% create header file IIR_LP_ellip_cheby1.h
% assumption: IIR filter coefficients are stored in num_IIR, den_IIR and that
% the filter has a degree of N_IIR_LP
function write_coeffs(Filter_order, sos_Matrix, Filter_type) 
M = Filter_order/2;
scaling_factor = 1;
max_coeffs = max(abs(sos_Matrix));
if max(max_coeffs) > 1
   scaling_factor = ceil(max(max_coeffs));
   sos_Matrix = sos_Matrix ./ scaling_factor; 
end
% create header file IIR_??.h depending on the type specified
switch Filter_type 
    case 1
        filnam = fopen('IIR_LP_Cheb1.h', 'w'); % generate include-file for LP       
        fprintf(filnam,'#define M %d\n', M);
        fprintf(filnam,'short sos_Matrix_LP_Cheb1[M][6]={\n{');
    case 2
        filnam = fopen('IIR_LP_Ellip.h', 'w'); % generate include-file for LP    
        fprintf(filnam,'#define M %d\n', M);
        fprintf(filnam,'short sos_Matrix_LP_Ellip[M][6]={\n{');
    case 3
        filnam = fopen('IIR_HP.h', 'w'); % generate include-file for HP    
        fprintf(filnam,'#define M %d\n', M);
        fprintf(filnam,'short sos_Matrix_HP[M][6]={\n{');
    otherwise
        return;
end   
for i= 1:M
    for j=1:6
        fprintf(filnam,' %6.0d,', round(sos_Matrix(i,j)*32768) );
    end
    if i<M
        fprintf(filnam, ' },\n{');
    else
        fprintf(filnam, ' }};\nshort scaling_factor = %d;', scaling_factor);
    end
end
fclose(filnam);