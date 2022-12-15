
%Analog Amplitude demodulation
function [vdsbd,vssbd,vlcd] = AmplitudeDemodulation(time_window, vdsb, vssb, vlc, fs)
    f_c = 5000;
    carrier = cos(2*pi*f_c*time_window);
    
    % dsb demodulation 
    vdsbd = carrier.*vdsb;
    vdsbd = lowpass(real(vdsbd), 2500, fs, ImpulseResponse="iir",Steepness=0.95);
    subplot(2,3,1);plot(time_window.*1000, vdsbd);
    title("Double sideband demodulation");
    xlabel("t(ms)")
    ylabel("v(t)")

    [freq, mag] = spectrum(vdsbd, fs, time_window);
    subplot(2,3,4);stem(freq(1:75), mag(1:75));
    title("Single-Sided Spectrum of Demodulated DSB Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    % vssb demodulation 

    subplot(2,3,2);plot(time_window.*1000, vdsbd)
    title("Demodulated SSB Signal")
    xlabel("t(ms)")
    ylabel("v(t)")

    [freq, mag] = spectrum(vdsbd, fs, time_window);
    subplot(2,3,5);stem(freq(1:75), mag(1:75));
    title("Single-Sided Spectrum of Demodulated SSB Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")


    %stem(vssbd);
    % v_f = abs(fft(vssb));
    % for i= 51:2:71
    %     v_f(i-50)=v_f(i);
    %     v_f(i)=0;
    % end
    % vssbd = real(fft(v_f));
    % vssbd = vssbd/carrier;
    % figure 
    % plot(vssbd);
    %[frequency,Magnitude] = spectrum(vssbd,fs,time_window)
    %stem(frequency,Magnitude);
    title("Single-Sided Spectrum of Demodulated SSB Signal")
    
    % vlc demodulation 
    vlcd = vlc(1 : 32 : fs/100);
    subplot(2,3,3);plot(vlcd);
    title("LC demodulation")
    xlabel("t(ms)")
    ylabel("v(t)")

    subplot(2,3,6);stem(freq(1:50), mag(1:50));
    title("Single-Sided Spectrum of Demodulated LC Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")
end