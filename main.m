clc;
clear;

f_p = 6000; f_r = 7000; ripple = 0.01;
L_block = 3000;

[audio, fs] = audioread('audio_corrompido 1.wav');
% plot_analysis(audio, fs);

[kaiser_w, kaiser_n, kaiser_beta] = get_kaiser_window(f_p, f_r, ripple, fs);
h = get_h(kaiser_w, f_p, f_r, fs);

num_of_full_blocks = floor(length(audio)/L_block);

Nx = L_block;
Nh = kaiser_n;
Ny = Nx+Nh-1;

h_e = h;
h_e(Nh+1 : Ny) = 0;
H_e = fft(h_e);

y = zeros(length(audio), 1);
for k = 1:num_of_full_blocks-1
    start_pos = (k-1)*Nx+1;
    x_k = audio(start_pos : k*Nx);

    x_e = x_k;
    x_e(Nx+1 : Ny) = 0;
    X_e = fft(x_e);

    y_k = ifft(X_e.*H_e);
    y(start_pos : start_pos+Ny-1) = y(start_pos : start_pos+Ny-1) + y_k;
end

figure
wvtool(audio);
figure
wvtool(y);