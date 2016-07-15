function [ image  ] = Comp( i1,i2,sigma,hs,lvl )
%COMPOSIT Summary of this function goes here
%   Detailed explanation goes here

gP1 =gaussianPyramid(i1,lvl,hs,sigma);
lp1 = LaplacianPyramid(gP1,hs,sigma);

gP2 =gaussianPyramid(i2,lvl,hs,sigma);
lp2 = LaplacianPyramid(gP2,hs,sigma);

lp3 = cell(1,lvl);
for i =1: lvl
    lp3{i} = [lp1{i}(1:end,1:floor(end/2),:) lp2{i}(1:end,ceil(end/2):end,:)];
end
image = GeneratePic(lp3,hs,sigma);

end

