function [imrect] = metric(im2,Method)
im = rgb2gray(im2);
if nargin==1
    Method = 'M';
end
figure_image = figure(1);
imshow(im);
% im = affineRectify(im);
vp = zeros(2,3);
hold on;
    switch Method
        case 'H'
            vp = hough_find_vanishing(im);
        case 'M'
            for i=1:2
                l = struct('point',[0,0;0,0]);
                for j = 1:2
                    line(j)=l;
                    for k = 1:2
                    figure_image
                    line(j).point(k,:)=ginput(1);
                    plot(line(j).point(k,1),line(j).point(k,2),'x','lineWidth',2);
                    end
                    plot(line(j).point(:,1),line(j).point(:,2),'lineWidth',2);
                   
                end
                vp(i,:) =cross(cross([line(1).point(1,:),1],[line(1).point(2,:),1]),cross([line(2).point(1,:),1],[line(2).point(2,:),1])); 
                vp(i,:) =vp(i,:)/vp(i,3);
            end
        otherwise
            return;
    end
points = ones(5,3);
 for i=1:5
     hold on;
    l = struct('point',[0,0;0,0]);
    points(i,1:2) = ginput(1);
    plot(points(i,1),points(i,2),'x','lineWidth',2);
 end
% load('points');
 C = conicfit(points')';
m1 = vp(1,:)';
m2 = vp(2,:)';
syms landa 

eq = ((landa^2)*m2'*C*m2)+2*landa*m2'*C*m1+m1'*C*m1==0;
solution = solve(eq,landa);
landa1 = vpa(solution(1));
landa2 = vpa(solution(2));
I= vpa(m1+solution(1)*m2);
J = vpa(m1+solution(2)*m2);
I=I/I(1);
J=J/J(1);

CDual = I*J.'+J*I.';
[U,S,V] = svd(CDual);
H = U*(sqrt(diag([S(1,1),S(2,2),1])));
H = double(H);
transform_object = projective2d(inv(H)');
imrect = imwarp(im2,transform_object); 

figure;
imshow(uint8(imrect));






 
%  points=cat(points,ones(1,size(points,1)))
 
            


