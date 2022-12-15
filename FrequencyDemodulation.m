%Analog frquency demodulation
function FrequencyDemodulation(time_window,v_t, fs, vfm)
    clipped = vfm;
    clipped(clipped>0.5) = 0.5;
    clipped(clipped<-0.5) = -0.5;
    vfm_dif = diff(clipped);
    vfm_dif = [0 vfm_dif];
    ddt= lowpass(abs(vfm_dif), 4800, fs, ImpulseResponse="iir",Steepness=0.95);
    plot(ddt);
end
