% 点到切线计算方法in 2D  https://www.jinzhun.net/article/content/202001/191/1.html

function [distance,xq00,zq00,xq10,zq10,val]=inputlocation_2D(x0,z0,x1,z1,xc,zc,r)

syms x z xq0 zq0 xq1 zq1

% x0=16;  z0=6;   % source location
% x1=15;  z1=15;  % sensor location
%
% xc=15; zc=10; r=2.5; % Circle center and radius
a=xc;  b=zc;

% % Determine the point is in or out the circle
dist_1=sqrt((x0-xc).^2+(z0-zc).^2);
dist_2=sqrt((x1-xc).^2+(z1-zc).^2);
dist_12=sqrt((x1-x0).^2+(z1-z0).^2);

angle_C01=acos((dist_1.^2+dist_12.^2-dist_2.^2)/(2*dist_1*dist_12));
angle_C10=acos((dist_2.^2+dist_12.^2-dist_1.^2)/(2*dist_2*dist_12));

% Determine the line is intersection line or outside the circle
if x0==x1
   B=0; A=1; C=-x1;
else
    k=(z1-z0)/(x1-x0);  % The slope between source location and sensor location
    if abs(-k*x0+z0)<0.01
        CC=0;
    else
        CC=-k*x0+z0;
    end
    
    z=k*(x-x0)+z0; % line equation
    if k==0  
        B=1; A=0; C=-z0;
    elseif k~=0  && CC==0
        line_coeff=coeffs(z);
        B=1; A=-line_coeff(1); C=0;
    else
        line_coeff=coeffs(z);
        B=1; A=-line_coeff(2); C=-line_coeff(1);   
    end
end

d=abs(A*a+B*b+C)/sqrt(A.^2+B.^2); % The distance between circle center and above line

% Determine the relationship between the line and circle
if d<r && angle_C01<pi/2 && angle_C10<pi/2
    val=0;
else
    val=1;
end

if val==0
    
    % Calculate the first pointcut
    eq1=(x0-xc)*(xq0-xc)+(z0-zc)*(zq0-zc)-r.^2;
    eq2=(xq0-xc).^2+(zq0-zc).^2-r.^2;
    [xq0 zq0]=solve(eq1,eq2,xq0,zq0);
    
    %  Calculate the second pointcut
    eq3=(x1-xc)*(xq1-xc)+(z1-zc)*(zq1-zc)-r.^2;
    eq4=(xq1-xc).^2+(zq1-zc).^2-r.^2;
    [xq1 zq1]=solve(eq3,eq4,xq1,zq1);
    
    % Calculate the smallest travel distance from four combinations
    for i=1:2
        for j=1:2
            dist0_1=sqrt((xq0(i)-x0).^2+(zq0(i)-z0).^2);
            dist1_1=sqrt((xq1(j)-x1).^2+(zq1(j)-z1).^2);
            dist_xq01=sqrt((xq0(i)-xq1(j)).^2+(zq0(i)-zq1(j)).^2);
            sita_01=asin(0.5*dist_xq01/r);
            arc_xq01=r*2*sita_01;
            all_dist_01(i,j)=dist0_1+dist1_1+arc_xq01;
        end
    end
    
    all_dist_01=subs(all_dist_01);
    distance=min(min(all_dist_01));
    [row column]=find(all_dist_01==min(min(all_dist_01))); % The position corresponding to the minimum value
    xq00=xq0(row(1));
    zq00=zq0(row(1));
    xq10=xq1(column(1));
    zq10=zq1(column(1));

else
    distance=sqrt((x1-x0).^2+(z1-z0).^2);
    xq00=0;
    zq00=0;
    xq10=0;
    zq10=0;
end
