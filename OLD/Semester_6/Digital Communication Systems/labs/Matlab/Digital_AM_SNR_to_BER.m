% Determining BER(SNR), i.e. BER=f(SNR)
% Attention: Select the method that you used first.
clear;

if (true) % select here
    
    % This script is for the case when the generator output pow-er was measured in dB
    
    %% Reference measurements, all values in Volts
    U_ES = ;     % in V_RMS at discriminator, without noise
    U_E025 = ;   % in V_RMS at discriminator, for BER=0.25
    U_NG025 = ;  % V_RMS of noise generator
    
    %% Measurement sequence, pairs (triples) of values belonging together
    % U_NG:  generator noise effective voltage (V_RMS)
    % U_E:   Voltage at discriminator in V_RMS
    % BER:   bit error ratio measured
    U_NG   = [];
    U_E    = [];
    BER    = [];
    
    %% Determination of constant c from measurements at a BER of 0.25
    c = (U_E025^2-U_ES^2)/U_NG025^2;
    
    %% Determination of SNR/dB
    SNR = (U_ES.^2)./(c*U_NG.^2);
    SNR_dB = 10*log10(SNR);

else % other way:
    
    % This script is for the case when the generator output power was measured in dB
    
    %% Reference measurements
    U_ES = ;     % in V_RMS at discriminator, without noise
    U_E025 = ;   % in V_RMS at discriminator, for BER=0.25
    Pn_dBr025 = ; % relative generator noise power in dB
    
    %% Measurement sequence, pairs (triples) of values belonging together
    % Pn_dB: generator noise power in dB
    % U_E:   Voltage at discriminator in V_RMS
    % BER:   bit error ratio measured
    U_E    = [];
    Pn_dBr = [];
    BER    = [];
    
    %% Determination of SNR/dB
    SNR_dB025 = 10*log10(U_ES^2/(U_E025^2 - U_ES^2));
    SNR_dB = SNR_dB025 - (Pn_dBr - Pn_dBr025);
 
end; % of if/then/else

%% Plot
figure(1)
semilogy(SNR_dB, BER,'-x');
title('BER as a function of SNR [dB]');
grid;
