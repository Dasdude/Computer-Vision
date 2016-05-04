close all
%%
%% load images and match files for the first example
%%

I1 = imread('./Data/house1.jpg');
I2 = imread('./Data/house2.jpg');
matches = load('./Data/house_matches.txt'); 
% this is a N x 4 file where the first two numbers of each row
% are coordinates of corners in the first image and the last two
% are coordinates of corresponding corners in the second image: 
% matches(i,1:2) is a point in the first image
% matches(i,3:4) is a corresponding point in the second image
% Visualize correspondences
figure;
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
title('Original Matched Features from Globe01 and Globe02');
N = size(matches,1);
figure
%%
%% display two images side-by-side with matches
%% this code is to help you visualize the matches, 
%% you don't need to use it to produce the results for the assignment
%%
imshow([I1 I2]); hold on;
plot(matches(:,1), matches(:,2), '+r');
plot(matches(:,3)+size(I1,2), matches(:,4), '+r');
line([matches(:,1) matches(:,3) + size(I1,2)]', matches(:,[2 4])', 'Color', 'r');
% pause;

%%
%% display second image with epipolar lines reprojected 
%% from the first image
%%

% first, fit fundamental matrix to the matches
F = fit_fundamental(matches); % this is the function that you need 

%% to build to call Peter Kovesi's 8-point algorithm implementation
L = [matches(:,1:2) ones(N,1)] * F; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
% clf;r
figure
imshow(I2); hold on;
plot(matches(:,3), matches(:,4), '+r');
line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');
%% Reconstruction
p1 = load('./Data/house1_camera.txt');

p2 = load('./Data/house2_camera.txt');
c1 = findCameraposition(p1);
c2 = findCameraposition(p2);
X = Reconstructor(matches(:,1:2)',matches(:,3:4)',p1,p2,F,'o');
x1bp = p1*X;
for i = 1:size(x1bp,2)
    x1bp(:,i) = x1bp(:,i)/x1bp(3,i);
end
x1bp-matches

figure;
plot3(X(1,:),X(2,:),X(3,:),'.b');
hold on
axis equall


% plot3(c1(1),c1(2),c1(3),'Xg');
% plot3(c2(1),c2(2),c2(3),'Xr');
% plot3d(X,'b');


