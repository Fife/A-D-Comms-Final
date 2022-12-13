%Jacob Fifield 
%CPE 3620 Project 
%Amplitude Shift Keying


function output = AmplitudeShiftKeyJF(time_window, v_t, f_s)

signal = v_t;
sampled = round(128*250*signal + 127);

smalltime = linspace(0, 100e-6, 8);
carrierOn = sin(2*pi*8000*smalltime);
carrierOff = [0,0,0,0,0,0,0,0];

output=[];


for i = 1:length(sampled)
    %Convert the current data into a binary string
    data_bin = dec2bin(sampled(i), 8);

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

subplot(2,1,1);plot(output(1:65))
title("Zoomed in view of first sample. Sample Value = 109")

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
