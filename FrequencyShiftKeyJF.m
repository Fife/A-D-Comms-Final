%Jacob Fifield 
%CPE 3620 Project 
%Frequency Shift Keying

function output = FrequencyShiftKeyJF(t, adc_input, f_s, f_s_adc, orig)
    output = [];
    sampled = adc_input(1:f_s/f_s_adc:end);
    
    for i = 1:length(sampled)
        %Convert the current data into a binary string
        data_bin = dec2bin(sampled(i), 8);
    
        %For each character in the binary string
        for j = 1: strlength(data_bin)
    
            %Convert the character back to a number for the ASK Method
            coef = str2double(data_bin(j));
            if coef == 1
                freq_mult = 2;
            else
                freq_mult = 1;
            end

            %Calculate start and end times for the bit
            start_time = (i-1) * (1/f_s_adc);
            end_time = start_time + 1/f_s_adc;
    
            timescale = start_time:(1/f_s):end_time-1/f_s;
            
            %Perform ASK and append the output
            next_output = sin(2*pi*f_s_adc*freq_mult*timescale);
            output = horzcat(output, next_output);
        end
    end
    subplot(4, 2, 1); plot(t.*1000, orig.*1000);
    title("Original Input Signal");
    xlabel("t (ms)")
    ylabel("8-Bit Word")

    [freq, mag] = spectrum(orig, f_s, t);
    subplot(2,2,2); stem(freq(1:60), mag(1:60))
    title("Single-Sided Spectrum of Input Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

    subplot(4, 2, 3); stairs(linspace(0,10, 40), sampled);
    title("Sampled Input Signal");
    axis([0 10 0 255])
    xlabel("t (ms)")
    ylabel("8-Bit Word")

    subplot(4,2,5);stairs(sampled(1:3))
    axis([1 3 120 138])
    xlabel("Sample Number")
    ylabel("8-Bit Word")

    title("Section of Sampled Signal");
    subplot(4,2,7);plot(t(1:640).*10000, output(1:640))
    title("Section of FSK Signal");
    xlabel("t (us)")
    ylabel("Volts (mV)")

    [freq, mag] = spectrum(output, f_s, t);
    subplot(2,2,4); plot(freq, mag)
    title("Single-Sided Spectrum of FSK Signal")
    xlabel("f (Hz)")
    ylabel("|V(f)|")

end