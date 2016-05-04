function [ X ] = Reconstructor(x1,x2,p1,p2,fund,method)
%% function [ X ] = 3dReconstructor(x1,x2,p1,p2)
%   Detailed explanation goes here
    if method=='l'
        X = zeros(4,size(x1,2));
        for i=1:size(x1,2)
            A = [x1(1,i)*p1(3,:)-p1(1,:); 
                x1(2,i)*p1(3,:)-p1(2,:);
                x2(1,i)*p2(3,:)-p2(1,:); 
                x2(2,i)*p2(3,:)-p2(2,:);];
            [U D V] = svd(A);
            X(:,i) = V(:,end);
            X(:,i)=X(:,i)/X(4,i);
        end
    end
    
    if method == 'o'
        x1res =zeros(size(x1));
        x2res = zeros(size(x2));
        syms t;
        for i = 1:size(x1,2)
%                     i
                  T1 = [1,0,-x1(1,i);
                      0,1,-x1(2,i);
                      0,0,1
                      ];
                  T2 = [1,0,-x2(1,i);
                      0,1,-x2(2,i);
                      0,0,1
                      ];
                  F = inv(T2)'*fund*inv(T1)';
                  e1=null(F);
                  e2 = null(F');
                  e1 = e1/sqrt(e1(1)^2+e1(2)^2);
                  e2 = e2/sqrt(e2(1)^2+e2(2)^2);
                  R1 = [e1(1),e1(2),0;
                      -e1(2),e1(1),0;
                      0,0,1];
                  R2 =[e2(1),e2(2),0;
                      -e2(2),e2(1),0;
                      0,0,1];
                  F = R2*F*R1';
                  f1 = e1(3);
                  f2 = e2(3);
                  a = F(2,2);
                  b = F(2,3);
                  c = F(3,2);
                  d = F(3,3);
                  
                  eqn = (t*(((a*t+b)^2)+(f2^2)*(c*t+d)^2)^2)- (a*d-b*c)*((1+(f1^2)*(t^2))^2)*(a*t+b)*(c*t+d)==0;
                  sol = solve(eqn,t);
                  sol = vpa(sol);
                  sol = real(sol);
                  costFunction = ((sol.^2)./(1+f1^2*sol.^2))+((c*sol+d).^2./((a*sol+b).^2+(f2^2)*(c*sol+d).^2));
    %               res = costFunction(sol(1));
                  [~,index ]= min(costFunction);
                  tmin = sol(index);
                  l1 = [tmin*f1,1,-tmin];
                  l2 = F*[0,tmin,1]';
                  x1bar = [-l1(1)*l1(3),-l1(2)*l1(3),l1(1)^2+l1(3)^2]';
                  x2bar = [-l2(1)*l2(3),-l2(2)*l2(3),l2(1)^2+l2(3)^2]';
                  x1bar = inv(T1)*R1'*x1bar;
                  x1bar = x1bar/x1bar(3);
                  x2bar = inv(T2)*R2'*x2bar;
                  x2bar = x2bar/x2bar(3);
                  x1res(:,i)=x1bar(1:2);
                  x2res(:,i)=x2bar(1:2);
%                     if(i==50)
%                         i
%                     end
%                    x1res(:,i)
        end
        X= Reconstructor(x1res,x2res,p1,p2,fund,'l');
        
    end


end

