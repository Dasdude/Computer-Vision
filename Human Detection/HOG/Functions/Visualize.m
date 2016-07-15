function [ result ] = Visualize(ihist)

result = zeros(15*16,7*16);
histblock = squeeze(sum(sum(ihist,3),4));
for blocknumC = 1:7
for blocknumR = 1:15

        row = (blocknumR-1)*16+1;
        col = (blocknumC-1)*16+1;
        imvis = zeros(16,16);
        %% Creating Corresponding image for each orientation
        for teta = 1:9
            vis  =zeros(16,16);
            vis(8,:)=1;
            vis(7:10,7:10)=0;
            vis = imrotate(vis,teta*20 -10);
            
            vis = vis(floor((size(vis,1)-14)/2):floor((size(vis,1)+16)/2),floor((size(vis,2)-14)/2):floor((size(vis,2)+16)/2));
            vis = histblock(blocknumR,blocknumC,teta)*vis;
            imvis = imvis+vis;%% Orientation Image accumalation
            
        end
        
        result(row:row+15,col:col+15) = imvis;
        
    
    
    

end
end

result = result/max(result(:));% Normalizing Image

end

