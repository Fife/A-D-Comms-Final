%Jacob Fifield 
%CPE 3620 Project 
%Amplitude Shift Keying


function output = AmplitudeShiftKeyJF(time_window, v_t, f_s)
resampled = v_t(1:20:end);  
new_time = time_window(1:20:end);


smalltime = 0:1/8*0.00025:0.00025 - 1/8*0.00025;
carrierOn = sin(2*pi*4000*smalltime);
carrierOff = [0,0,0,0,0,0,0,0];

output=[];


for i = 1:length(resampled)
    %Convert the current data into a binary string
    data_bin = dec2bin(resampled(i), 8);

    %For each character in the binary string
    for j = 1: strlength(data_bin)

        %Convert the character back to a number for the ASK Method
        coef = str2double(data_bin(j));

        if coef == 1
            output = horzcat(output, carrierOn);
        else
            output = horzcat(output, carrierOff);
        end
    end
end


subplot(4, 2, 1); stairs(new_time, resampled);
title("Input Signal");
subplot(4, 2, 3); stairs(resampled(1:4));
title("Section of Input Signal");

subplot(4, 2, 5); plot(output(1:(32*8) + 1));
title("Section of ASK Signal");
axis([0 193 -1.2 1.2]);
[freq, mag] = spectrum(output, f_s, time_window);
subplot(4, 2, 7); plot(freq, mag);
title("Spectrum of ASK Signal");

var = repmat(carrierOn, 1, 8);
var = horzcat(var, 0);

subplot(3,2,2);plot(time_window(1:65), var)
title("Zoomed in view of carrier signal for first sample.");
axis([0 65 -1.2 1.2]);
axis padded
subplot(3,2,4);stairs([0,1,1,1,1,0,1,1])
title("Zoomed in view of data signal for first sample.");
axis padded
subplot(3,2,6);plot(output(1:65));
title("Zoomed in view of ASK Signal for first sample.");
axis padded

% xlabel('time in seconds')
% 
% subplot(2,3,2);stairs(t, sampled)
% xlabel('time in seconds')
% subplot(2,3,5);plot(linspace(0, 1e-2, length(output)), output)
% xlabel('time in seconds')
% 
% subplot(2,3,3);stairs(t, sampled)
% ylim([110 150])
% xlim([0 5.88e-4])
% xlabel('time in seconds')
% 
% subplot(2,3,6);plot(linspace(0, 1e-2, length(output)), output)
% xlim([0 5.88e-4])
% ylabel('Voltage')
% xlabel('time in seconds')
