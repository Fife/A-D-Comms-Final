%Jacob Fifield 
%Abddullah Al Kassi
%Analog Amplitude demodulation
function [vdsbd,vssbd,vlcd] = AmplitudeDemodulation(time_window, vdsb, vssb, vlc, fs)
    f_c = 5000;
    carrier = cos(2*pi*f_c*time_window);
    
    % dsb demodulation 
    vdsbd = carrier.*vdsb;
    vdsbd = lowpass(real(vdsbd), 2500, fs, ImpulseResponse="iir",Steepness=0.95);
    subplot(3,1,1);
    plot(vdsbd);
    title("Double sideband demodulation");
    xlabel("t(ms)")
    ylabel("v(t)")

    % vssb demodulation 

    [freq, mag] = spectrum(vssb, fs, time_window);
    mag = circshift(mag, -51);
    [freq, mag] = spectrum(mag, fs, time_window);
    subplot(3,1,2);
    plot(freq, mag); 

    xlabel("t(ms)")
    ylabel("v(t)")

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
    title("Single sideband demodulation")
    
    % vlc demodulation 
    vlcd = vlc(1 : 32 : fs/100);
    subplot(3,1,3);
    plot(vlcd);
    title("LC demodulation")
    xlabel("t(ms)")
    ylabel("v(t)")
end