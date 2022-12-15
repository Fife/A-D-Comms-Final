%Jacob Fifield 
%CPE 3620 Project 
%Frequency Modulation

function vfm = FrequencyModulationJF(time_window, v_t, f_s)
    fm = 5000;
    signal = 10.*v_t;
    vc = cos(2*pi*fm*time_window);
    %Frequency Modulation 
    vfm = cos(2*pi*fm*time_window+40*signal);
    
    %Time Domain Plots
    subplot(3,2,1);plot(time_window.*1000, signal)
    title("Input Signal")
    xlabel("t (ms)")
    ylabel("v(t)")
    
    subplot(3,2,3);plot(time_window.*1000, vc)
    title("Carrier Signal")
    xlabel("t (ms)")
    ylabel("v(t)")

    subplot(3,2,5);plot(time_window.*1000, vfm)
    title("FM Signal")
    xlabel("t (ms)")
    ylabel("v(t)")

    %Frequency Domain Input Signal
    [freq, mag] = spectrum(v_t, f_s, time_window);
    subplot(3,2,2);stem(freq(1:60), mag(1:60));
    title("Single-Sided Spectrum of Input Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    %Frequency Domain Carrier Signal
    [freq, mag] = spectrum(vc, f_s, time_window);
    subplot(3,2,4);stem(freq(1:100), mag(1:100));
    title("Single-Sided Amplitude Spectrum of Carrier Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    %Frequency Domain FM Signal
    [freq, mag] = spectrum(vfm, f_s, time_window);
    subplot(3,2,6);stem(freq(1:100), mag(1:100));
    title("Single-Sided Amplitude Spectrum of FM signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

end