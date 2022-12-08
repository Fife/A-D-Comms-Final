% Jacob Fifield 
% CPE 3620 Project 
% Analog to Digital- Eight Bit Sampling

function AnalogToDigitalJF(time_window, v_t, f_s)

    signal = 250.*v_t;
    sampled = round(127*signal + 127);
    
    %Modulation Plot
    
    %Input Signal
    subplot(3,2,1);plot(time_window*1000, v_t)
    title("Input Signal")
    xlabel("t (ms)")
    ylabel("v(t)")
    
    v_f = fft(v_t);
    f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
    v_fsub = abs(v_f);
    
    subplot(3,2,2); stem(f(1:30), v_fsub(1:30))
    title("Single-Sided Amplitude Spectrum of Input Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
    

    %Modulated Signal
    v_f = fft(sampled);
    f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
    v_fsub = abs(v_f);
    subplot(3,2,3);stairs(time_window*1000, sampled)
    title("Modulated Signal")
    xlabel("t (ms)")
    ylabel("v(t)")
    subplot(3,2,4); stem(f(1:30), v_fsub(1:30))
    title("Single-Sided Amplitude Spectrum of Modulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")


    %Demodulated Signal
    sampled = (sampled./256)./250;
    v_f = fft(sampled);
    f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
    v_fsub = abs(v_f);
    
    subplot(3,2,5);plot(time_window*1000, sampled)
    title("Demodulated Signal")
    xlabel("t (ms)")
    ylabel("v(t)")

    subplot(3,2,6); stem(f(1:30), v_fsub(1:30))
    title("Single-Sided Amplitude Spectrum of Modulated Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
end