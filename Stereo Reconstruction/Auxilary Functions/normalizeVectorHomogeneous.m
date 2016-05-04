function [ x_norm ] = normalizeVectorHomogeneous( x)
%% function [ x_norm ] = normalizeVectorHomogeneous( x)
% normalizeVectorHomogeneous will normalize vector x on the 3rd element, 
% x_norm is the result vector with the 3rd row equal to 1
% x = 3xN matrix

x3 = repmat(x(3,:),3,1);
x_norm = x./x3;

end

