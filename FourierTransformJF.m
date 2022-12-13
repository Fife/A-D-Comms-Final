function FourierTransformJF(v_t, f_s, f_start, f_stop)
    if ~exist('f_start', 'var')
        f_start = 1;
    else
        f_start = f_start/100;
    end 

    v_f = fft(v_t);
    if ~exist('f_stop', 'var')
        f_stop = length(v_f);
    else
        f_stop = f_stop/100;
    end

    %Plot the Frequency Generation
    f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
    v_fsub = abs(v_f);
    
    stem(f(f_start:f_stop), v_fsub(f_start:f_stop))
    xlabel("f (Hz)")
    ylabel("|V(f)|")
end