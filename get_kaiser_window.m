function [w, n, beta]  = get_kaiser_window(f_p, f_s, ripple, fs)
    [n, ~, beta, ~] = kaiserord( [f_p f_s], [1 0], [ripple ripple], fs );
    w = kaiser(n, beta);
end