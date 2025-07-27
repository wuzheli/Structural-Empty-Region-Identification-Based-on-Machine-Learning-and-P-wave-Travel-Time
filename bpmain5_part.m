%% BP神经网络——圆孔结构定位
clear all;
clc;
%% 生成训练集和测试集
% 导入数据
[data,ax,ay]=xlsread("travel_time_difference_5.xlsx");
% 构建输入和输出
input_train=data(1:5000,4:227)'; 
output_train=data(1:5000,1:3)';
input_test=data(5001:end,4:227)';
output_test=data(5001:end,1:3)';
% 数据归一化 训练集输入输出，测试集输入
[inputn,ps_input]=mapminmax(input_train,0,1);
[outputn,ps_output]=mapminmax(output_train,0,1);
inputs=mapminmax('apply',input_test,ps_input);
%% 构建BP神经网络，训练测试
% 创建网络
net=newff(inputn,outputn,[12,12,12],{'tansig','purelin'},'trainlm');
% 设置训练参数
net.trainParam.epochs=1000;
net.trainParam.goal=0.001;
net.trainParam.lr=0.01;
% 训练网络
net=train(net,inputn,outputn);
% 仿真测试
outputs=sim(net,inputs);
% 数据反归一化
output_pre=mapminmax('reverse',outputs,ps_output);
%% 性能评价
error=abs(output_pre-output_test);  % 绝对误差
error_r=error./output_test;     % 相对误差
% xlswrite('error_5.xlsx',error');  
%% 结果分析
% x
figure
subplot(1,2,1)
plot(output_pre(1,:),'b-o')
hold on        
plot(output_test(1,:),'g-o')
hold on 
legend('预测输出','期望数据')
title('x坐标的预测值与期望值对比')
ylabel('x')
set(gca,'fontsize',12)

subplot(1,2,2)
plot(error(1,:),'r-o')
hold on
title('x坐标误差')
set(gca,'fontsize',12)
% y
figure
subplot(1,2,1)
plot(output_pre(2,:),'b-o')
hold on
plot(output_test(2,:),'g-o')
hold on 
legend('预测输出','期望数据')
title('y坐标的预测值与期望值对比')
ylabel('y')
set(gca,'fontsize',12)

subplot(1,2,2)
plot(error(2,:),'r-o')
hold on
title('y坐标误差')
set(gca,'fontsize',12)
% r
figure
subplot(1,2,1)
plot(output_pre(3,:),'b-o')
hold on
plot(output_test(3,:),'g-o')
hold on 
legend('预测输出','期望数据')
title('半径r的预测值与期望值对比')
ylabel('r')
set(gca,'fontsize',12)

subplot(1,2,2)
plot(error(3,:),'r-o')
hold on
title('半径r误差')
set(gca,'fontsize',12)
%% 随机挑选三组数据绘图，查看测试圆形和实际圆形的位置
% 图1选取测试集第一组数据绘图
x11=output_test(1,1);y11=output_test(2,1);r11=output_test(3,1);
x12=output_pre(1,1);y12=output_pre(2,1);r12=output_pre(3,1);

x21=output_test(1,round(size(output_test,2)/2));y21=output_test(2,round(size(output_test,2)/2));r21=output_test(3,round(size(output_test,2)/2));
x22=output_pre(1,round(size(output_test,2)/2));y22=output_pre(2,round(size(output_test,2)/2));r22=output_pre(3,round(size(output_test,2)/2));

x31=output_test(1,end);y31=output_test(2,end);r31=output_test(3,end);
x32=output_pre(1,end);y32=output_pre(2,end);r32=output_pre(3,end);
figure
grid on
axis([0,50,0,50])
rectangle("Position",[x11-r11,y11-r11,2*r11,2*r11],"Curvature",[1,1],'EdgeColor','g')
rectangle("Position",[x12-r12,y11-r12,2*r12,2*r12],"Curvature",[1,1],'EdgeColor','r')
axis equal

% 图2选取测试集中间一组数据绘图
figure
grid on
axis([0,50,0,50])
rectangle("Position",[x21-r21,y21-r21,2*r21,2*r21],"Curvature",[1,1],'EdgeColor','g')
rectangle("Position",[x22-r22,y21-r22,2*r22,2*r22],"Curvature",[1,1],'EdgeColor','r')
axis equal
% 图3选取测试集最后一组数据绘图
figure
grid on
axis([0,50,0,50])
rectangle("Position",[x31-r31,y31-r31,2*r31,2*r31],"Curvature",[1,1],'EdgeColor','g')
rectangle("Position",[x32-r32,y31-r32,2*r32,2*r32],"Curvature",[1,1],'EdgeColor','r')
axis equal
%% 保存训练模型
save('BPnetwork.mat','net');
