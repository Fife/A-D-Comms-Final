%Jacob Fifield 
%CPE 3620 Project 
%Frequency Modulation

function vfm = FrequencyModulationJF(time_window, v_t, fs)
    fm = 2000;
    signal = 250.*v_t;
    vc = sin(2*pi*fm*time_window);

    %Frequency Modulation 
    vfm = sin(2*pi*fm*time_window + signal);
    
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
    vf = fft(v_t);
    f = (0:length(vfm)-1)*fs/length(vfm);   % Frequency Window
    v_fsub = abs(vf);
    subplot(3,2,2); stem(f(1:20), v_fsub(1:20))
    title("Single-Sided Amplitude Spectrum of Input Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    %Frequency Domain Carrier Signal
    vfc = fft(vc);
    f = (0:length(vfc)-1)*fs/length(vfc);   % Frequency Window
    v_c = abs(vfc);
    subplot(3,2,4); stem(f(1:40), v_c(1:40))
    title("Single-Sided Amplitude Spectrum of Carrier Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    %Frequency Domain FM Signal
    n = length(vfm);
    Y = fft(vfm, n);
    F = ((0:1/n:1-1/n)*fs).';
    Vmag = abs(Y);
    subplot(3,2,6); stem(F(1:40), Vmag(1:40))
    title("Single-Sided Amplitude Spectrum of FM signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

end