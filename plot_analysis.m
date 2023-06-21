function plot_analysis (sig, fs)

    T = 1/fs;
    L = length(sig);
    t = (0:L-1)*T;

    sig_fft = fft(sig);
    f = fs*(-((L/2)-1):((L/2)))/L;
    
    % Plot the signal in time
    subplot(2, 1, 1);
    plot(t, sig);

    subplot(2, 1, 2);
    y = abs(fftshift(sig_fft));
    plot(f, y)

end