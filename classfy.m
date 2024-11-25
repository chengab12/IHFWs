function [results] = classfy()
%CLASSFY 此处显示有关此函数的摘要
%   此处显示详细说明
clear;
%%
% read_serial4();
%%
%识别
load net.mat
load cap_data_cap1to6.mat
class = classify(net,cap_lv_cap1to6);
results=cellstr(class) ;
results=cell2mat(results);
end

