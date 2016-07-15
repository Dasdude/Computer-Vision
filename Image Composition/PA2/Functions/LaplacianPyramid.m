function [ lp ] = LaplacianPyramid( gp,hs,sigma  )
%LAPLACIANPYRAMID Summary of this function goes here
%   Detailed explanation goes here
lp = cell(1,size(gp,2));
for i=1:size(lp,2)-1
gpe =  GaussianExpand(gp{i+1},hs,sigma);
gpe = gpe(1:size(gp{i},1),1:size(gp{i},2),:);
lp{i} = gp{i} - gpe;
end
lp{end} =gp{end};
end

