function [] = data_label(ratio)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

% clear;clc;
load cap_data.mat
% load xiezi.mat

% cap_num=size(cap_data,1);
% cap_data=cap_data_all;
% ratio=ratio1;
n=20;%每个动作重复的数目
%  ratio=0.7;
X_ratio=n*ratio;
Y_ratio=fix(n-X_ratio);

XT_num=cap_num*ratio;
XV_num=fix(cap_num*(1-ratio));

TTrain=NaN(XT_num,1);
TValidation =NaN(XV_num,1);
TTrain = categorical(TTrain);
TValidation = categorical(TValidation);

TTrain_all=NaN(cap_num,1);
TTrain_all = categorical(TTrain_all);

% A=1:cap_num/n;
% XT_numvalueset=1:n:XT_num;
%打标签
for i=1:cap_num/n
    for j=1:X_ratio
        TTrain((i-1)*X_ratio+j,1)=num2str(i);
    end
    for j=1:fix(Y_ratio)
        TValidation((i-1)*Y_ratio+j,1)=num2str(i);
    end
   for j=1:n
        TTrain_all((i-1)*n+j,1)=num2str(i);
    end
end

num_xunhuan=20; %一个动作连续做的次数
num_kind=26;%动作输出种类
num_cycle=cap_num/num_kind/num_xunhuan;

for jj=1:num_kind
for ii=1:num_cycle
   cap_data_new((ii-1)*num_xunhuan+(jj-1)*num_xunhuan*num_cycle+1:ii*num_xunhuan+(jj-1)*num_xunhuan*num_cycle,1 ...
       )= cap_data((ii-1)*num_xunhuan*num_kind+(jj-1)*num_xunhuan+1:(ii-1)*num_xunhuan*num_kind+jj*num_xunhuan,1);
%    cap_data_new2((ii-1)*10+(jj-1)*10*4+1:ii*10+(jj-1)*10*4,1)= cap_data((ii-1)*10*26+(jj-1)*10+1:(ii-1)*10*26+jj*10,1);

end
end

%数据分类
all_num=1:cap_num;

for i=1:cap_num/n
    p=randperm(n);
    a=p(1:Y_ratio);
    a=(i-1)*n+a;
    XV_num(1,Y_ratio*(i-1)+1:Y_ratio*i)=a;
end
% Y_ratio=2;
% for i=1:24*4
%     p=randperm(9);
%     a=p(1:Y_ratio);
%     a=(i-1)*10+a;
%     XV_num(1,Y_ratio*(i-1)+1:Y_ratio*i)=a;
% end



 XT_num = setdiff(all_num, XV_num);

 XTrain=cap_data_new(XT_num);
 XValidation=cap_data_new(XV_num);

save('datasheet',"TTrain","TValidation","XValidation","XTrain")

end

