clc
close all
clear
addpath('Functions/')
%% For Testing Just Copy Result SVM Matrix in Test Folder
negURL = 'TrainingSet\neg\';
posURL = 'TrainingSet\pos\';
maximumTrainingSamples = 20;
C = .0001;
if(exist('TrainingResults\NegativeTrainHOG.mat','file')~=2 || exist('TrainingResults\PositiveTrainHOG.mat','file')~=2)
HOGTrainingFolder(negURL,posURL,maximumTrainingSamples);
end
TrainSVM(maximumTrainingSamples,C);
