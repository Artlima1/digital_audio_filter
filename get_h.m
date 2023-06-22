function h  = get_h(w, N)
    n = (-N/2:(N/2)-1);
    h_ideal = transpose(sinc(n));
    h = w.*h_ideal;

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