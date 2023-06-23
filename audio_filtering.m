clc;
clear;

% Reading the audio file
[audio, fs] = audioread('audio_corrompido 1.wav');

% Filtering audio and obtaining infos
[y, kw, beta, h, Nh] = fir_lfl_kw_os(audio, fs, [5000, 6000, 0.01], 500);

plot_analysis(audio, y, kw, h, fs);