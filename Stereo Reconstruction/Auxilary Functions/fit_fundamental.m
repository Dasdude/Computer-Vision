function [ F,ep1,ep2 ] = fit_fundamental( matches )
%% function [ F,ep1,ep2 ] = fit_fundamental( matches )
% matches is the Nx4 matrix where matches(i,1:2) is the match on the first
% image and matches(i,3:4) is the match on the second image
% F is the fundamental matrix found for two images.
% ep1 epipole in the first image
% ep2 epipole in the second image
    N = size(matches,1);
    x1 = matches(:,1:2);
    x2 = matches(:,3:4);
    x1h = [x1,ones(N,1)]'; % x1h is 3xN matrix
    x2h = [x2,ones(N,1)]'; % x2h is 3xN matrix
    [F,ep1,ep2] = fundmatrix(x2h,x1h);


end

