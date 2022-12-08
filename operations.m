% Output Data Gathering Script
clc 
clear

%Part 1: Fourier Series
%Sampling Frequencies and Time Windows
f_s = 50000;                            % 50kHz Sampling Frequency
time_window = 0:1/f_s:0.01-1/f_s;       % Generate Time window from sampling frequency
terms = 5;

%Signal Generation: Time Domain and Frequency Domain
v_t = eval(ExponentialFourierSeriesJF(time_window, terms*2));

figure
FourierTransformJF(time_window, v_t, f_s);

%Part 2: Analog 
figure
AmplitudeModulationJF(time_window, v_t, f_s);

figure 
FrequencyModulationJF(time_window, v_t, f_s);

%Part 3: Digital

%PCM
figure
AnalogToDigitalJF(time_window, v_t, f_s);

%ASK
%FSK
%BPSK


%Part 4: M-ary
%QPSK


