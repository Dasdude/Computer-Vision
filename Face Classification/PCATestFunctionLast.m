function [ ] = PCATestFunctionLast(URL,totalSamplesPerPerson,subjectNumber  )

%PCATestFunctionLast(URL,totalSamplesPerPerson,subjectNumber  )
load(URL);
t = zeros(1,totalSamplesPerPerson);
for i = subjectNumber:subjectNumber
    file = dir(['./yalefaces/subject0' num2str(i) '.*']);
    for j = 1:totalSamplesPerPerson
        features = imread(['./yalefaces/' file(j).name]);
        if(URL(1:3)=='lbp')
            features = lbp(features);
            features = features';
        else
        features = features(:);
        end
        class = PCATestFunction(features , centers,eigenVectors);
        
        t(1,j)=class;
        
    end
    x = (i-1)*totalSamplesPerPerson+1:(i)*totalSamplesPerPerson;
    plot(x,t,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10)
    hold on
    
end
end

