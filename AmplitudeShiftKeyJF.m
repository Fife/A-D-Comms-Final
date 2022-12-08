%Jacob Fifield 
%CPE 3620 Project 
%Amplitude Shift Keying
clc
clear

%sampled = [173];
output = [];

f_s = 5000;
f_trs = 100000;

t = 0: 1/f_s :1e-2;
signal = real(eval(ExponentialFourierSeriesJF(t, 5)));
sampled = round(127*250*signal + 127);

t_ask = 0:(1/f_trs):(1/f_s);
t_total = 0:1/(f_trs):1e-2;


for i = 1:length(sampled)
    %Convert the current data into a binary string
    data_bin = dec2bin(sampled(i), 8);

    %For each character in the binary string
    for j = 1: strlength(data_bin)

        %Convert the character back to a number for the ASK Method
        coef = str2double(data_bin(j));

        %Calculate start and end times for the bit
        start_time = (i-1) * (1/f_s);
        end_time = start_time + (1/f_s - 1/f_trs);

        timescale = start_time:(1/f_trs):end_time;
        
        %Perform ASK and append the output
        next_output = coef.*sin(2*pi*f_s*timescale);
        output = horzcat(output, next_output);
    end
end

subplot(2,3,1);plot(t, signal)
xlabel('time in seconds')

subplot(2,3,2);stairs(t, sampled)
xlabel('time in seconds')
subplot(2,3,5);plot(linspace(0, 1e-2, length(output)), output)
xlabel('time in seconds')

subplot(2,3,3);stairs(t, sampled)
ylim([110 150])
xlim([0 5.88e-4])
xlabel('time in seconds')

subplot(2,3,6);plot(linspace(0, 1e-2, length(output)), output)
xlim([0 5.88e-4])
ylabel('Voltage')
xlabel('time in seconds')
