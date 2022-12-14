%Analog frquency demodulation
function FM = FrequencyDemodulation(time_window, v_t, fs,vfm)
    f_c = 2000;
    %FM Demodulation 
    FM=diff(vfm);
    plot(FM);
    x = linspace(1, 10, 500);
    n = 10;
    FMM = FM(1 : 10 : 500);
    plot(FMM);
    title("Frequency Demodulation")
    xlabel("t(ms)")
    ylabel("v(t)")
end
