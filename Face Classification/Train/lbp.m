function [f_vector] = lbp(image )
%LBP Summary of this function goes here
%   Detailed explanation goes here
image  = im2double(image);
image = image(1:(size(image,1)-mod(size(image,1),16)),1:(size(image,2)-mod(size(image,2),16)));
celldim = size(image)/16;% 1:row 2:col

image2 = zeros (celldim(1)*16+2,celldim(2)*16+2);
image2(2:size(image2,1)-1,2:size(image2,2)-1)= image ;
clear image ;
image =image2 ;
f_vector = zeros(1,256*celldim(1)*celldim(2));
f_image = zeros(celldim(1),celldim(2),256);

for i = 1:celldim(1)
    for j = 1:celldim(2)
        cellim = image(((i-1)*16)+1:i*16+2,((j-1)*16)+1:j*16+2);
        feature = lbpcell(cellim);
        
        f_vector(256*((j-1)*celldim(1)+(i-1))+1:256*((j-1)*celldim(1)+(i-1))+256) = feature;
        
    end
end

end

