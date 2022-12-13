function [output, freq, mag] = DigitalToAnalog(time_window, v_t, f_s)
    
    %Demodulated Signal

    %Decode Digital Signal
    sampled = ((v_t-127)./127).*0.004;

    %Resample Signal to original timescale

    sampled = repelem(sampled,10);
    time_window = 0: 0.01/length(sampled) : 0.01 - 0.01/length(sampled);
    
    %Fiilter Signal
    output = lowpass(sampled, 2000, f_s, ImpulseResponse="iir",Steepness=0.95);
    [freq, mag] = spectrum(output, f_s, time_window);

    figure
    subplot(2,2,3);plot(time_window, output)
    title("Input Signal")
    xlabel("t (ms)")
    ylabel("v(t)")
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