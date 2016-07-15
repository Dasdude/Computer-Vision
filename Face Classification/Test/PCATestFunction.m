function [ class ,data ] = PCATestFunction( features,centers, eigenVectors )
%PCATESTFUNCTION Summary of this function goes here
% PCATestFunction( features,centers, eigenVectors )
%   Detailed explanation goes here
eigenVectors= eigenVectors';
data = eigenVectors*double(features);
q = centers-repmat(data,1,size(centers,2));
q = q.^2;
q = sum(q,1);
[r,class] = min(q);


end

