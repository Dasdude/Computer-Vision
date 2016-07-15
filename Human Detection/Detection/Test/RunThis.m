clc
close all
clear
addpath('Functions/')
%% Parameters
filename ='crop_00000'
step = 32;
scaleTotal = 4;
% Total Number of Scales
windowSize = 3;
% Window Size for NonMaxima Supression
scaleRate = 2;
% How the Scale Changes in pyramid
SVMDataName = 'SVM-TotalSamples700-C0.01';
% input SVM Data which is Computed by Training Function
threshold = .99;
for i= 2:6
    DetectorFunction( [filename num2str(i) '.png'] , step , scaleTotal , windowSize,SVMDataName,scaleRate,threshold );
end