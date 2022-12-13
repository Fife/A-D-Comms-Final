% Jacob Fifield 
% CPE 3620 Project 
% Analog to Digital- Eight Bit Sampling

function AnalogToDigitalJF(time_window, v_t, f_s)
    
    %Analog to Digital Encoding
    sample_signal = 0.5*square(2*pi*5000*time_window, 1) + 0.5;
    signal = real(v_t);
    
    nz_sampled = nonzeros(signal.*sample_signal);
    sampled = (signal.*sample_signal);
    

    for sample = 2:numel(sampled)
      if sampled(sample) == 0
        sampled(sample) = sampled(sample-1);
      end
    end
    
    subplot(5,2,1);plot(time_window*1000, signal.*1000)
    title("Input Signal")
    xlabel("t (ms)")
    ylabel("mV")
    subplot(3,2,2);FourierTransformJF(signal, f_s, 100, 7000)
    title("Amplitude Spectrum of Input Signal")
    
    subplot(5,2,3);stairs(time_window*1000, sample_signal)
    title("Periodic Sampling Impluse of 2.5kHz")
    xlabel("t (ms)")
    ylabel("Logic Level")

    new_ts = (1:1:length(nz_sampled)).*0.2;
    subplot(5,2,5);stairs(new_ts, nz_sampled.*1000)
    title("Sampled Signal")
    xlabel("t (ms)")
    ylabel("mV")

    subplot(3,2,4);FourierTransformJF(sampled, f_s, 100, 7000)
    title("Amplitude Spectrum of Sampled Signal")
    sampled = round(250*128.*nz_sampled + 127); 

    %Encoding from digital to NRZ 
    output = [];
    for i = 1:length(sampled)-1
    %Convert the current data into a binary string
    data_bin = dec2bin(sampled(i), 8);

    %For each character in the binary string
        for j = 1: strlength(data_bin)
    
            %Convert the character back to a number for the NRZ Method
            coef = str2double(data_bin(j));

            %Calculate start and end times for the bit
            start_time = (i-1) * (1/f_s);
            end_time = start_time + 1/f_s;
   
            
            %Perform ASK and append the output
            output = horzcat(output, coef);
        end
    end


    subplot(5,2,7);stairs(new_ts, sampled);
    title("Quantized 8-Bit PCM Signal- Unipolar Encoding")
    ylabel("PCM Word")
    xlabel("t (ms)")

    nrzl_ts = (1:1:length(output)).*0.025;
    subplot(5,2,9);stairs(nrzl_ts, output);
    title("NRZ-L PCM Signal")
    xlabel("t (ms)")
    ylabel("Logic Level")

end

%     sample_signal = square(2*pi*f_s*time_window);
%     signal = 250.*v_t;
%     
%     sampled = repelem(signal.*sample_signal, 4);
%     interp_time = 0:1/(4*f_s):0.01-1/f_s;
%     
%     %Modulation Plots
%     
%     %Input Signal
%     subplot(3,2,1);plot(time_window.*1000, v_t)
%     title("Input Signal")
%     xlabel("t (ms)")
%     ylabel("v(t)")
%     
%     v_f = fft(v_t);
%     f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
%     v_fsub = abs(v_f);
%     
%     subplot(3,2,2); stem(f, v_fsub)
%     title("Single-Sided Amplitude Spectrum of Input Signal")
%     xlabel("f (Hz)")
%     ylabel("|V(f)|")
%     
% 
%     %Modulated Signal
%     v_f = fft(sampled);
%     f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
%     v_fsub = abs(v_f);
%     subplot(3,2,3);stairs(interp_time, sampled)
%     title("Modulated Signal")
%     xlabel("t (ms)")
%     ylabel("v(t)")
%     
%     subplot(3,2,4); stem(f, v_fsub)
%     title("Single-Sided Amplitude Spectrum of Modulated Signal")
%     xlabel("f (Hz)")
%     ylabel("|V(f)|")
% 
% 
% %     %Demodulated Signal
% %     sampled = (sampled./256)./250;
% %     v_f = fft(sampled);
% %     f = (0:length(v_f)-1)*f_s/length(v_f);   % Frequency Window
% %     v_fsub = abs(v_f);
% %     
% %     subplot(3,2,5);plot(time_window*1000, sampled)
% %     title("Demodulated Signal")
% %     xlabel("t (ms)")
% %     ylabel("v(t)")
% % 
% %     subplot(3,2,6); stem(f, v_fsub)
% %     title("Single-Sided Amplitude Spectrum of Modulated Signal")
% %     xlabel("f (Hz)")
% %     ylabel("|V(f)|")