function [] = TestPCA_SVMFunction( filename,totalSamplesPerPerson,subjectNumber )
%TestPCA_SVMFunction( filename,totalSamplesPerPerson,subjectNumber )
a = figure;
load(filename);
% features = imread('./subject01.glasses');
t = zeros(1,totalSamplesPerPerson);
for i = subjectNumber:subjectNumber
    file = dir(['./yalefaces/subject0' num2str(i) '.*']);
    for j = 1:totalSamplesPerPerson
        x = imread(['./yalefaces/' file(j).name]);
        features = x;
        if(featureSpec=='lbp')
            features = lbp(features);
            features = features';
        else
        features = features(:);
        end
        features = PCATransformer(features',eigenVectors);
        if(features'*w+b>=1)
        class = 1;
        figure;
        imshow(x);
        title('Person matched The Target');
        pause(1);
        else
        figure;
        imshow(x);
        
        title('Person did not match The Target');
            class =0;
            pause(1);
        end
        
        t(1,j)=class;
        
    end
    figure(a)
    x = (i-1)*totalSamplesPerPerson+1:(i)*totalSamplesPerPerson;
    plot(x,t,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10)

    hold on
    
end
end

