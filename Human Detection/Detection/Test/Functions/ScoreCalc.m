function [ outputFilename ] = ScoreCalc( filename,stepSize,scaleTotal,SVMDataName,scaleStep )
% ScoreCalc( filename,step,scaleTotal,SVMDataName,scaleStep )
% Step       : Step Size of Sliding Window
% SVMDataName: name of .mat file to load(without .mat);
% scaleTotal :Number of Scales to process
% scaleStep  :Image Size reduction Rate ( 2 means each step image size gets
% half size)
%% Variable Declaration
score = cell(1,scaleTotal);
load(['Pretrained SVM/' SVMDataName '.mat']); 
image=imread(['ValidationSet/' filename]);
scales = zeros(1,scaleTotal);
%% Computation
for scale = 1:scaleTotal
    scales(scale)=1/((scaleStep)^(scale-1));
    x=imresize(image,scales(scale));
    if(size(x,1)<128 || size(x,2)<64)
        scaleTotal = scale-1;
        scales(1,scale:scaleTotal)=[];
        score(:,scale:scaleTotal)=[];
        break;
    end
end
for scale = 1:scaleTotal
    scales(scale)=1/((scaleStep)^(scale-1));
    x=imresize(image,scales(scale));
    i = 1:stepSize:size(x,1)-127;
    j = 1:stepSize/2:size(x,2)-63;
    score{scale} = zeros(size(i,2),size(j,2));
for i= 1:stepSize:size(x,1)-127
    for j = 1:stepSize/2:size(x,2)-63 
        if(exist([filename SVMDataName ' ' num2str(stepSize) ' ' num2str(scaleTotal) '.mat'],'file')~=2) 
            q=HOG(x(i:i+127,j:j+63,:));
            score{scale}(((i-1)/stepSize)+1,((j-1)/(stepSize/2))+1) = q(:)'*w+b;
        else
            load(['preTrained SVM\' filename SVMDataName ' ' num2str(stepSize) ' ' num2str(scaleTotal) '.mat']);
        end
    
    end
    
end


end
outputFilename = [filename SVMDataName ' ' num2str(stepSize) ' ' num2str(scaleTotal) '.mat'];
save([filename SVMDataName ' ' num2str(stepSize) ' ' num2str(scaleTotal) '.mat'],'score','scaleTotal','scales','stepSize');

end