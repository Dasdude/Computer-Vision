clear
close all
M = load('./Data/measurement_matrix.txt');
%% 
    [O1 sig O2] = svd(M);
    O2=O2';
    F = size(M,1)/2;
    Rhat = O1(:,1:3)*sqrt(sig(1:3,1:3));
    Shat = sqrt(sig(1:3,1:3))*O2(1:3,:);
%% Calculating Q in the quadratic system with constraints
%   R
    i = Rhat(1:F,:);
    j = Rhat(F+1:end,:);
    G1 = [i(:,1).^2,2*(i(:,1).*i(:,2)),2*(i(:,1).*i(:,3)),i(:,2).^2,2*(i(:,2).*i(:,3)),i(:,3).^2];
    G2 = [j(:,1).^2,2*(j(:,1).*j(:,2)),2*(j(:,1).*j(:,3)),j(:,2).^2,2*(j(:,2).*j(:,3)),j(:,3).^2];
    G3 = [j(:,1).*i(:,1),(i(:,1).*j(:,2))+(i(:,2).*j(:,1)),(i(:,1).*j(:,3))+(j(:,1).*i(:,3)),j(:,2).*i(:,2),(i(:,2).*j(:,3))+(j(:,2).*i(:,3)),j(:,3).*i(:,3)];
    G = [G1;G2;G3];
    c = [ones(1,2*F),zeros(1,F)]';
    I = G\c;
    L = [I(1),I(2),I(3);I(2),I(4),I(5);I(3),I(5),I(6)];
% Enforcing positive definite
    eps = 10^(-100);
    [U,S,V] = svd(L);
    index = find(S<0);
    S(index) =eps;
    Q = U*sqrt(S);
%% Computing Rotation and Shape Matrix
    k = cross(i(1,:)',j(1,:)');
    Rz = [i(1,:)'/norm(i(1,:)),j(1,:)'/norm(j(1,:)),k/norm(k)];
    R = Rhat*Q;
    S = Q\Shat;
    figure;
    plot3(S(1,:),S(2,:),S(3,:),'.b')
    axis equal
    Mhat = R*S;
    dif = M-Mhat;
    mse = sum(dif.^2,2)/size(M,2);
    msec = mse(1:F,:)+mse(F+1:end,:);
    plot(1:size(msec,1),msec);
    title('MSE per Frame')
    

