function FourierTransformJF(time_window, v_t, f_s)
    syms t
    v_f = fft(v_t);
    
    %Plot the Frequency Generation
    f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
    v_fsub = abs(v_f);
    
    figure 
    subplot(2,1,2); stem(f(1:30), v_fsub(1:30))
    title("Single-Sided Amplitude Spectrum of Input Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    subplot(2,1,1); plot(1000.*time_window, v_t)
    title("Fourier Series Generation of Input Signal")
    xlabel("t (ms)")
    ylabel("v(t)")
end