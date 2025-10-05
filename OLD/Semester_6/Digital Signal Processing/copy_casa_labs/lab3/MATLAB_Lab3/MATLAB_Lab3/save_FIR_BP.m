% To be run after coefficient have been created with sp_fir_las_ass1.m
% create header file FIR_BP.h
% assumption: FIR filter coefficients are stored in b_FIR_BP, filter has a
% degree of N_FIR_BP, thus (N_FIR_BP+1) coefficients
filnam = fopen('FIR_BP.h', 'w'); % generate include-file
fprintf(filnam,'#define N_FIR_BP_coeffs %d\n', N_FIR_BP+1);
fprintf(filnam,'short b_FIR_BP[N_FIR_BP_coeffs]={\n');
j = 0;
for i= 1:N_FIR_BP+1
fprintf(filnam,' %6.0d,', round(b_FIR_BP(i)*32767) );
j = j + 1;
if j >7
fprintf(filnam, '\n');
j = 0;
end
end
fprintf(filnam,'};\n');
fclose(filnam);