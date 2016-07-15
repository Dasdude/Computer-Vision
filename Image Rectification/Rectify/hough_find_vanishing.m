function [ vp ] = hough_find_vanishing( im2 )
%HOUGH_FIND_VANISHING Summary of this function goes here
%   Detailed explanation goes here
figure(1);
imshow(im2);
im=im2;
[imedge tr]= edge(im2,'Canny',[],'horizontal');
vp = zeros(2,3);

for i =1:2 
    hold off
    switch i
        case 1
            direction = 'horizontal';
        case 2 
            direction = 'vertical';
        otherwise
            return;
    end
    %% Line Detector
    
    imedge = edge(im,'Prewitt',tr(1),direction);
    imedge(:,[1:10 end-10:end])=0;
    imedge([1:10 end-10:end],:)=0;
    [H,theta,rho] = hough(imedge);
    P = houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(imedge,theta,rho,P,'FillGap',80,'MinLength',size(im,3-i)/5);

     hold on
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
       % Plot beginnings and ends of lines
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
    k=2;
    q=1;
    while(1)
        if(q==size(lines,2))
            break;
        end
        line1 = lines(q);
        for lineIndex = k:size(lines,2)
            if(lines(lineIndex).theta~=line1.theta)
                line2 = lines(lineIndex);
                k=lineIndex+1;
                break;
            end
        end
        xy = [line1.point1; line1.point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');
       
            xy = [line2.point1; line2.point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');
        vp(i,:) =cross(cross([line1.point1,1],[line1.point2,1]),cross([line2.point1,1],[line2.point2,1])); 
        vp(i,:) =vp(i,:)/vp(i,3);
        if( sum(vp(i,1:2)<-.5*size(im)|vp(i,1:2)>1.5*size(im)))
            break;
        end    
        if(k==size(lines,2))
            q=q+1
            k=q;
        end
         
         xy = [line1.point1; line1.point2];
         plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
         xy = [line2.point1; line2.point2];
         plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    end
end 
end