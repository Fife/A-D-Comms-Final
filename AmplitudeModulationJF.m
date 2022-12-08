% Jacob Fifield 
% CPE 3620 Project 
% Amplitude Modulation

function vdsb = AmplitudeModulationJF(time_window, v_t, fs)
    syms carrier(t)
    f_c = 2500;
    carrier(t)= cos(2*pi*f_c*t);

    % DSB AM
    vdsb = eval(real(carrier(time_window).*v_t));
    subplot(2,3,1); plot(time_window, real(vdsb))
    
    % SSB AM 
    vssbu = highpass(real(vdsb), f_c, fs, ImpulseResponse="iir",Steepness=0.95);
    subplot(2,3,2); plot(time_window, vssbu)
    
    % Large Carrier AM 
    vlc = eval(carrier(time_window)) + 125*real(vdsb);
    subplot(2,3,3); plot(time_window, real(vlc))
    
   
    %Spectrurm Creation
    NFFT = length(vdsb);
    Y = fft(vdsb,NFFT);
    F = ((0:1/NFFT:1-1/NFFT)*fs).';
    VmagDSB = abs(Y);
    subplot(2,3,4); stem(F(1:50), VmagDSB(1:50) )
    
    NFFT = length(vssbu);
    Y = fft(vssbu,NFFT);
    F = ((0:1/NFFT:1-1/NFFT)*fs).';
    VmagSSBU = abs(Y);
    subplot(2,3,5); stem(F(1:50), VmagSSBU(1:50))
    
    NFFT = length(vlc);
    Y = fft(vlc,NFFT);
    F = ((0:1/NFFT:1-1/NFFT)*fs).';
    VmagLC = abs(Y);
    subplot(2,3,6); stem(F(1:50), VmagLC(1:50))
end
