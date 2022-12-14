% Output Data Gathering Script
clc 
clear

%Part 1: Fourier Series
%Sampling Frequencies and Time Windows
f_s = 80000;                           % 80kHz Sampling Frequency
time_window = 0:1/f_s:0.01-1/f_s;       % Generate Time window from sampling frequency
terms = 5;

%Signal Generation: Time Domain and Frequency Domain
v_t = real(eval(ExponentialFourierSeriesJF(time_window, terms*2)));

figure
subplot(2,1,1);plot(time_window.*1000, v_t.*1000)
title("Signal Generation With Fourier Series");
xlabel("t (ms)");
ylabel("mV");

[freq, mag] = spectrum(v_t, f_s, time_window);
subplot(2,1,2);stem(freq(1:40), mag(1:40));
title("Single-Sided Spectrum of Signal Signal")
xlabel("f (Hz)")
ylabel("|V(f)|")

%Part 2: Analog 
figure
[vdsb, vssb, vlc] = AmplitudeModulationJF(time_window, v_t, f_s);
figure
AmplitudeDemodulation(time_window, vdsb, vssb,vlc, f_s)

figure 
vfm = FrequencyModulationJF(time_window, v_t, f_s);
figure
FrequencyDemodulation(time_window, v_t, f_s, vfm)

%Part 3: Digital

%PCM
figure
[time, output] = AnalogToDigitalJF(time_window, v_t, f_s);
figure
DigitalToAnalog(output, time_window, f_s, v_t);

%ASK
figure
AmplitudeShiftKeyJF(time_window, output, f_s)
%FSK
FrequencyShiftKeyJF;
%BPSK
BinaryPhaseShiftKeyJF;


%Part 4: M-ary
%QPSK
QuadriphaseShiftKeying;

