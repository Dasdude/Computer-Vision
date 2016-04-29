function [ c ] = findCameraposition( p)
%% function [ c ] = findCameraposition( p)
%   Detailed explanation goes here
    [u ,s , v] = svd(p);
    c = v(:,4);
    c = c/c(4);
end

