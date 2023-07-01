clc;
clear;

% Reading the audio file
[audio, fs] = audioread('audio_corrompido 1.wav');

% Filtering full audio
tic
[y_full, kw, beta, h, Nh] = fir_lfl_kw_os(audio, fs, [5000, 6000, 0.01], 500, [1, length(audio)]);
toc

% Filtering only noise window
tic
[y_selected, kw, beta, h, Nh] = fir_lfl_kw_os(audio, fs, [5000, 6000, 0.01], 500, [1000000, 1500000]);
toc

plot_analysis(audio, y_full, y_selected, kw, h, fs);