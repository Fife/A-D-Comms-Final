% Jacob Fifield 
% CPE 3620 Project 
% Amplitude Modulation

function [vdsb, vssbu, vlc] = AmplitudeModulationJF(time_window, v_t, fs)
    syms carrier(t)
    f_c = 5000;
    carrier(t)= cos(2*pi*f_c*t);

    % DSB AM
    vdsb = eval(real(carrier(time_window).*v_t));
    subplot(2,3,1); plot(time_window.*1000, real(vdsb))
    title("Double Sideband Modulation")
    xlabel("t(ms)")
    ylabel("Volts")
    
    % SSB AM 

    v_f = abs(fft(vdsb));
    v_f([1:50]) = 0;
    v_f([1551:end]) = 0;
    v_f = v_f .*0.002;
    vssbu = real(ifft(v_f));
    %vssbu = highpass(real(vdsb), f_c-100, fs, ImpulseResponse="iir",Steepness=0.95);
    subplot(2,3,2); plot(time_window.*1000, vssbu)
    title("Single Sideband Modulation")
    xlabel("t(ms)")
    ylabel("Volts")

    
    % Large Carrier AM 
    vlc = eval(carrier(time_window)) + 125*real(vdsb);
    subplot(2,3,3); plot(time_window.*1000, real(vlc))
    title("Large Carrier Modulation")
    xlabel("t(ms)")
    ylabel("Volts")
    
   
    %Spectrurm Creation
    subplot(2,3,4); FourierTransformJF(vdsb, fs, 2500, 7500)
    title("Single-Sided Spectrum of DSB Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    subplot(2,3,5); FourierTransformJF(vssbu, fs, 2500, 7500)
    title("Single-Sided Spectrum of SSB Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    subplot(2,3,6); FourierTransformJF(vlc, fs, 2500, 7500)
    title("Single-Sided Spectrum of LC Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

end
