%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HAW Hamburg               %
% Department IuE            %
% Digital Communications    %
% Prof. Dr. Rainer Schoenen %
% SS2015                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercises 00 - Introduction
init_digital_communications; % initialize HAW/DKL details

% Exercise 00-01
B = 20e6 % Bandwidth B = 20 MHz
v = 30   % Speed v = 30 m/s
v_kmh = v*3.6 % Speed in [km/h]
PT = 40 % Transmit Signal power PT = 40 W
PT_dBm = 10*log10(PT*1000.0) % PT in [dBm] (for Milliwatts!)
PT_dBm = 10*log10(PT) + 30   % PT in [dBm] (for Milliwatts!)
S = 1e-9 % Received signal power S=10^(-9) W
S_dBm = 10*log10(S)+30
I = 1e-10 % Interference power I=10^(-10) W
I_dBm = 10*log10(I)+30
N = 1e-10 % Noise power N=10^(-10) W
N_dBm = 10*log10(N)+30
sinr = S /(I+N)
sinr_dB = 10*log10(sinr)
% Which voltage Ueff is on the line for a signal of -60dBm at an impedance of 50?
P_dBm = -60
P = 10^(P_dBm/10)/1000 % in Watt
R=50 % 50 Ohm
% R=U/I U=R*I P=U*I=U²/R <=> U = sqrt(P*R)
Ueff = sqrt(P*R) % in Volts
Ueff_uV = Ueff*1e6

% Exercise 00-02
B = 20e6 % Bandwidth B = 20 MHz
k = 1.3806488e-23 % Boltzmann constant [J/K]
T = 273+20 % room temperature 20°C
F = 1
N = B*k*T*F
N_uW = N*1e6
N_pW = N*1e12
N_dBm = 10*log10(N*1000)
S = 1e-9
sinr = S/N
sinr_dB = 10*log10(sinr)
r = 54e6 % data rate 50Mbit/s
Eb = S/r % Energy per bit: [J/bit] = [W / (bit/s)] = [Ws / bit]

% Exercise 00-03
f_c = 2.4e9 % 2.4 GHz
v = 300/3.6 % in [m/s] !
c = 3e8 % speed of light [m/s]
df = f_c * v / c % [Hz]
% WiFi on a high-speed train?
% There is no relative speed between the access point and the terminal (user device).
% Cellular network: The station is outside, so we do have a relative speed.
f_c = 900e6 % 900 MHz
v = 300.0/3.6 % in [m/s] !
c = 3e8 % speed of light [m/s]
df = f_c * v / c % [Hz]
B = 20e6 % B = 20 MHz
shift_percent = df/B * 100 % in %

