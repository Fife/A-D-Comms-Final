%Jacob Fifield 
%Abddullah Al Kassi
% CPE 3620 Project 

clc
clear

output = [];

f_s = 500;
f_trs = 100000;

t = 0: 1/f_s :1e-2;
signal = 250*real(eval(ExponentialFourierSeriesJF(t, 5)));
sampled = round(127*signal + 127);

t_ask = 0:(1/f_trs):(1/f_s);
t_total = 0:1/(f_trs):1e-2;


for i = 1:length(sampled)
    %Convert the current data into a binary string
    data_bin = dec2bin(sampled(i), 8);

    %For each character in the binary string
    for j = 1: strlength(data_bin)/2

        %Convert the character back to a number for the QPSK Method

        coef = str2double(data_bin((j*2) - 1))*2 + str2double(data_bin(2*j));

        if coef == 0
            phase = (3*pi)/4;
        elseif coef == 1
            phase = (-3*pi)/4;
        elseif coef == 2
            phase = pi/4;
        elseif coef == 3
            phase = -pi/4;
        end
        
        %Calculate start and end times for the bit
        start_time = (i-1) * (1/f_s);
        end_time = start_time + 1/f_s;

        timescale = start_time:(1/f_trs):end_time;
        
        %Perform ASK and append the output
        next_output = cos(2*pi*f_s*timescale + phase);
        output = horzcat(output, next_output);
    end
end

figure
subplot(2,1,1);stairs(t, sampled)
subplot(2,1,2);plot(linspace(0, 1e-2, length(output)), output)