function [y, kw, beta, h, Nh] = fir_lfl_kw_os(x, fs, filter_params, L_block, interval)
% fir_lfl_kw_os(x, fs, filter_params, L_block) 
    % Finite impulse response low pass filter with kaiser window and
    % overlap-save
    % 
    % Params:
    %     x -> x[n], src signal
    %     fs -> frequency of sampling
    %     filter_params -> array of params [fp fr ripple]
    %         fp -> passing band frequency
    %         fr -> rejection band frequency
    %         ripple -> tolerable ripple for passing and rejection band
    %     L_block -> block size to use in overlap-save
    %     interval -> [start end], interval in which to apply the filter
    % Return:
    %     y -> y[n], filtered signal
    %     kw -> kaiser window used for filtering
    %     beta -> beta value for kaiser window
    %     h -> h[n] obtained
    %     Nh -> length of h[n], also the order of the kaiser filter

    
    f_p = filter_params(1);
    f_r = filter_params(2);
    ripple = filter_params(3);

    % Getting Kaiser window
    [N, ~, beta, ~] = kaiserord( [f_p f_r], [1 0], [ripple ripple], fs );
    kw = kaiser(N, beta);
    
    % Bulding h[n]
    wc = (f_r + f_p) * pi / fs;
    n = (0:N-1);
    h_ideal = transpose(sinc((wc/pi).*(n-(N/2))));
    h = kw.*h_ideal;
    
    % Calculating parameters for FIR filter with Overlap-add
    num_of_full_blocks = floor(length(x)/L_block);
    Nx = L_block;
    Nh = N;
    Ny = Nx+Nh-1;
    h_e = h;
    h_e(Nh+1 : Ny) = 0;
    H_e = fft(h_e);
    
    % Creating y[n] and filling it using Overlap-add
    y = zeros(length(x), 1);
    for k = 1:num_of_full_blocks-1
        start_pos = (k-1)*Nx+1;
        x_k = x(start_pos : k*Nx);
        if((start_pos >= interval(1)) && (start_pos < interval(2)))
            x_e = x_k;
            x_e(Nx+1 : Ny) = 0;
            X_e = fft(x_e);
            y_k = ifft(X_e.*H_e);
        else
            y_k = x_k;
            y_k((length(x_k)+1):Ny) = 0;
        end
        y(start_pos : start_pos+Ny-1) = y(start_pos : start_pos+Ny-1) + y_k;
    end
end