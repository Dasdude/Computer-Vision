clc
close all
clear
%% Control Variables
Train = 1; % Put 0 if you want to use your own Matrix for testing 
%% Variables For Training
URL = './yalefaces/';
samplesofEachPersonForTraining = 5; % total Samples to Train Your  SVM
totalPerson  = 5; % total Subjects to be trained in SVM
positiveSubjectNumber=3; % Select subject Number you want to identified in SVM as Positive
%% Variables For Testing
samplesofEachPersonForTesting = 9; % 
compressRate = 1; % between 0 and 1
TestSubjectNumber = 1:4; % for observing results for different Subjects
SVMTestDataMatrixName = 'PCA SVM-TotalSamples4-C0.01.mat'; % if Train is equal to 0 put you Trained SVMInputMatrix URL here
PCAMatrixName = 'lbp PCATrained  totalperson 5 samplesPerPerson10.mat'; % if Train is 0 put Your Trained PCM URL here
%% Variables For Both Testing And Controlling
featureSpec = 'lbp'; %% defines your feature space
TrainingAndTestingMethod = 'SVM' %% for selecting Testing OR Training Method Put 'SVM' or 'PCM'
%% Training & Testing
if(Train == 1)
% Training and Test
    if(TrainingAndTestingMethod == 'SVM')
       filename = TrainingPCA_SVM_MainFunction(URL,samplesofEachPersonForTraining,totalPerson,compressRate,positiveSubjectNumber,featureSpec);
       for i=TestSubjectNumber
            TestPCA_SVMFunction(filename,samplesofEachPersonForTesting,i);
       end
    else
       [filename, p,q,r] = PCAFunction(URL,totalPerson,samplesofEachPersonForTesting,featureSpec,compressRate);
       
       for i= TestSubjectNumber
       PCATestFunctionLast(filename,samplesofEachPersonForTesting,i);
       end
    end
else
%% Testing Only
    if(TrainingAndTestingMethod == 'SVM')
        TestPCA_SVMFunction(SVMTestDataMatrixName,samplesofEachPersonForTesting,2);
    else
       for i= TestSubjectNumber
       PCATestFunctionLast(PCAMatrixName,samplesofEachPersonForTesting,i);
       end
    end
end
