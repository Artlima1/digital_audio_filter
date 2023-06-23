function h  = get_h(window, f_p, f_r, fs)
    wc = (f_r + f_p) * pi / fs;
    N = length(window);
    n = (0:N-1);
    h_ideal = transpose(sinc((wc/pi).*(n-(N/2))));
    h = window.*h_ideal;

    % plt = figure;
    % plt.subplot(2,2,1)
    % plt.plot(n, w)
    % 
    % plt.subplot(2,2,2)
    % plt.plot(n, h_ideal)
    % 
    % plt.subplot(2,2,3)
    % plt.plot(n, h)
end