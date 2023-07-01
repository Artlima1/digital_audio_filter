function plot_analysis (x, y1, y2, kw, h, fs)

    T = 1/fs;
    L = length(x);
    t = (0:L-1)*T;

    X = fft(x);
    X_mod = abs(fftshift(X));
    X_mod_dB = mag2db(X_mod);

    Y1 = fft(y1);
    Y1_mod = abs(fftshift(Y1));
    Y1_mod_dB = mag2db(Y1_mod);

    Y2 = fft(y2);
    Y2_mod = abs(fftshift(Y2));
    Y2_mod_dB = mag2db(Y2_mod);

    H = fft(h, L);
    H_mod = abs(fftshift(H));
    H_ang = angle(H);
    H_mod_dB = mag2db(H_mod);

    f = fs*(-((L/2)-1):((L/2)))/L;
    
    figure
    % Plot in time
    subplot(1, 3, 1);
    plot(t, x);
    subplot(1, 3, 2);
    plot(t, y1);
    subplot(1, 3, 3);
    plot(t, y2);

    figure
    % Plot in frequency
    subplot(1, 3, 1);
    plot(f, X_mod);
    subplot(1, 3, 2);
    plot(f, Y1_mod);
    subplot(1, 3, 3);
    plot(f, Y2_mod);

    figure
    % Plot in frequency (dB)
    subplot(1, 3, 1);
    plot(f, X_mod_dB);
    subplot(1, 3, 2);
    plot(f, Y1_mod_dB);
    subplot(1, 3, 3);
    plot(f, Y2_mod_dB);

    figure
    % Plot the spectrograms
    subplot(1, 3, 1);
    spectrogram(x, fs, 'yaxis');
    subplot(1, 3, 2);
    spectrogram(y1, fs, 'yaxis');
    subplot(1, 3, 2);
    spectrogram(y2, fs, 'yaxis');

    figure
    % Plot h[n] charts
    subplot(2, 2, 1);
    plot((1:length(kw)), kw);
    subplot(2, 2, 2);
    impz(h);
    subplot(2, 2, 3);
    plot(f, H_mod_dB);
    subplot(2, 2, 4);
    plot(f, H_ang);

end