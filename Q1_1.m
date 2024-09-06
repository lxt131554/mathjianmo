clc
clear
close all;
data = xlsread('附件2.xlsx','2023年统计的相关数据');
data = data(:,[2 5 9 7 6]);
price = []; 

for i=1:41 %遍历41种蔬菜
    for ii=1:size(data,1)
        if data(ii,1)==i %找到了蔬菜
            if data(ii,2) == 0 %如果是单季种植
                price(1,i) = 0;
                price(2,i) = data(ii,3);
                break
            else %如果不是单季种植
                price(data(ii,2),i) = data(ii,3);
            end
        end
    end
end

cost = []; 

for i=1:41 %遍历41种蔬菜
    for ii=1:size(data,1)
        if data(ii,1)==i %找到了蔬菜
            if data(ii,2) == 0 %如果是单季种植
                cost(1,i) = 0;
                cost(2,i) = data(ii,4);
                break
            else %如果不是单季种植
                cost(data(ii,2),i) = data(ii,4);
            end
        end
    end
end

O = []; %存亩产

for i=1:41 %遍历41种蔬菜
    for ii=1:size(data,1)
        if data(ii,1)==i %找到了蔬菜
            if data(ii,2) == 0 %如果是单季种植
                O(1,i) = 0;
                O(2,i) = data(ii,5);
                break
            else %如果不是单季种植
                O(data(ii,2),i) = data(ii,5);
            end
        end
    end
end