%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HAW Hamburg               %
% Department IuE            %
% Digital Communications    %
% Prof. Dr. Rainer Schoenen %
% SS2015                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (global script used for all other scripts and Simulink experiments)
global c;
c.init_done=true;
c.sampling_frequency = 8000; % 8kHz
c.word_clock_frequency = c.sampling_frequency;
c.sample_time = 1.0/c.sampling_frequency;
%c.bit_resolution = 8;
c.bit_resolution = 8; % reduced, just to check
c.bit_clock_frequency = c.word_clock_frequency * c.bit_resolution;
c.filter_cutoff_frequency = c.sampling_frequency/2.0;
c.filter_cutoff_frequency_in_rad_per_second = 2*pi*c.filter_cutoff_frequency;
c.simulation_step_duration = 2/64e5; % i.e. 50 samples per period of the 64kHz clock
% ^ constant step size assumed
% ^ this also defines the "Sample Time" of input blocks
