clc
clear all
close all

mdlLQR = 'LQR';
open_system(mdlLQR);

% Definizione parametri del sistema
F = 0;
d1 = 0.01;
d2 = 0.01;
g = 9.81;
g_q = [1; 0];
L = 1;

% Definizione matrici Q e R
Q = diag([3, 1, 1, 1]); % Esempio di matrice Q
R = 2; % Esempio di matrice R

% Stampa delle matrici Q e R
disp('Matrice Q:');
disp(Q);

disp('Matrice R:');
disp(R);

% Parametri LQR
K_lqr = [-14.1421000000000, 171.884600000000, -25.2787000000000, 54.7535000000000];
mc = 1.5;
mp = 0.5;
N = 2;
x_0 = [0.100000000000000; 0.174532925199433; 0; 0];

% Apri sistema e simula
open_system([mdlLQR '/System/Animation/Graph'])
sim(mdlLQR)
