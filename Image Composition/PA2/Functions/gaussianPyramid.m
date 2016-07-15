function [ p ] = gaussianPyramid( image,lvl,hs,sigma )
%GAUSSIANPYRAMID Summary of this function goes here
%   Detailed explanation goes here
h=fspecial('gaussian',hs,sigma);
% p = cell(1,(log(min(size(image)))+1));
p = cell(1,lvl);
p{1} = image;
i = 1;
while i<lvl
    i=i+1;
    t=imfilter(p{i-1},h,'same');
    m = 1:2:size(t,1);
    n = 1:2:size(t,2);
    p{i}=t(m,n,:);

end

end

