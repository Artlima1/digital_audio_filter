clc;
clear;

% Parameters
f_p = 5000; f_r = 6000; ripple = 0.01;
L_block = 500;

% Reading the audio file
[audio, fs] = audioread('audio_corrompido 1.wav');

% Getting Kaiser window
[N, ~, beta, ~] = kaiserord( [f_p f_r], [1 0], [ripple ripple], fs );
window = kaiser(N, beta);

% Bulding h[n]
wc = (f_r + f_p) * pi / fs;
n = (0:N-1);
h_ideal = transpose(sinc((wc/pi).*(n-(N/2))));
h = window.*h_ideal;

% Calculating parameters for FIR filter with Overlap-add
num_of_full_blocks = floor(length(audio)/L_block);
Nx = L_block;
Nh = N;
Ny = Nx+Nh-1;
h_e = h;
h_e(Nh+1 : Ny) = 0;
H_e = fft(h_e);

% Creating y[n] and filling it using Overlap-add
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

% Clearing local variables
clear f_p f_r ripple L_block wc n h_ideal Nx Nh Ny h_e H_e k num_of_full_blocks start_pos x_k x_e X_e y_k