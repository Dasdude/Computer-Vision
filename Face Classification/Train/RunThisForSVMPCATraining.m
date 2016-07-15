clc
clear
close all
%% input Variables
URL = './yalefaces/';
samplesofEachPerson = 4;
totalPerson  = 3;
compressRate = 1;
positiveSubjectNumber=3;
featureSpec = 'lbp';
%% Computation 
[t,eigenVectors,data]=PCAFunction(URL,totalPerson,samplesofEachPerson,featureSpec,compressRate);
posIndex = (positiveSubjectNumber-1)*samplesofEachPerson+1:(positiveSubjectNumber-1)*samplesofEachPerson+samplesofEachPerson;
negIndex = 1:size(a,2);
negIndex(posIndex)=[];
SVMTrainingFunction(inf,.01,a(:,posIndex)',a(:,negIndex)',eigenVectors,featureSpec);
