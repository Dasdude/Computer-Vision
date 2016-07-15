clc
close all
clear
addpath('Functions')
%% Parameters Initialization
for i = 1:14
%% load Image
image = imread(['Data\' num2str(i) '.png']);
image = im2double(image);
%% Run HOG
H=HOG(image);
%% Visualize HOG
figure;
subplot(2,1,1);
imshow(image);
subplot(2,1,2);
HogImage =Visualize(H);
imshow(HogImage);

end
