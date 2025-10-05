% To be run after coefficient have been created with sp_fir_las_ass1.m
% create header file FIR_LP.h
% assumption: FIR filter coefficients are stored in b_FIR_LP, filter has a
% degree of N_FIR_LP, thus (N_FIR_LP+1) coefficients
filnam = fopen('FIR_LP.h', 'w'); % generate include-file
fprintf(filnam,'#define N_FIR_LP_coeffs %d\n', N_FIR_LP+1);
fprintf(filnam,'short b_FIR_LP[N_FIR_LP_coeffs]={\n');
j = 0;
for i= 1:N_FIR_LP+1
fprintf(filnam,' %6.0d,', round(b_FIR_LP(i)*32768) );
j = j + 1;
if j >7
fprintf(filnam, '\n');
j = 0;
end
end
fprintf(filnam,'};\n');
fclose(filnam);