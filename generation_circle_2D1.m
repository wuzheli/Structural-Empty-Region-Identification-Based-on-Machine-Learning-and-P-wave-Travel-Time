%% 在l*w的矩形中，生成所有可能的圆,x坐标和y坐标在[6,44],半径为最小为5
clear all;
clc;
% 生成所有圆孔
l=50;
w=50;
data_circle=[];
if l>w||l==w
    a=l;
    b=w;
else
    a=w;
    b=l;
end
for i=5:l-5
    for j=5:w-5
        for m=5:20
            if m<i && m<j && m<l-i && m<w-j
                circle=[i,j,m];
                data_circle=[data_circle;circle];
            end
        end
    end
end
% 筛选部分圆孔（包含传感器或者传感器位置在圆上的）
sensors=xlsread("sensors.xlsx");
sources=xlsread("sources.xlsx");
point=[sensors;sources];
for ii=1:length(data_circle)
    x1=data_circle(ii,1);
    y1=data_circle(ii,2);
    r1=data_circle(ii,3);
    for jj=1:length(point)
        x2=point(jj,1);
        y2=point(jj,2);
        distance=sqrt((x1-x2).^2+(y1-y2).^2);
        if distance<=r1
            data_circle(ii,:)=[0 0 0];
        end
    end
end
xlswrite("circle.xlsx",data_circle); % 得到的圆孔数据需要进行处理，删除零元素行








