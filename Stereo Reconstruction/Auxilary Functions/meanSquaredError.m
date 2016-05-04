function [ mse ] = meanSquaredError( input_v,target_v )
%% function [ mse ] = meanSquaredError( input_v,target_v )
% input_v and target_v size are kxN where N is number of samples and k is vector length
dif = (input_v - target_v).^2;
dist = sum(dif);
mse = sum(dist)/size(input_v,2);
end

