clc
clear
close all;
data = xlsread('售价销量成本亩产表.xlsx');
Area = xlsread('附件1.xlsx');
%% 定义参数
ITER=800;
PC=0.7;
PM=0.3;
NIND=30;
mode = 2;
%% 初始化
[popu]=initialization(NIND,data,Area);
[obj]=fitness(popu,data,mode);
obj_record=max(obj);
%% 进入循环
for iter=1:ITER
    [croed_popu]=crossover(popu,PC,Area);
    [mued_popu]=mutation(croed_popu,PM,Area);
    [obj]=fitness(mued_popu,data,mode);
    [popu,obj]=selection(mued_popu,obj,NIND);
    obj_record=[obj_record;max(obj)];
end
