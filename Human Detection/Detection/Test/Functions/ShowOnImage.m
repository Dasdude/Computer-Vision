function [  ] = ShowOnImage( ScoreFile,threshold,imageName )
% ShowOnImage(ScoreFile , Threshold, Image Name);
image = imread(['ValidationSet\' ,imageName]);
load(ScoreFile);
a= figure;
imshow(image);

hold on
for scale = 1:scaleTotal
    x=imresize(image,scales(scale));    
    ratei = size(image,1)/size(x,1);
    score{scale} = score{scale}/max(score{scale}(:));
    for i= 1:stepSize:size(x,1)-127
        for j = 1:stepSize/2:size(x,2)-63
            if(score{scale}(((i-1)/stepSize)+1,((j-1)/(stepSize/2))+1)>threshold)
                rectangle('Position',[i,j,64,128]*ratei,'EdgeColor','g','LineWidth',2);
                   
            end
        end
    end
end
saveas(a,[ScoreFile '.png']);

end

