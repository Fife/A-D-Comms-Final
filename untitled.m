f_s = 100000;
time_window = 0:1/f_s:0.01-1/f_s;

figure
hold on
plot(sin(2*pi*100*time_window))
plot(sin(2*pi*1000*time_window))