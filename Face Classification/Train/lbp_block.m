function [ f_value ] = lbp_block( block )
%LBP_BLOCK Summary of this function goes here
%   Detailed explanation goes here
block = block-block(2,2);
f_2d = sign(block);
f_2d(f_2d<0)=0;
f_vector = [f_2d(1,:),f_2d(2,3),f_2d(3,3),f_2d(3,2),f_2d(3,1),f_2d(2,1)];
f_value =sum( f_vector.*[1,2,4,8,16,32,64,128]);
%% cell Feature vector spec :
    % 1-Clockwise
    % 2-starting element left top (1,1)

end

