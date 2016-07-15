function [ HistH ] = HOG( image )

image = image(((size(image,1)-128)/2)+1:128+((size(image,1)-128)/2),((size(image,2)-64)/2)+1:64+((size(image,2)-64)/2),:);
%% Computing Gradient Image
verticalFilter = [-1;0;1];
horizontalFilter = [-1,0,1];
xgradientImage = imfilter(image , verticalFilter,'same');
ygradientImage = imfilter(image , horizontalFilter,'same');
gradientMagnitudeImage = sqrt(xgradientImage.^2+ygradientImage.^2);
gradientOrientationImage = atand(ygradientImage./xgradientImage);

gradientOrientationImage=(gradientOrientationImage<0)*180 + gradientOrientationImage;
i = find(xgradientImage==0);
gradientOrientationImage(i) = 90;
% in this section we get the maximum Magnitude From RGB image
[gradientMagnitudeImage,i] = max(gradientMagnitudeImage,[],3);
gradientOrientationImage1 = gradientOrientationImage(:,:,1).*0;

for j = 1:3
    mask =  i==j;
    gradientOrientationImage1 = gradientOrientationImage1 + gradientOrientationImage(:,:,j).*mask;
end
gradientOrientationImage = gradientOrientationImage1;
clear gradientOrientationImage1;

%% Deviding Image into overlapping blocks of 16x16
resultImageOrientation = zeros(240,112);
resultImageGradient = zeros(240,112);

for j = 1:7
    for i=1:15
resultImageOrientation(((i-1)*16)+1:i*16,((j-1)*16)+1:j*16) = gradientOrientationImage((i-1)*8+1:(i+1)*8,(j-1)*8+1:(j+1)*8);
resultImageGradient(((i-1)*16)+1:i*16,((j-1)*16)+1:j*16) = gradientMagnitudeImage(((i-1)*8)+1:(i+1)*8,((j-1)*8)+1:(j+1)*8);
    end
end
resultImageGradient= mat2cell(resultImageGradient,8*ones(1,30),8*ones(1,14));
resultImageOrientation = mat2cell(resultImageOrientation,8*ones(1,30),8*ones(1,14));


resultImageOrientation1 = zeros(8,8,15,7,2,2);
resultImageGradient1 = zeros(8,8,15,7,2,2);
for i=1:15
for j=1:7
for k = 1:2
for l= 1:2


resultImageOrientation1(:,:,i,j,k,l) = resultImageOrientation{2*(i-1)+k,2*(j-1)+l};
resultImageGradient1(:,:,i,j,k,l) = resultImageGradient{2*(i-1)+k,2*(j-1)+l};

end
end
end
end

%% Quantizing Image For Calculating Histogram
BinImage = floor((resultImageOrientation1+10)/20)-0.5;
voteMap = resultImageGradient1;
BinInverseImage = BinImage+1;
%% Weights for Weighted Histogram
RatioImage = ((resultImageOrientation1/20)- BinImage);
RatioInverseImage = 1-RatioImage;
RatioImage = RatioImage.*voteMap;
RatioInverseImage = RatioInverseImage.*voteMap;
%% Calculate Histogram For each Block
HistH = zeros(15,7,2,2,11);
for blocknumC = 1:7
for blocknumR = 1:15
for cellnumR = 1:2
for cellnumC = 1:2
    for i =1:8
    for j = 1:8

    HistH(blocknumR,blocknumC,cellnumR,cellnumC,BinImage(i,j,blocknumR,blocknumC,cellnumR,cellnumC)+1.5) = HistH(blocknumR,blocknumC,cellnumR,cellnumC,BinImage(i,j,blocknumR,blocknumC,cellnumR,cellnumC)+1.5)+RatioImage(i,j,blocknumR,blocknumC,cellnumR,cellnumC);
    HistH(blocknumR,blocknumC,cellnumR,cellnumC,BinInverseImage(i,j,blocknumR,blocknumC,cellnumR,cellnumC)+1.5) = HistH(blocknumR,blocknumC,cellnumR,cellnumC,BinInverseImage(i,j,blocknumR,blocknumC,cellnumR,cellnumC)+1.5)+RatioInverseImage(i,j,blocknumR,blocknumC,cellnumR,cellnumC);
    
    end
    end
    HistH(blocknumR,blocknumC,cellnumR,cellnumC,2)= HistH(blocknumR,blocknumC,cellnumR,cellnumC,2)+HistH(blocknumR,blocknumC,cellnumR,cellnumC,11);
    HistH(blocknumR,blocknumC,cellnumR,cellnumC,9)= HistH(blocknumR,blocknumC,cellnumR,cellnumC,9)+HistH(blocknumR,blocknumC,cellnumR,cellnumC,1);
end
end
end
end
HistH(:,:,:,:,[1 11]) = [];









end

