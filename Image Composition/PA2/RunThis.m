clc
close all
clear
addpath('Functions')
%% Input Files
ghost= im2double(imread('Data\1.jpg'));
nick = im2double(imread('Data\2.jpg'));
apple = im2double(imread('Data\apple.jpg'));
orange = im2double(imread('Data\orange.jpg'));
man = imread('Data\bullMan.jpg');
% man = rgb2gray(man);
bull = man(:,floor(end/2):end,:);
man = man(:,1:floor(end/2),:);
young = imread('Data\Matt.jpg');
% young = rgb2gray(young);
old = young(:,floor(end/2):end,:);
young = young(:,1:floor(end/2),:);
rup = imread('Data\rupdav.jpg');
% rup = rgb2gray(rup);
dave = rup(:,floor(end/2):end,:);
rup = rup(:,1:floor(end/2),:);

% ghost = rgb2gray(ghost);
% orange = rgb2gray(orange);
% apple = rgb2gray(apple);
% nick = rgb2gray(nick);
%% Inputs
% Window Size
hs=5;
% Sigma
sigma=1;
% Pyramid Level
%% Show Gaussian Pyramid
gpGhost =gaussianPyramid(ghost,9,hs,sigma);
figure(1);
for i=1:9
    subplot(3,3,i);
    imshow(gpGhost{i});
    title(['Gaussian level: ' num2str(i)])
end

%% Show Laplacian Pyramid
lpGhost = LaplacianPyramid(gpGhost ,hs,sigma);
figure(2);
for i=1:9
    subplot(3,3,i);
    imshow(lpGhost{i});
    title(['Laplacian level: ' num2str(i)])
end


%% Image Composit - Different Levels
figure;
lvl = 2:2:8;
for i= 1:4
    subplot(2,2,i);
    q = Comp(orange,apple,sigma,hs,lvl(i));
    imshow(q);
    title(['Level : ' num2str(lvl(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(nick,ghost,sigma,hs,lvl(i));
    imshow(q);
    title(['Level : ' num2str(lvl(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(man,bull,sigma,hs,lvl(i));
    imshow(q);
    title(['Level : ' num2str(lvl(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(rup,dave,sigma,hs,lvl(i));
    imshow(q);
    title(['Level : ' num2str(lvl(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(nick,ghost,sigma,hs,lvl(i));
    imshow(q);
    title(['Level : ' num2str(lvl(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(young,old,sigma,hs,lvl(i));
    imshow(q);
    title(['Level : ' num2str(lvl(i))]); 
end
%% Show Different Mask
figure;
lvl=4;
hs = 5:2:11;
for i= 1:4
    subplot(2,2,i);
    q = Comp(orange,apple,sigma,hs(i),lvl);
    imshow(q);
    title(['Window : ' num2str(hs(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(nick,ghost,sigma,hs(i),lvl);
    imshow(q);
    title(['Window : ' num2str(hs(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(man,bull,sigma,hs(i),lvl);
    imshow(q);
    title(['Window : ' num2str(hs(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(rup,dave,sigma,hs(i),lvl);
    imshow(q);
    title(['Window : ' num2str(hs(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(nick,ghost,sigma,hs(i),lvl);
    imshow(q);
    title(['Window : ' num2str(hs(i))]); 
end
figure;
for i= 1:4
    subplot(2,2,i);
    q = Comp(young,old,sigma,hs(i),lvl);
    imshow(q);
    title(['Window : ' num2str(hs(i))]); 
end