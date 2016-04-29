function [  ] = plot3d( X,vargin )
%%function [  ] = plot3d( X )
%   X is 3xN matrix
figure;
plot3(X(1,:),X(2,:),X(3,:),'.b');
if(nargin>1)
    plot3(X(1,:),
% figure;
% mesh(X(1,:),X(2,:),X(3,:));
% axis equal;



end

