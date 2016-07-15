clc
clear
close all
%% Variable Declaration
URL = './yalefaces/';
samplesofEachPerson = 7;
totalPerson  = 4;
compressRate = .5;

%% Computation
[t,q,a]=PCAFunction(URL,totalPerson,samplesofEachPerson,'lbp',compressRate);
