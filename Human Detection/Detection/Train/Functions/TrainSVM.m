function [] = TrainSVM( totalSample,C)
%TRAINSVM Summary of this function goes here
%   Detailed explanation goes here
% TrainSVM(totalSamplePerClassToProcess, C)
load NegativeTrainHOG.mat
load PositiveTrainHOG.mat
totalSampleN= min([size(dataN,1),totalSample]);
totalSampleP= min([size(dataP,1),totalSample]);
totalSample = max([totalSampleN,totalSampleP]);
[w,b,e]=trainSVM(dataP(1:totalSampleP,:),dataN(1:totalSampleN,:),.01);
save(['SVM-TotalSamples' num2str(totalSample) '-C' num2str(C) '.mat'],'w','b','e');
end

