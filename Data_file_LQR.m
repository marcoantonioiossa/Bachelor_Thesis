clc
clear all
close all
addpath('D:\Work\10\IP_c\Project');
mdlLQR = 'LQR';
open_system(mdlLQR);
%External Force
F=100
d1=0.01;
d2=0.01;
g=9.81;
g_q=[1;0];
L=1;
K_lqr=[-14.1421000000000,171.884600000000,-25.2787000000000,54.7535000000000];
mc=1.5;
mp=0.5;
N=2;
x_0=[0.100000000000000;0.174532925199433;0;0];
open_system([mdlLQR '/System/Animation/Graph'])
sim(mdlLQR) 