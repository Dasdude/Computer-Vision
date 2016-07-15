clc
close all
clear
%
% mode defines the method to find vanishing points. 'H' for hough auto line
% detection and 'M' for manual interactive point detection, 
%Rectification Methods:
% A : Affine
% M: Metric
im = imread('./Data/Crop_circles.jpg');
mode ='M';
rectification = 'M'
switch rectification
    case 'A'
        affineRectify(im,mode);
    case 'M'
        metric(im,mode);
    otherwise
        display('invalid parameters');
end