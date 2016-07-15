function [centroids , eigenVector ,data] = PCATrain(A,compressRate,samplesofEachPerson)
%PCATRAIN Summary of this function goes here
% [centers , eigenVector] = PCATrain(A,CompressRate,sampelsofEachPerson) 
% A is MN*PN matrix
% Compression Rate is between 0 and 1
% URL = './yalefaces/';
C=A'*A;
[eigenVector,eigenValue]=eig(C);
eigenValue = diag(eigenValue);
eigenVector = A*eigenVector;
eigenVectorSize = floor(size(eigenValue,1)*compressRate);
eigenVector = eigenVector(:,end-eigenVectorSize+1:end);
% eigenValue = eigenValue(1:eigenVectorSize);
data = eigenVector'*A;
classes = size(A,2)/samplesofEachPerson;
% each row of a indicates each coefficient and column indicates each sample
centroids= zeros(eigenVectorSize,classes);
for i = 1:classes
    centroids(:,i) = mean(data(:,samplesofEachPerson*(i-1)+1:samplesofEachPerson*(i)),2);
end


end