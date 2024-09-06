function [obj]=fitness(popu,data,mode)
obj = [];
for nind = 1:size(popu,2)
    set = popu{1,nind};
    % 计算收入
    income = 0;
    outcome = 0;
    for year = 1:size(set,2) %遍历所有年份
        for s=1:2 %遍历每个季度
            for p=1:41 %遍历每种作物
                % 提售价
                if s==1 %第一季度，只统计两季的
                    price = data(2,p);
                    % 提产量
                    V = 0; %该产量
                    if p>=17 && p<=34
                        for L=1:82 %遍历每块地
                            outcome = outcome + set{1,year}(L,p)*data(4,p);
                            V = V + set{1,year}(L,p)*data(5,p);
                        end
                    else
                        continue
                    end

                else
                    price = data(6,p);
                    % 提产量
                    V = 0; %该产量
                    if p<17||p>34 %都是第二季收获的
                        for L=1:82 %遍历每块地
                            outcome = outcome + set{1,year}(L,p)*data(4,p);
                            V = V + set{1,year}(L,p)*data(5,p);
                        end
                    else %要去掉第一季的
                        for L=55:82 %遍历每块地
                            outcome = outcome + set{1,year}(L,p)*data(4,p);
                            V = V + set{1,year}(L,p)*data(5,p);
                        end
                    end

                end
                % 计算两种模式下的收入
                E = V - data(3,p); %供销差距
                if E<=0 %如果能全卖
                    income = income +  V*price;
                else
                    if mode==1 %如果种多了且是模式1
                        income = income + data(3,p)*price;
                    else %模式2
                        income = income + data(3,p)*data(2,p) + 0.5*E*price; %多余的半价
                    end
                end

            end
        end

    end
    obj(nind,1) = income - outcome;
end
end