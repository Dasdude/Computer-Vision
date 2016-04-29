function [ X ] = Reconstructor(x1,x2,p1,p2)
%% function [ X ] = 3dReconstructor(x1,x2,p1,p2)
%   Detailed explanation goes here
    X = zeros(4,size(x1,2));
    for i=1:size(x1,2)
        A = [x1(1,i)*p1(3,:)-p1(1,:); 
            x1(2,i)*p1(3,:)-p1(2,:);
            x2(1,i)*p2(3,:)-p2(1,:); 
            x2(2,i)*p2(3,:)-p2(2,:);];
        [U D V] = svd(A);
        X(:,i) = V(:,end);
        X(:,i)=X(:,i)/X(4,i);
    end


end

