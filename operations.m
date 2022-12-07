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
v_f = fft(v_t);

figure
%Plot the Signal Generation
subplot(2,1,1); plot(1000.*time_window, v_t)
title("Fourier Series Generation of Input Signal")
xlabel("t (ms)")
ylabel("v(t)")

%Plot the Frequency Generation
f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
v_fsub = abs(v_f);
subplot(2,1,2); stem(f(1:30), v_fsub(1:30))
title("Single-Sided Amplitude Spectrum of Input Signal")
xlabel("f (Hz)")
ylabel("|V(f)|")

%Part 2: Analog 
figure
AmplitudeModulationJF(time_window, v_t, f_s);
figure 
FrequencyModulationJF(time_window, v_t, f_s);

%Part 3: Digital

%PCM
figure
AnalogToDigitalJF(time_window, v_t);

%ASK
%FSK
%BPSK


%Part 4: M-ary
%QPSK


