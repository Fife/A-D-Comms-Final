% Jacob Fifield 
% CPE 3620 Project 
% Analog to Digital- Eight Bit Sampling

function AnalogToDigitalJF(time_window, v_t)

    signal = 250.*v_t;
    sampled = round(127*signal + 127);
    
    subplot(2,1,1);plot(time_window, signal)
    subplot(2,1,2);stairs(time_window, sampled)
end