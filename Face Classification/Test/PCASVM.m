clc
clear
close all
load('PCA SVM-TotalSamples28-C0.01.mat');
% features = imread('./subject01.glasses');
totalSamplesPerPerson = 10
t = zeros(1,totalSamplesPerPerson);
for i = 1:4
    file = dir(['./yalefaces/subject0' num2str(i) '.*']);
    for j = 1:totalSamplesPerPerson
        features = imread(['./yalefaces/' file(j).name]);
        
        if(featureSpec=='lbp')
            features = lbp(features);
            features = features';
        else
        features = features(:);
        end
        features = PCATransformer(features',eigenVectors);
        if(features'*w+b>=1)
        class = 1;
        else
            class =0;
        end
        
        t(1,j)=class;
        
    end
    
    x = (i-1)*totalSamplesPerPerson+1:(i)*totalSamplesPerPerson;
    plot(x,t,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10)

    hold on
    
end