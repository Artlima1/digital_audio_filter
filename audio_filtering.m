clc;
clear;

% Reading the audio file
[audio, fs] = audioread('audio_corrompido 1.wav');

% Filtering full audio
% [y, kw, beta, h, Nh] = fir_lfl_kw_os(audio, fs, [5000, 6000, 0.01], 500, [1, length(audio)]);
% plot_analysis(audio, y, kw, h, fs);

% Filtering only noise window
[y, kw, beta, h, Nh] = fir_lfl_kw_os(audio, fs, [5000, 6000, 0.01], 500, [500000, 2000000]);
plot_analysis(audio, y, kw, h, fs);