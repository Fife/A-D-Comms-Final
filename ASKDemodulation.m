function ASKDemodulation(time_window, ask_input, adc_input, f_s, f_s_adc)
    resampled = adc_input(1:f_s/f_s_adc:end); 
    demodulated =(resampled - 127)./25000;
    demodulated = repelem(demodulated, f_s/f_s_adc);

    subplot(2,3,1);plot(linspace(0,0.75, 193), ask_input(1:193))
    title("Section of ASK Input")
    xlabel("t (ms)")
    ylabel("Volts (mV)")
    axis([0 0.75 -1.2 1.2])

    [freq, mag] = spectrum(ask_input, f_s, time_window);
    subplot(2,3,4);plot(freq, mag);
    title("Single-Sided Spectrum of ASK Input Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    subplot(2,3,2);plot(time_window.*1000, demodulated)
    title("ASK Demodulation into Digital Signal")
    xlabel("t (ms)")
    ylabel("Volts (mV)")


    [freq, mag] = spectrum(demodulated, f_s, time_window);
    subplot(2,3,5);stem(freq(1:60), mag(1:60));
    title("Single-Sided Spectrum of ASKDemodulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    output = lowpass(demodulated, 3000, f_s, ImpulseResponse="iir",Steepness=0.95);
    subplot(2,3,3);plot(time_window.*1000, output.*1000)
    title("Demodulated Output Signal")
    xlabel("t (ms)")
    ylabel("Volts (mV)")

    [freq, mag] = spectrum(output, f_s, time_window);
    subplot(2,3,6); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Filterd Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
end