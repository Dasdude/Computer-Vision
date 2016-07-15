function [filename, centers , eigenVectors,data ] = PCAFunction( URL , totalPerson,samplesofEachPerson,featureSpec,compressRate)
%PCAFUNCTION Summary of this function goes here
 % PCAFunction( URL , totalPerson,samplesofEachPerson,featureSpec )
%   Detailed explanation goes here

% file = dir([URL 'subject0*.*']);
% temp =imread([URL file(1).name]);
% mn = size(temp(:),1);
% A = zeros(mn,totalPerson*samplesofEachPerson);
for i = 1: totalPerson
     
     if(i<10)
        file = dir([URL 'subject0' num2str(i) '.*']);
     else
        file = dir([URL 'subject' num2str(i) '.*']);
     end
     for j= 1: samplesofEachPerson
         
         
         temp = imread([URL file(j).name]);
         if(featureSpec=='lbp')
             
             temp = lbp(temp);
             temp = temp';
         end
         A(:,((i-1)*samplesofEachPerson)+j)=temp(:);
     end
     
end
[centers , eigenVectors,data] = PCATrain(A,compressRate,samplesofEachPerson);
filename = [featureSpec ' PCATrained  totalperson ' num2str(totalPerson) ' samplesPerPerson' num2str(samplesofEachPerson) '.mat'];
save(filename ,'centers' , 'eigenVectors','samplesofEachPerson','totalPerson','featureSpec');

end

