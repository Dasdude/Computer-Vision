function [ expandedImage ] = GaussianExpand( image,hs,sigma )
%GAUSSIANEXPAND Summary of this function goes here
%   Detailed explanation goes here
H3 =fspecial('gaussian',hs,sigma);
expandedImage = imresize(image,2);
expandedImage = imfilter(expandedImage,H3);
end

