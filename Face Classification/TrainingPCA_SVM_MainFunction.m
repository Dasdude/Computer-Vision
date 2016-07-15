function [filename] = TrainingPCA_SVM_MainFunction( URL,samplesofEachPerson,totalPerson,compressRate,positiveSubjectNumber,featureSpec )
% TrainingPCA_SVM_MainFunction( URL,samplesofEachPerson,totalPerson,compressRate,positiveSubjectNumber,featureSpec )
[q,r,eigenVectors,a]=PCAFunction(URL,totalPerson,samplesofEachPerson,featureSpec,compressRate);
posIndex = (positiveSubjectNumber-1)*samplesofEachPerson+1:(positiveSubjectNumber-1)*samplesofEachPerson+samplesofEachPerson;
negIndex = 1:size(a,2);
negIndex(posIndex)=[];
filename=SVMTrainingFunction(inf,.01,a(:,posIndex)',a(:,negIndex)',eigenVectors,featureSpec);end

