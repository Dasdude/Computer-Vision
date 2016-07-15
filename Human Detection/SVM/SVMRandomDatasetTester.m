clc
clear
%% This code Generates Random Data set and Visualize the svm trained on the dataset
%% input TestCases
% Data Format
% size(data) == number of TestCases *dimension
% size(class) = 1*number of TestCases
%% Data Generation For Training
t = 100;
q = 100*repmat([0,1],t,1)+10*(rand(t,2)-0.5);
p = 100*repmat([1,0],t,1)+10*(rand(t,2)-0.5);
dataT = [q;100*rand(floor(t/10),2)];
dataF = [p;100*rand(floor(t/10),2)];
data = [dataT;dataF];
class = [ones(1,size(dataT,1)),-1*ones(1,size(dataF,1))];
C=.001;
n = size(data,1);
d = size(data,2);
a = repmat(class',1,d);

%% Construction H f and A matrices with respect to the structure of output of QuadProg [z]
% Structiure of z is [w , epsilons,b]';
H = diag([ones(1,d),zeros(1,n+1)]);
f = C*[zeros(1,d) , ones(1,n),0]';
A = -[a.*data,eye(n),class'.*ones(n,1)];
% This is the value C
% display(C);
% Here are the input parameters for quadprog
% display(H);
% display(f);
% display(A);
%% construction of Other Parameters
b= -ones(n,1);
lb = [-inf*ones(1,d),zeros(1,n),-inf]';
ub = [inf*ones(1,n+d+1)]';
% ub=[]
%% Computing z
o=optimset('MaxIter',400,'Display','on');
z =quadprog(H,f,A,b,[],[],lb,ub,[],o);
value =1/2*z'*H*z+f'*z
%% plotting svm line and data in 2 dimensional data
if(d==2)
syms x y
figure;
h=ezplot([x,y,1]*[z(1),z(2),z(end)]'==0,[-20 max(data(:)+20)]);
set(h,'Color','k');
hold on
plot(dataT(:,1),dataT(:,2),'LineStyle','none','Marker','+','Color','b');
plot(dataF(:,1),dataF(:,2),'LineStyle','none','Marker','+','Color','r');
end
