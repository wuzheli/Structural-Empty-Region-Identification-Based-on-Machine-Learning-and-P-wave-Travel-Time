%% 走时数据加噪音（1us、2us、3us、4us、5us）
clear all;
clc;
% 加载数据
data_all=xlsread('travel_time_difference.xlsx');
data=data_all(:,4:227);
[r,c]=size(data);
% 生成随机误差
noise1=0.0001*randi([-10,10],r,c);
noise2=0.0001*randi([-20,20],r,c);
noise3=0.0001*randi([-30,30],r,c);
noise4=0.0001*randi([-40,40],r,c);
noise5=0.0001*randi([-50,50],r,c);
% 误差加入走时数据
data1=data+noise1;
data2=data+noise2;
data3=data+noise3;
data4=data+noise4;
data5=data+noise5;
xlswrite('travel_time_difference_1.xlsx',data1,'sheet1','D1')
xlswrite('travel_time_difference_2.xlsx',data2,'sheet1','D1')
xlswrite('travel_time_difference_3.xlsx',data3,'sheet1','D1')
xlswrite('travel_time_difference_4.xlsx',data4,'sheet1','D1')
xlswrite('travel_time_difference_5.xlsx',data5,'sheet1','D1')