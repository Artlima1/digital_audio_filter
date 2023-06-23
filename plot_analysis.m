function plot_analysis (x, y, kw, h, fs)

    T = 1/fs;
    L = length(x);
    t = (0:L-1)*T;

    X = fft(x);
    X_mod = abs(fftshift(X));
    X_mod_dB = mag2db(X_mod);

    Y = fft(y);
    Y_mod = abs(fftshift(Y));
    Y_mod_dB = mag2db(Y_mod);

    H = fft(h, L);
    H_mod = abs(fftshift(H));
    H_ang = angle(H);
    H_mod_dB = mag2db(H_mod);

    f = fs*(-((L/2)-1):((L/2)))/L;
    
    figure
    % Plot in time
    subplot(2, 3, 1);
    plot(t, x);
    subplot(2, 3, 4);
    plot(t, y);

    % Plot in frequency
    subplot(2, 3, 2);
    plot(f, X_mod);
    subplot(2, 3, 5);
    plot(f, Y_mod);

    % Plot in frequency (dB)
    subplot(2, 3, 3);
    plot(f, X_mod_dB);
    subplot(2, 3, 6);
    plot(f, Y_mod_dB);

    figure
    % Plot the spectrograms
    subplot(1, 2, 1);
    spectrogram(x, fs, 'yaxis');
    subplot(1, 2, 2);
    spectrogram(y, fs, 'yaxis');

    figure
    % Plot the spectrograms
    subplot(2, 2, 1);
    plot((1:length(kw)), kw);
    subplot(2, 2, 2);
    impz(h);
    subplot(2, 2, 3);
    plot(f, H_mod_dB);
    subplot(2, 2, 4);
    plot(f, H_ang);

end