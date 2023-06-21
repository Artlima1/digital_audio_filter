function plot_analysis (sig, fs)

    T = 1/fs;
    L = length(sig);
    t = (0:L-1)*T;

    sig_fft = fft(sig);
    sif_fft_mod = abs(fftshift(sig_fft));
    f = fs*(-((L/2)-1):((L/2)))/L;
    
    % Plot the signal in time
    subplot(2, 2, 1);
    plot(t, sig);

    % Plot the signal in frequency
    subplot(2, 2, 2);
    plot(f, sif_fft_mod)

    % Plot the signal in frequency (dB)
    subplot(2, 2, 3);
    y = mag2db(sif_fft_mod);
    plot(f, y)

    % Plot the signal spectrogram
    subplot(2, 2, 4);
    spectrogram(sig, fs, 'yaxis')

end