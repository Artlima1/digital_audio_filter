clc;
clear;

[audio, fs] = audioread('audio_corrompido 1.wav');
plot_analysis(audio, fs);