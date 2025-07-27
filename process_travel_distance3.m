%% 处理数据
clear all;
clc;
% 数据加载
data_all=load('travel_distance.txt');
travel_distance=data_all(:,1:8);
num=1;
for i=1:8
    travel_distance_difference(:,i)=travel_distance(:,i)-travel_distance(:,num);
end
travel_distance_difference(:,num)=[];
% 计算数据的行数
[r,c]=size(travel_distance_difference);
data1=[];
for i=1:32:r-31
    A=travel_distance_difference(i:i+31,:);
    B=A';
    C=B(:)';
    data1=[data1;C];
end
% 保存数据
xlswrite('travel_distance_difference.xlsx',data1,'sheet1','D1')
