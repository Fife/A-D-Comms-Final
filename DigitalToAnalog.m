%Jacob Fifield 
%Abddullah Al Kassi
% CPE 3620 Project 
function DigitalToAnalog(adc_out, time_window, f_s, orig_sig)
    %Decode Digital Signal
    desampled = ((adc_out-127)./128).*0.004;
    
    %Plot Original Signal to Compare
    subplot(2,3,1);plot(time_window.*1000, orig_sig.*1000)
    title("Original Signal");
    xlabel("t (ms)")
    ylabel("mV(t)")

    [freq, mag] = spectrum(orig_sig, f_s, time_window);
    subplot(2,3,4); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Original Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")


    %Modulated Input Signal
    subplot(2, 3, 2);stairs(time_window.*1000, adc_out)
    title("Quantized 8-Bit PCM Signal- Unipolar Encoding")
    xlabel("t (ms)")
    ylabel("8-bit Word Value")

    [freq, mag] = spectrum(desampled, f_s, time_window);
    subplot(2,3,5); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Modulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
    
    %Fiilter Signal
    output = lowpass(desampled, 3000, f_s, ImpulseResponse="iir",Steepness=0.95);

    subplot(2, 3, 3);plot(time_window.*1000, output.*1000)
    title("Demodulated Output Signal")
    xlabel("t (ms)")
    ylabel("mV(t)")

    [freq, mag] = spectrum(output, f_s, time_window);
    subplot(2,3,6); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Demodulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
   


%     
%     %Fiilter Signal
%     output = lowpass(sampled, 2000, f_s, ImpulseResponse="iir",Steepness=0.95);
%     [freq, mag] = spectrum(output, f_s, time_window);
% 
%     figure
%     subplot(2,2,3);plot(time_window, output)
%     title("Input Signal")
%     xlabel("t (ms)")
%     ylabel("v(t)")
% 
%     subplot(2,2,4); stem(freq, mag)
%     title("Single-Sided Amplitude Spectrum of Input Signal")
%     xlabel("f (Hz)")
%     ylabel("|V(f)|")
% 
%     subplot(2,2,3);plot(time_window, output)
%     title("Demodulated Signal")
%     xlabel("t (ms)")
%     ylabel("v(t)")
% 
%     subplot(2,2,4); stem(freq, mag)
%     title("Single-Sided Amplitude Spectrum of Deodulated Signal")
%     xlabel("f (Hz)")
%     ylabel("|V(f)|")

end