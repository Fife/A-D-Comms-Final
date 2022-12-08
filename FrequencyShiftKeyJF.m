%Jacob Fifield 
%CPE 3620 Project 
%Frequency Shift Keying
clc
clear

output = [];

f_s = 5000;
f_trs = 100000;

t = 0: 1/f_s :1e-2;
signal = 250*real(eval(ExponentialFourierSeriesJF(t, 5)));
sampled = round(127*signal + 127);

t_ask = 0:(1/f_trs):(1/f_s);
t_total = 0:1/(f_trs):1e-2;


for i = 1:length(sampled)-1
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
        start_time = (i-1) * (1/f_s);
        end_time = start_time + 1/f_s;

        timescale = start_time:(1/f_trs):end_time;
        
        %Perform ASK and append the output
        next_output = sin(2*pi*f_s*freq_mult*timescale);
        output = horzcat(output, next_output);
    end
end

subplot(2,1,1);stairs(t, sampled)
subplot(2,1,2);plot(linspace(0, 1e-2, length(output)), output)