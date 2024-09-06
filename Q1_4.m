clc
clear
close all;
data = xlsread('售价销量成本亩产表.xlsx');
load("popu_mode2.mat");
set = popu{1,1};
lables = {'黄豆','黑豆','红豆','绿豆','爬豆','小麦','玉米','谷子','高粱','黍子','荞麦','南瓜','红薯','莜麦','大麦','水稻','豇豆','刀豆','芸豆','土豆','西红柿','茄子','菠菜 ','青椒','菜花','包菜','油麦菜','小青菜','黄瓜','生菜 ','辣椒','空心菜','黄心菜','芹菜','大白菜','白萝卜','红萝卜','榆黄菇','香菇','白灵菇','羊肚菌'};
YEAR = [2024,2025,2026,2027,2027,2029,2030];
figure; % 创建一个新图形窗口  
for year = 1:7 % 遍历每年  
    V = zeros(1, 41); % 初始化产量向量  
    for p = 1:41  
        for L = 1:81  
            V(p) = V(p) + set{1, year}(L, p) * data(5, p); % 累加每年的产量  
        end  
    end  
      
    % 找到非零值的索引  
    nonZeroIdx = V > 0;  
      
    % 提取非零值用于绘制条形图  
    sorted_V_nonzero = sort(V(nonZeroIdx), 'descend');  
    sorted_V_indices = find(nonZeroIdx); % 获取非零值在原V中的索引，但这里我们实际用不到，因为sorted_V_nonzero已经排序  
      
    % 注意：sorted_V_indices在这里不能直接用于xticklabels，因为它已经排序并可能不包含所有索引  
    % 我们需要保留原始索引与lables的对应关系  
      
    % 但为了绘制，我们只使用sorted_V_nonzero  
      
    % 使用 subplot 创建子图  
    subplot(3, 3, year);  
    bar(sorted_V_nonzero); % 绘制非零值的条形图  
      
    % 设置子图的标题和标签  
    title(sprintf('%d年', YEAR(year)));  
    xlabel('作物', 'FontSize', 8);  
    ylabel('产量', 'FontSize', 15);  
      
    % 设置 x 轴标签  
    % 由于我们只绘制了非零值，但想保留所有作物的标签，我们需要创建一个自定义的xticks和xticklabels  
    % 但xticks应该与绘制的条形图数量一致，而xticklabels应该包含所有作物的标签  
    % 这里我们使用NaN作为占位符来模拟缺失的条形图（但通常不推荐，因为它在MATLAB中不直接支持）  
    % 更简单的方法是让xticks与sorted_V_nonzero的长度一致，但xticklabels包含所有作物  
    % 我们可以通过在xticklabels中重复非零索引的标签或添加空字符串/占位符来实现这一点  
    % 但为了简单起见，我们只设置与sorted_V_nonzero长度相同的xticks，并在需要时解释标签  
      
    % 设置xticks和xticklabels  
    xticks(1:length(sorted_V_nonzero));  
    % 这里我们直接使用sorted_V_indices（虽然它未排序且可能包含间隙，但在这个场景下我们实际上不需要排序的索引）  
    % 来找到对应的lables索引。但由于我们只绘制了非零值，我们可以简单地使用lables的子集。  
    % 但是，由于xticks的长度可能与lables不同，我们需要确保不越界  
    sorted_lables_nonzero = lables(nonZeroIdx);  
    % 如果sorted_lables_nonzero比xticks短（理论上不应该，但以防万一），我们可以截断它  
    sorted_lables_nonzero = sorted_lables_nonzero(1:length(sorted_V_nonzero));  
    xticklabels(sorted_lables_nonzero);  
      
    % 旋转x轴标签以避免重叠（可选）  
    xtickangle(45);  
end  
  
% sgtitle('Annual Feature Importance by Yield'); % 为整个图形窗口设置总标题（可选）
