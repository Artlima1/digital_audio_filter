function plot_analysis (x, y1, y2, kw, h, beta, fs)

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
    subplot(3, 1, 1);
    plot(t, x);
    title("x[n]");
    ylabel('x[n]');
    xlabel('n (samples)');

    subplot(3, 1, 2);
    plot(t, y1);
    title("y[n] (without time analysis)");
    ylabel('y[n]');
    xlabel('n (samples)');

    subplot(3, 1, 3);
    plot(t, y2);
    title("y[n] (with time analysis)");
    ylabel('y[n]');
    xlabel('n (samples)');

    figure
    % Plot in frequency
    subplot(3, 1, 1);
    plot(f, X_mod);
    title("Mag Resp of x[n]");
    ylabel('|X(e^{jw})|');
    xlabel('freq (hz)');

    subplot(3, 1, 2);
    plot(f, Y1_mod);
    title("Mag Resp of y[n] (without time analysis)");
    ylabel('|Y(e^{jw})|');
    xlabel('freq (hz)');

    subplot(3, 1, 3);
    plot(f, Y2_mod);
    title("Mag Resp of y[n] (with time analysis)");
    ylabel('|Y(e^{jw})|');
    xlabel('freq (hz)');

    figure
    % Plot in frequency (dB)
    subplot(3, 1, 1);
    plot(f, X_mod_dB);
    title("Mag Resp in dB of x[n]");
    ylabel('|X(e^{jw})|_{dB}');
    xlabel('freq (hz)');

    subplot(3, 1, 2);
    plot(f, Y1_mod_dB);
    title("Mag Resp in dB of y[n] (without time analysis)");
    ylabel('|Y(e^{jw})|_{dB}');
    xlabel('freq (hz)');

    subplot(3, 1, 3);
    plot(f, Y2_mod_dB);
    title("Mag Resp in dB of y[n] (with time analysis)");
    ylabel('|Y(e^{jw})|_{dB}');
    xlabel('freq (hz)');

    figure
    % Plot h[n] charts
    subplot(2, 2, 1);
    plot((1:length(kw)), kw);
    title("Kaiser Window with order " + (length(h)-1) + " and beta " + beta);
    xlabel('n (taps)');

    subplot(2, 2, 2);
    impz(h);
    title("Impulse response of h[n]");
    xlabel('n (taps)') 

    subplot(2, 2, 3);
    plot(f, H_mod_dB);
    title("Mag Resp in dB of h[n]");
    ylabel('|H(e^{jw})|_{dB}');
    xlabel('freq (hz)');

    subplot(2, 2, 4);
    plot(f, H_ang);
    title("Ang Resp of h[n]");
    ylabel('\theta(H(e^{jw})');
    xlabel('freq (hz)');

end