function [freq, mag] = spectrum(v_t, fs, time_window)
    Y = real(fft(v_t));   
    L = length(time_window);             % Length of signal
    P2 = abs(Y/L);
    mag = P2(1:L/2+1);
    mag(2:end-1) = 2*mag(2:end-1);
    freq = fs*(0:(L/2))/L;
    
end
