function [] = HOGTrainingFolder(posURL,negURL,TrainingSampleTotal )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
% HOGTraningFolder(PositiveSamplesURL,NegativeSampleURL,maximumTrainingSamples)
%Example:
%   posURL ='.\INRIAPerson\test_64x128_H96\pos\';
%   negURL = '.\INRIAPerson\Train\neg\';
%Output:
% Save Data
%% Input Parameters
featureDim = 3780;
%% HOG PositiveTrainingSamples
directory=dir([posURL '*.png']);
nPosSamples = min([length(directory) TrainingSampleTotal]);   
dataP = zeros(nPosSamples,featureDim);
for fNumber =1: nPosSamples
    disp(['Positive Training : ' num2str(fNumber) ' out of ' num2str(nPosSamples)])
    image = imread([posURL directory(fNumber).name]);
    dataP(fNumber,:) = HOG(image);
end
save('PositiveTrainHOG.mat','dataP');
%% HOG NegativeTraining Samples
  
directory=dir([negURL '*.png']);
nNegSamples = min([length(directory) TrainingSampleTotal]);
dataN = zeros(nNegSamples,featureDim);
for fNumber =1: nNegSamples
    disp(['Negative Training ' num2str(fNumber) ' out of ' num2str(nNegSamples)])
    image = imread([negURL directory(fNumber).name]);
    dataN(fNumber,:) = HOG(image);
end
save('NegativeTrainHOG.mat','dataN');

end

