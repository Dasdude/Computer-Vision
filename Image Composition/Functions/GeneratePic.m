function [ image ] = GeneratePic( lp,hs,sigma )
%GENERATEPIC Summary of this function goes here
%   Detailed explanation goes here

i = size(lp,2);
gp = cell(1,i);
gp{i}=lp{i};
i=i-1;
while i~=0
    gpe =GaussianExpand(gp{i+1},hs,sigma);
    gpe = gpe(1:min(size(lp{i},1),size(gpe,1)),1:min(size(lp{i},2),size(gpe,2)),:);
    lp{i} = lp{i}(1:min(size(lp{i},1),size(gpe,1)),1:min(size(lp{i},2),size(gpe,2)),:);
    gp{i} = gpe+lp{i};
    
    i=i-1;
end
image = gp{1};
end

