function [ nonMaximaScoreFileName ] = NMaximaSupF( windowSize,ScoreFileName,threshold )
% NMaximaSupF(windowSize , ScoreFileName)
% ScoreFileName : it should include .mat Extension

load(ScoreFileName);


for scale = 1: scaleTotal

    score{scale}(score{scale}<threshold)=0;
    
    temp = score{scale};
    if(scale == 1)
        tempup = zeros(size(temp));
    else
        tempup = score{scale-1};
    end
    if(scale==scaleTotal)
        tempdown = zeros(size(tempup));
    else
        tempdown = imresize(score{scale+1},size(tempup),'nearest');
    end
    temp = imresize(temp,size(tempup),'nearest');
    for i = 1:size(tempup,1)-windowSize+1
        for j = 1:size(tempup,2)-windowSize+1
            window =  zeros(windowSize,windowSize,3);
            window(:,:,1) = tempup(i:i+windowSize-1,j:j+windowSize-1);
            window(:,:,2) = temp(i:i+windowSize-1,j:j+windowSize-1);
            window(:,:,3) = tempdown(i:i+windowSize-1,j:j+windowSize-1);
            window(window~=max(window(:)))=0;
            
             tempup(i:i+windowSize-1,j:j+windowSize-1)=window(:,:,1) ;
            temp(i:i+windowSize-1,j:j+windowSize-1)=window(:,:,2)  ;
             tempdown(i:i+windowSize-1,j:j+windowSize-1)=window(:,:,3) ;
        end
    end
    if(scale ~= 1)
        
    
        score{scale-1}=tempup ;
    end
    if(scale~=scaleTotal)
        
        score{scale+1} = imresize(tempdown,size(score{scale+1}),'nearest');
    end
    score{scale} = imresize(temp,size(score{scale}));
    nonMaximaScoreFileName = ['NonmaximaSupression ' ScoreFileName];
    save(nonMaximaScoreFileName,'score','stepSize','scaleTotal','scales');
end

end

