%% 最短距离变为走时差数据,单位为ms
clear all;
clc;
% 数据加载
data=xlsread('travel_distance_difference.xlsx');
% 读取最短距离数据
travel_distance_difference=data(:,4:227);
% 设置波速
v=500; % 花岗岩波速4900m/s,换算单位为490cm/ms
data1=travel_distance_difference./v;
% 保存数据
xlswrite('travel_time_difference_5000.xlsx',data1,'sheet1','D1')
