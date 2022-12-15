%Jacob Fifield 
%Abddullah Al Kassi
% CPE 3620 Project 
% Exponential Fourier Series Generation 

function pfs = ExponentialFourierSeriesJF(time_window, terms)
    %Time window and angle parameters
    f = 1/0.01;
    w = 2*pi*f;
    
    %Breaking up one cycle of the function into 4 seperate symbolic functions
    syms v_1(t) v_2(t) v_3(t) v_4(t) t n;
    
    v_1(t) = 1*t;
    v_2(t) = -4*t + 0.020;
    v_3(t) = -1*t + 0.005;
    v_4(t) = 4*t - 0.040;
    
    %Creating the exponential term as a symbolic function for ease of re-use
    syms neg_ex(n, t) pos_ex(n,t);
    neg_ex(n, t) = exp(-1i*w*n*t);
    pos_ex(n,t) = exp(1i*w*n*t);
    
    %Creating the exponential Coefficient formula as a symbolic function for ease of re-use
    syms C_n(n, t);
    C_n(n, t) = (1/0.01)*(int(v_1(t)*neg_ex(n,t) ,t, [0 0.004])...
         + int(v_2(t)*neg_ex(n,t),t, [0.004 0.005])...
         + int(v_3(t)*neg_ex(n,t),t, [0.005 0.009])...
         + int(v_4(t)*neg_ex(n,t),t, [0.009 0.010]));
    
    %Create the Exponential Fourier Series inner and final term as a symbolic function for ease of re-use
    syms fs_inner(n, t) fs_left(t) fs_right(t) fs_final(t);
    fs_inner(n, t) = C_n(n, t) * pos_ex(n,t);
    
    %Generate Fourier Series, note that terms are the number of terms on each
    %side of 0. As we cannot use 0 itself, we will go from -terms to -1 and 1
    %to terms.
    fs_left(t) = symsum(fs_inner(n, t), n, -1*terms, -1);
    fs_right(t) = symsum(fs_inner(n, t), n, 1, terms);
    
    %Add left and right side of Fourier Series
    fs_final(t) = fs_right(t) + fs_left(t);
    pfs = fs_final(time_window);

end




