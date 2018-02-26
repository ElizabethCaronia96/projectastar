%% Create mazes
clc, clear, close all

[lines, board, hist, result] = maze(50,50)
board(1,1) = 0;
board(50, 50) = 1;