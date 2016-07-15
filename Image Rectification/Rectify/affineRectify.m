function [imrectfiied] = affineRectify(im2,Method)
% Method='M';
 image_figure = figure(1);
    im = rgb2gray(im2);
    imshow(im2);
    hold on
    vp = zeros(2,3);
    if(nargin==1)
        Method='M';
    end
    switch Method
        case 'H'
            vp = hough_find_vanishing(im);
        case 'M'
            for i=1:2
                l = struct('point',[0,0;0,0]);
                for j = 1:2
                    line(j)=l;
                    for k = 1:2
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

    %% End of Line Detector
%% Detect vanishing points automatically double hough transform
%     linesDetected = zeros(3,size(lines,2));
%     
%     for lineIndex = 1:size(lines,2)
%         linesDetected(:,lineIndex) = cross([lines(lineIndex).point1,1],[lines(lineIndex).point2,1])';
%         linesDetected(:,lineIndex) = linesDetected(:,lineIndex)./linesDetected(3,lineIndex);
%         linesDetected(:,:) = linesDetected(:,:)*10000;
%     end
%      linesDetected(:,:) = linesDetected(:,:)*lineSpaceScale;
%     tempShift =(min(linesDetected(1:2,:)')-[1,1])';
%     linesDetectedShifted=[];
%     linesDetectedShifted(1:2,:) = linesDetected(1:2,:)- repmat(tempShift,[1,size(linesDetected,2)]);
%     lineSpaceImage = zeros(ceil(max(linesDetected(1,:))),ceil(max(linesDetected(2,:))));
%     for spaceImageIndex = 1:size(linesDetected,2)
%         spaceImageIndex
%         lineSpaceImage(ceil(linesDetectedShifted(1,spaceImageIndex)):ceil(linesDetectedShifted(1,spaceImageIndex))+1,ceil(linesDetectedShifted(2,spaceImageIndex):ceil(linesDetectedShifted(2,spaceImageIndex))+1))=1;
%     end
%     figure
%     imshow(lineSpaceImage);
%     hold on 
%     max_len =0;
%     [H,theta,rho] = hough(lineSpaceImage);
%     P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:))));
%     vanishingPointsShifted(i) = houghlines(lineSpaceImage,theta,rho,P,'FillGap',max(size(lineSpaceImage))/15,'MinLength',size(lineSpaceImage,1)/30);
%     for k = 1:length(vanishingPointsShifted)
%        xy = [vanishingPointsShifted(k).point1; vanishingPointsShifted(k).point2];
%        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%        % Plot beginnings and ends of lines
%        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%        % Determine the endpoints of the longest line segment
%        len = norm(vanishingPointsShifted(k).point1 - vanishingPointsShifted(k).point2);
%        if ( len > max_len)
%           max_len = len;
%           xy_long = xy;
%        end
%     end
%     
%     line1 = [vanishingPointsShifted(1).point1+tempShift',lineSpaceScale];
%     line2 = [vanishingPointsShifted(1).point2+tempShift',lineSpaceScale];
%     line1 = [line1
% normalize lines
%     lines(:,1) = lines(:,1)./lines(:,3);
%     lines(:,2)=lines(:,2)./lines(:,3);
%     lines(:,3)=lines(:,3)./lines(:,3);
%     meshgrid(1:size(lines))
%%
     
%   
%     vp(i,:) =cross(line1,line2);
    

% vanishingImage = zeros(ceil(size(im,1)-min(vp(:,1)))+10,ceil(size(im,2)));
% vanishingImage(10-ceil(min(vp(:,1)))+2:size(vanishingImage,1),:)=im;
% vanishingImage=cast(vanishingImage,'uint8');
% figure;
% imshow(vanishingImage);
% hold on 
% plot(vp(:,1),vp(:,2),'x','lineWidth',2);

van_line = cross(vp(1,:),vp(2,:));
van_line = van_line./van_line(3);
H = [-vp(2,2)/vp(2,1),1,0;-vp(1,2)/vp(1,1),1,0;van_line];
H(1,:) = H(1,:)/sqrt(sum(H(1,:).^2));
H(2,:)=H(2,:)/sqrt(sum(H(2,:).^2));
M=H;
transform_object = projective2d(M');
imrect = imwarp(im2,transform_object);   
figure;
imshow(imrect);
imrectfiied=imrect;



% v = cross(cross([lines(1).point1,1],[lines(1).point2,1]),cross([lines(4).point1,1],[lines(4).point2,1]));
% v= v/v(3);




