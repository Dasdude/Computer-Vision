function [ f_hist ] = lbpcell( im_cell )
%LBPCELL Summary of this function goes here
%   Detailed explanation goes here
f_hist = zeros(1,256);
for i = 2:17
    for j = 2:17
        block =im_cell(i-1:i+1,j-1:j+1);
        feature = lbp_block(block);
        f_hist(feature+1) = f_hist(feature+1)+1;
    end
end

end

