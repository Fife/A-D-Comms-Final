function ASKDemodulation(time_window, ask_input, f_s, f_s_adc)
    resampled = ask_input(1:f_s/f_s_adc:end); 
    demodulated =(resampled - 127)./25000;
    demodulated = repelem(demodulated, f_s/f_s_adc);

    subplot(2,2,1);plot(time_window.*1000, demodulated)
    title("ASK Demodulation into Digital Signal")
    xlabel("t (ms)")
    ylabel("V (mV)")

    [freq, mag] = spectrum(demodulated, f_s, time_window);
    subplot(2,2,3);stem(freq(1:60), mag(1:60));
    title("Single-Sided Spectrum of ASKDemodulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")


    output = lowpass(demodulated, 3000, f_s, ImpulseResponse="iir",Steepness=0.95);
    subplot(2, 2, 2);plot(time_window.*1000, output.*1000)
    title("Demodulated Output Signal")
    xlabel("t (ms)")
    ylabel("mV(t)")

    [freq, mag] = spectrum(output, f_s, time_window);
    subplot(2,2,4); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Filterd Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
end