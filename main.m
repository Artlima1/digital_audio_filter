clc;
clear;

[audio, fs] = audioread('audio_corrompido 1.wav');
% plot_analysis(audio, fs);

[kaiser_w, kaiser_n, kaizer_beta] = get_kaiser_window(6000, 7000, 0.01, fs);
h = get_h(kaiser_w, kaiser_n);
