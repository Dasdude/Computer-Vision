function [w,b] = Train(dataT,dataF,C)
%TRAIN Summary of this function goes here
% [w,b] = Train(dataT,dataF,C)
% data variable structure is : 
%rows: number of Training Sample 
%cols: Feature Dimension

clc
clear
%% input TestCases
% Data Format
% size(data) == number of TestCases *dimension
% size(class) = 1*number of TestCases
%% Data Generation For Training
data = [dataT;dataF];
class = [ones(1,size(dataT,1)),-1*ones(1,size(dataF,1))];
n = size(data,1);
d = size(data,2);
a = repmat(class',1,d);
%% Construction H f and A matrices with respect to the structure of output of QuadProg [z]
% Structiure of z is [w , epsilons,b]';
H = diag([ones(1,d),zeros(1,n+1)]);
f = C*[zeros(1,d) , ones(1,n),0]';
A = -[a.*data,eye(n),class'.*ones(n,1)];
%% construction of Other Parameters
b= -ones(n,1);
lb = [-inf*ones(1,d),zeros(1,n),-inf]';
ub = [inf*ones(1,n+d+1)]';
% ub=[]
%% Computing z
o=optimset('MaxIter',400,'Display','on');
z =quadprog(H,f,A,b,[],[],lb,ub,[],o);
w = z(1:d);
b = z(end);

end

