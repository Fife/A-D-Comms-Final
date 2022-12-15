function BPSKDemod(time_window, fsk_input, adc_out, f_s, f_s_adc)
    resampled = adc_out(1:f_s/f_s_adc:end); 
    demodulated =(resampled - 127)./25000;
    demodulated = repelem(demodulated, f_s/f_s_adc);



    subplot(2,3,1);plot(linspace(0,0.75, 193), fsk_input(1:193))
    title("Section of ASK Input")
    xlabel("t (ms)")
    ylabel("V (mV)")
    axis([0 0.75 -1.2 1.2]);
    title("Section of BPSK Signal")
    xlabel("t (ms)")
    ylabel("Volts (mV)")

    [freq, mag] = spectrum(fsk_input, f_s, time_window);
    subplot(2,3,4); plot(freq, mag)
    title("Single-Sided Spectrum of BPSK Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")


    subplot(2,3,2);plot(time_window.*1000, demodulated);
    title("Demodulated BPSK Signal")
    xlabel("t (ms)")
    ylabel("Volts (mV)")

    [freq, mag] = spectrum(demodulated, f_s, time_window);
    subplot(2,3,5);stem(freq(1:60), mag(1:60));
    title("Single-Sided Spectrum of BPSKDemodulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    output = lowpass(demodulated, 3000, f_s, ImpulseResponse="iir",Steepness=0.95);
    subplot(2, 3, 3);plot(time_window.*1000, output.*1000)
    title("Final Filtered Output Signal")
    xlabel("t (ms)")
    ylabel("Volts (mV)")

    [freq, mag] = spectrum(output, f_s, time_window);
    subplot(2,3,6); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Filterd Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
end