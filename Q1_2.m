clc
clear
close all;
data = xlsread('附件2.xlsx','2023年的农作物种植情况');
data = data(:,[1 5 4 6]); %作物 季次 面积 土地类型

data2 = xlsread('附件2.xlsx','2023年统计的相关数据');
data2 = data2(:,[2 4 5 6]); %作物 土地类型 季次 亩产

set = data; %作物 季次 面积 土地类型 亩产
for i=1:size(data,1)
    p = data(i,1); %记录植物
    L = data(i,4); %记录土地
    s = data(i,2); %记录季次
    for ii=1:size(data2,1)
        if data2(ii,1)==p && data2(ii,2) == L && data2(ii,3) == s
            set(i,5) = data2(ii,4);
        end
    end
end

V = []; %存销量

for i=1:41 %遍历41种蔬菜
    for ii=1:size(set,1)
        if set(ii,1)==i %找到了蔬菜
            if set(ii,2) == 0 %如果是单季种植
                V(1,i) = 0;
                V(2,i) = set(ii,3)*set(ii,5);
                break
            else %如果不是单季种植
                V(set(ii,2),i) = set(ii,3)*set(ii,5);
            end
        end
    end
end

V = 0.9*V;

