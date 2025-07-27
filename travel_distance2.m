%% 生成理论最短距离
clear all;
clc;           
tic;
%% 设置传感器位置和圆孔位置
% 读取震源的坐标
sources=xlsread("sources.xlsx");
x_sources=sources(1:end,1);
y_sources=sources(1:end,2); 
% 读取圆的坐标和半径
circle=xlsread("circle.xlsx");
x_circle=circle(1:end,1);
y_circle=circle(1:end,2);
r_circle=circle(1:end,3);
% 读取传感器位置坐标
sensors=xlsread("sensors.xlsx");
x_sensors=sensors(1:end,1);
y_sensors=sensors(1:end,2);
%% 计算距离并将其保存至txt文本
fid=fopen("travel_distance.txt","w");
for i=1:length(circle) 
    xc=x_circle(i);
    yc=y_circle(i); 
    r=r_circle(i);
    for j=1:length(x_sources)
        x0=x_sources(j);
        y0=y_sources(j);
        for m=1:length(x_sensors)
            x1=x_sensors(m);
            y1=y_sensors(m);
            [distance,xq00,zq00,xq10,zq10,val]=inputlocation_2D(x0,y0,x1,y1,xc,yc,r);
            fprintf(fid,"%g\t",distance);
        end
        fprintf(fid,"%g\n",'');
    end
end
fclose(fid);
%% 计算时长
toc;
disp(['程序总运行时间：',num2str(toc)]);
