function [ ] = DetectorFunction( filename , step , scaleTotal , windowSize,SVMDataName,scaleRate,threshold )
% DetectorFunction( filename , step , scaleTotal , windowSize,SVMDataName,scaleRate )
%% Score Calculation
ScoreFileName = ScoreCalc(filename,step,scaleTotal,SVMDataName,scaleRate);
%% NonMaxima Supression For Scores
ScoreFileName = NMaximaSupF(windowSize , ScoreFileName,0);
%% Show Result
ShowOnImage(ScoreFileName,threshold,filename);


end

