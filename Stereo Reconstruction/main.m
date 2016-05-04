close all
clear
%%
%% load images and match files for the first example
%%
name = 'house';
loadStructure = false;
addpath('Auxilary Functions\');
I1 = imread(['./Data/',name,'1.jpg']);
I2 = imread(['./Data/',name,'2.jpg']);
matches = load(['./Data/',name,'_matches.txt']); 
% this is a N x 4 file where the first two numbers of each row
% are coordinates of corners in the first image and the last two
% are coordinates of corresponding corners in the second image: 
% matches(i,1:2) is a point in the first image
% matches(i,3:4) is a corresponding point in the second image
% Visualize correspondences
figure;
showMatchedFeatures(I1, I2, matches(:,1:2), matches(:,3:4));
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
p1 = load(['./Data/',name,'1_camera.txt']);
p2 = load(['./Data/',name,'2_camera.txt']);
c1 = findCameraposition(p1);
c2 = findCameraposition(p2);
if(exist(['StructureOptimal',name,'.mat'])~=2||~loadStructure)
    X_optimal = Reconstructor(matches(:,1:2)',matches(:,3:4)',p1,p2,F,'o');
    save(['StructureOptimal',name,'.mat'],'X_optimal');
else
    load(['StructureOptimal',name,'.mat']);
end
X_linear = Reconstructor(matches(:,1:2)',matches(:,3:4)',p1,p2,F,'l');
x1_optimal = p1*X_optimal;
x2_optimal = p2*X_optimal;
x1_linear = p1*X_linear;
x2_linear = p2*X_linear;
%% normalize x
x1_linear = normalizeVectorHomogeneous(x1_linear);
x2_linear = normalizeVectorHomogeneous(x2_linear);
x1_optimal = normalizeVectorHomogeneous(x1_optimal);
x2_optimal = normalizeVectorHomogeneous(x2_optimal);
%% MSE Optimal
mse1_optimal = meanSquaredError(x1_optimal(1:2,:),matches(:,1:2)');
mse2_optimal = meanSquaredError(x2_optimal(1:2,:),matches(:,3:4)');
mse_optimal = mse2_optimal
%% MSE Linear
mse1_linear = meanSquaredError(x1_linear(1:2,:),matches(:,1:2)');
mse2_linear = meanSquaredError(x2_linear(1:2,:),matches(:,3:4)');
mse_linear = mse2_linear
%% Plot back Projected points Optimal
figure;
imshow(I1);
title('Optimal image1 BackProj +:optimal x:matches')
hold on
plot(x1_optimal(1,:),x1_optimal(2,:),'+r');
plot(matches(:,1),matches(:,2),'xg');
figure;
imshow(I2);
title('Optimal image2 BackProj +:optimal x:matches')
hold on
plot(x2_optimal(1,:),x2_optimal(2,:),'+r');
plot(matches(:,3),matches(:,4),'xg');
%% Plot back Projected points Linear
figure;
imshow(I1);
title('linear image1 BackProj +:linear x:matches')
hold on
plot(x1_linear(1,:),x1_linear(2,:),'+r');
plot(matches(:,1),matches(:,2),'xg');
figure;
imshow(I2);
title('linear image2 BackProj +:linear x:matches')
hold on
plot(x2_linear(1,:),x2_linear(2,:),'+r');
plot(matches(:,3),matches(:,4),'xg');
%% Plot Structure
figure;
plot3(X_optimal(1,:),X_optimal(2,:),X_optimal(3,:),'.b');
axis equal
title(['Optimal: MSE: ',num2str(mse_optimal)])
figure;
plot3(X_linear(1,:),X_linear(2,:),X_linear(3,:),'.b');
axis equal
title(['Linear: MSE: ',num2str(mse_linear)])




